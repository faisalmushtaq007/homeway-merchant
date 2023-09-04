import 'package:cross_file/cross_file.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:faker/faker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart';
import 'package:homemakers_merchant/app/features/chat/index.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';

class LoginFirebaseUser {
  String token = '';

  String generateToken() {
    final jwt = JWT(
      {
        "id": "1234",
        "alg": "rsa256",
        "auth": "547533381",
        "server": {
          "id": "merchant-dev",
          "loc": "euw-2",
        },
        "iss": "prasant10050@gmail.com",
        "sub": "prasant10050@gmail.com",
        "aud": "https://identitytoolkit.googleapis.com/google.identity.identitytoolkit.v1.IdentityToolkit",
        "iat": 1693835824,
        "exp": 1694161618,
        "uid": "1234"
      },
      issuer: "prasant10050@gmail.com",
      subject: "prasant10050@gmail.com",
      audience: Audience(["https://identitytoolkit.googleapis.com/google.identity.identitytoolkit.v1.IdentityToolkit"]),
    );

    // Sign it

    final pem = File('secrets/rsa_private.pem').readAsStringSync();
    final key = RSAPrivateKey(pem);

    token = jwt.sign(key, algorithm: JWTAlgorithm.RS256);

    print('Signed token: $token\n');
    return token;
  }

  void verifyToken(String token) {
    try {
      // Verify a token
      final pem = File('secrets/rsa_public.pem').readAsStringSync();
      final key = RSAPublicKey(pem);

      final jwt = JWT.verify(token, key);

      print('Payload: ${jwt.payload}');
    } on JWTExpiredException {
      print('jwt expired');
    } on JWTException catch (ex) {
      print(ex.message); // ex: invalid signature
    }
  }

  Future<UserCredential?> loginWithFirebaseCustomToken(String token) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithCustomToken(token);
      print("Sign-in successful.");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-custom-token":
          print("The supplied token is not a Firebase custom auth token.");
          break;
        case "custom-token-mismatch":
          print("The supplied token is for a different Firebase project.");
          break;
        default:
          print("Unkown error.");
      }
      return null;
    }
  }

  Future<void> registerUser() async {
    String token = await generateToken();
    final userCredential = await loginWithFirebaseCustomToken(token);
    if (userCredential.isNotNull) {
      final faker = Faker();
      String _firstName = faker.person.firstName();
      String _lastName = faker.person.lastName();
      String _email = '${_firstName.toLowerCase()}.${_lastName.toLowerCase()}@${faker.internet.domainName()}';
      await FirebaseChatCore.instance.createUserInFirestore(
        ChatUser(
          firstName: _firstName,
          id: userCredential?.user!.uid ?? '',
          imageUrl: 'https://i.pravatar.cc/300?u=$_email',
          lastName: _lastName,
        ),
      );
    } else {
      print("RegisterUser failed");
    }
  }
}
