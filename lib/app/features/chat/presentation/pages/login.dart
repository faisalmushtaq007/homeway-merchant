import 'dart:async';
import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart';
import 'package:homemakers_merchant/app/features/chat/index.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:http/http.dart' as http;

class LoginFirebaseUser {
  String token = '';

  Future<String> generateToken() async {
    final jwt = JWT({
      "id": "1234567890",
      "auth": "547533381",
      "iat": 1693835824,
      "exp": 1694161618,
      "uid": "1234567890",
    },
        header: {
          "alg": "rsa256",
          "typ": "JWT"
        },
        issuer: "prasant10050@gmail.com",
        audience: Audience(["https://identitytoolkit.googleapis.com/google.identity.identitytoolkit.v1.IdentityToolkit"]),
        subject: "prasant10050@gmail.com",
        jwtId: "1234567890");

    // Sign it
    final privatePem = await rootBundle.loadString('assets/secrets/rsa_private.pem');
    //final pem = File('secrets/rsa_private.pem').readAsStringSync();
    final key = RSAPrivateKey(privatePem);

    token = jwt.sign(key, algorithm: JWTAlgorithm.RS256);

    print('Signed token: $token\n');
    return token;
  }

  Future<void> verifyToken(String token) async {
    try {
      // Verify a token

      final publicPem = await rootBundle.loadString('assets/secrets/rsa_public.pem');
      //final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
      //final pem = File('secrets/rsa_public.pem').readAsStringSync();
      final key = RSAPublicKey(publicPem);

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

  Future<void> registerUser(String uid, {bool isCurrentUser = true}) async {
    final url = Uri.parse("http://192.168.0.105:3000/users/token?uid=${uid}");
    http.Response response = await http.get(url);
    print("response ${response.statusCode}, ${response.body}");
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    String token = data['auth_token'];
    print("token ${token}");

    final userCredential = await loginWithFirebaseCustomToken(token);
    if (userCredential.isNotNull) {
      final faker = Faker();
      String _firstName = faker.person.firstName();
      String _lastName = faker.person.lastName();
      String _email = '${_firstName.toLowerCase()}.${_lastName.toLowerCase()}@${faker.internet.domainName()}';
      // Get Token
      final fcmToken = await FirebaseMessaging.instance.getToken();
      //todo(Prasant): To be notified whenever the token is updated, subscribe to the onTokenRefresh stream:

      /*FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        // TODO: If necessary send token to application server.

        // Note: This callback is fired at each app startup and whenever a new
        // token is generated.
      }).onError((err) {
        // Error getting token.
      });*/
      await FirebaseChatCore.instance.createUserInFirestore(
        ChatUser(
          firstName: _firstName,
          id: userCredential?.user!.uid ?? '',
          imageUrl: 'https://i.pravatar.cc/300?u=$_email',
          lastName: _lastName,
          pushToken: fcmToken ?? '',
        ),
      );
    } else {
      print("RegisterUser failed");
    }
  }
}
