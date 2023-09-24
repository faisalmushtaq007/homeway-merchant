part of 'package:homemakers_merchant/app/features/chat/index.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  _RoomsPageController createState() => _RoomsPageController();
}

class _RoomsPageController extends State<RoomsPage> {
  bool _error = false;
  bool _initialized = false;
  User? _user;
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  late final AppLifecycleListener _listener;
  late AppLifecycleState? _state;

  @override
  void initState() {
    initializeFlutterFire();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();

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
      final (ConnectivityPlusState?, InternetConnectivityState?) result =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (result.$2 == InternetConnectivityState.internet) {
        await FirebaseChatCore.instance.updateUserActiveStatus();
        return;
      } else {
        await FirebaseChatCore.instance.updateUserActiveStatus(status: false);
        return;
      }
    } catch (e) {
      setState(() {
        _error = true;
      });
      await LoginFirebaseUser().registerUser('547538599');
      await initializeFlutterFire();
    }
  }

  void _handleTransition(String name) {}

  Future<void> _handleStateChange(AppLifecycleState state) async {
    setState(() {
      _state = state;
    });
    if (_state == AppLifecycleState.resumed) {
      final (ConnectivityPlusState?, InternetConnectivityState?) result =
          serviceLocator<ConnectivityService>().getCurrentInternetStatus();
      if (result.$2 == InternetConnectivityState.internet) {
        await FirebaseChatCore.instance.updateUserActiveStatus();
        return;
      } else {
        await FirebaseChatCore.instance.updateUserActiveStatus(status: false);
        return;
      }
    } else if (_state == AppLifecycleState.paused) {
      await FirebaseChatCore.instance.updateUserActiveStatus(status: false);
      return;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _buildAvatar(Room room) {
    var color = Colors.transparent;
    ChatUser user = ChatUser(id: '');
    if (room.type == RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );
        user = otherUser;
        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';
    print('User Online ${user.isOnline}');
    return AdvancedAvatar(
      statusColor: user.isOnline ? Colors.green : null,
      foregroundDecoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: user.isOnline
              ? Colors.green.withOpacity(0.75)
              : Colors.grey.withOpacity(0.75),
          width: 2,
        ),
      ),
      imagePath: room.imageUrl!,
      size: 48,
      name: name.isEmpty ? '' : name[0].toUpperCase(),
    );
  }

  @override
  Widget build(BuildContext context) => _RoomsPageView(this);

  @override
  void dispose() {
    _listener.dispose();
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }
}

class _RoomsPageView extends WidgetView<RoomsPage, _RoomsPageController> {
  const _RoomsPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: state._user == null
                    ? null
                    : () async {
                        final math.Random random = math.Random();
                        final number = random.nextIntOfDigits(4);
                        await LoginFirebaseUser().registerUser('54753${number}',
                            isCurrentUser: false);
                        //await initializeFlutterFire();
                      },
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: state._user == null ? null : state.logout,
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: Text(
              'Rooms',
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
            ),
          ),
          drawer: const PrimaryDashboardDrawer(
            key: Key('chat-rooms-drawer'),
            isMainDrawerPage: false,
          ),
          body: SlideInLeft(
            key: const Key('chat-rooms-slideinleft-widget'),
            from: context.width / 2 - 60,
            duration: const Duration(milliseconds: 500),
            child: Directionality(
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height -
                      (media.padding.top +
                          kToolbarHeight +
                          media.padding.bottom),
                ),
                padding: EdgeInsetsDirectional.only(
                  top: topPadding,
                  //bottom: bottomPadding,
                  start: margins * 2.5,
                  end: margins * 2.5,
                ),
                child: state._user == null
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not authenticated',
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            ),
                            TextButton(
                              onPressed: () async {
                                await LoginFirebaseUser()
                                    .registerUser('547533381');
                                await state.initializeFlutterFire();
                              },
                              child: Text(
                                'Login',
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                              ),
                            ),
                          ],
                        ),
                      )
                    : AsyncBuilder<List<Room>>(
                        stream: FirebaseChatCore.instance.rooms(),
                        initial: const [],
                        key: const Key('chat-user-rooms-stream-widget'),
                        keepAlive: true,
                        waiting: (context) => Container(
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text('Loading...')),
                            ],
                          ),
                        ),
                        builder: (context, value) => CustomScrollView(
                          controller: state.customScrollViewScrollController,
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  AppSearchInputSliverWidget(
                                    key: const Key('chat-room-search-field'),
                                    onChanged: (value) {},
                                  ),
                                  const AnimatedGap(
                                    8,
                                    duration: Duration(milliseconds: 100),
                                  ),
                                ],
                              ),
                            ),
                            SliverFillRemaining(
                              fillOverscroll: true,
                              hasScrollBody: true,
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 200),
                                crossFadeState: value!.isNotNullOrEmpty
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                firstChild: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'No rooms',
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                secondChild: ListView.builder(
                                  itemCount: value!.length,
                                  itemBuilder: (context, index) {
                                    final room = value![index];
                                    return Card(
                                      key: ValueKey(index),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        onTap: () async {
                                          final returnResult =
                                              await context.push(
                                            Routes.CHAT_PAGE,
                                            extra: {'room': room},
                                          );
                                          return;
                                        },
                                        title: Text(
                                          room.name ?? '',
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                        ),
                                        subtitle: (room
                                                    .lastMessages.isNotNull &&
                                                room.lastMessages?.last.type ==
                                                    types.MessageType.text)
                                            ? Text(
                                                '${room.lastMessages!.last as types.TextMessage..text}')
                                            : null,
                                        leading: state._buildAvatar(room),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        error: (context, error, stackTrace) =>
                            Text('Error! $error'),
                        closed: (context, value) => Text('$value (closed)'),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
