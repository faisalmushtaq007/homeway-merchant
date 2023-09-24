part of 'package:homemakers_merchant/app/features/chat/index.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  bool _error = false;
  bool _initialized = false;
  User? _user;
  late final AppLifecycleListener _listener;
  late AppLifecycleState? _state;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
    _state = SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      onShow: () => _handleTransition('show'),
      onResume: () => _handleTransition('resume'),
      onHide: () => _handleTransition('hide'),
      onInactive: () => _handleTransition('inactive'),
      onPause: () => _handleTransition('pause'),
      onDetach: () => _handleTransition('detach'),
      onRestart: () => _handleTransition('restart'),
      // This fires for each state change. Callbacks above fire only for
      // specific state transitions.
      onStateChange: _handleStateChange,
    );
  }

  Future<void> initializeFlutterFire() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _user = user;
        });
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  void _handleTransition(String name) {}

  Future<void> _handleStateChange(AppLifecycleState state) async {
    setState(() {
      _state = state;
    });
    if (_state == AppLifecycleState.resumed) {
      return await FirebaseChatCore.instance
          .updateUserActiveStatus(status: true);
    } else if (_state == AppLifecycleState.paused) {
      return await FirebaseChatCore.instance
          .updateUserActiveStatus(status: false);
    }
  }

  Widget _buildAvatar(BuildContext context, ChatUser user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return CircleAvatar(
      backgroundColor: hasImage ? Colors.transparent : color,
      radius: 20,
      child: hasImage
          ? ImageHelper(
              image: user.imageUrl!,
              filterQuality: FilterQuality.high,
              borderRadius: BorderRadiusDirectional.circular(10),
              imageType: findImageType(user.imageUrl!),
              imageShape: ImageShape.rectangle,
              boxFit: BoxFit.cover,
              defaultErrorBuilderColor: Colors.blueGrey,
              errorBuilder: const Icon(
                Icons.image_not_supported,
                size: 10000,
              ),
              loaderBuilder: const CircularProgressIndicator(),
              matchTextDirection: true,
              placeholderText: name ?? '',
              placeholderTextStyle: context.labelLarge!.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            )
          : Text(
              name.isEmpty ? '' : name[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
            ),
    );
  }

  Future<void> _handlePressed(ChatUser otherUser, BuildContext context) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    //navigator.pop();
    if (!mounted) {
      return;
    }
    final returnData =
        await context.push(Routes.CHAT_PAGE, extra: {'room': room});
    return;
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Container();
    }

    if (!_initialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          'Users',
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _user == null
                ? null
                : () async {
                    math.Random random = math.Random();
                    final number = random.nextIntOfDigits(4);
                    await LoginFirebaseUser()
                        .registerUser('54753${number}', isCurrentUser: false);
                    //await initializeFlutterFire();
                  },
          ),
        ],
      ),
      body: _user == null
          ? SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not authenticated',
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                    ),
                    TextButton(
                      onPressed: () async {
                        await LoginFirebaseUser().registerUser('547538599');
                        await initializeFlutterFire();
                      },
                      child: Text(
                        'Login',
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : StreamBuilder<List<ChatUser>>(
              stream: FirebaseChatCore.instance.users(),
              initialData: const [],
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      bottom: 200,
                    ),
                    child: Text(
                      'No users',
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                    ),
                  );
                }

                return CustomScrollView(
                  slivers: [
                    AppSearchInputSliverWidget(
                      key: const Key('chat-user-search-widget'),
                      onChanged: (value) {},
                    ),
                    Flexible(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final user = snapshot.data![index];
                          return Card(
                            margin: const EdgeInsetsDirectional.only(
                              bottom: 8,
                            ),
                            child: ListTile(
                              key: ValueKey(index),
                              leading: _buildAvatar(context, user),
                              title: Text(
                                getUserName(user),
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                              ),
                              onTap: () async {
                                await _handlePressed(user, context);
                                return;
                              },
                            ),
                          );
                          return InkWell(
                            onTap: () async {
                              await _handlePressed(user, context);
                              return;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  _buildAvatar(context, user),
                                  Text(
                                    getUserName(user),
                                    textDirection:
                                        serviceLocator<LanguageController>()
                                            .targetTextDirection,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
