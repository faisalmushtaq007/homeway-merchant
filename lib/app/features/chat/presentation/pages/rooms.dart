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

  @override
  void initState() {
    initializeFlutterFire();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
    super.initState();
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
      await LoginFirebaseUser().registerUser('547533381');
      await initializeFlutterFire();
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _buildAvatar(Room room) {
    var color = Colors.transparent;

    if (room.type == RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _RoomsPageView(this);

  @override
  void dispose() {
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
                        await LoginFirebaseUser()
                            .registerUser('547533382', isCurrentUser: false);
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
                                    onChanged: (value) {

                                    },
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
                                          textDirection:
                                              serviceLocator<LanguageController>()
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

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ChatPage(
                                              room: room,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            state._buildAvatar(room),
                                            Text(
                                              room.name ?? '',
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                            ),
                                          ],
                                        ),
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
