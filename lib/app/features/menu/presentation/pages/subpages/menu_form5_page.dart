part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm5Page extends StatefulWidget {
  const MenuForm5Page({super.key});

  @override
  State<MenuForm5Page> createState() => _MenuForm5PageState();
}

class _MenuForm5PageState extends State<MenuForm5Page> {
  late final ScrollController scrollController;
  List<File>? file_images = [];
  List<XFile> cross_file_images = [];
  String selectedMenuImage = '';
  XFile selectedMenuFileImage = XFile('');
  List<String> listOfMenuRemoteImages = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    file_images = [];
    cross_file_images = [];
    listOfMenuRemoteImages = [];
    selectedMenuImage = '';
    selectedMenuFileImage = XFile('');
    loadMenuRemoteImage();
  }

  void loadMenuRemoteImage() {
    listOfMenuRemoteImages = [
      'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
      'https://img.freepik.com/premium-photo/chicken-dhum-biriyani-using-jeera-rice-spices-arranged-earthen-ware_527904-513.jpg?size=626&ext=jpg',
      'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52414.jpg?size=626&ext=jpg',
      'https://img.freepik.com/premium-photo/indian-vegetable-pulav-biryani-made-using-basmati-rice-served-terracotta-bowl-selective-focus_466689-55615.jpg',
      'https://img.freepik.com/premium-photo/arabic-food-kabsa-with-chicken-almonds-closeup-plate-generative-ai_779468-4840.jpg?size=626&ext=jpg',
      'https://img.freepik.com/premium-photo/indian-style-meat-dish-mutton-gosht-masala-lamb-rogan-josh-served-bowl-selective-focus_466689-53460.jpg?size=626&ext=jpg',
      'https://img.freepik.com/free-photo/flat-lay-pakistani-food-arrangement_23-2148825110.jpg?size=626&ext=jpg',
      'https://img.freepik.com/free-photo/top-view-tasty-pakistani-dish_23-2148825124.jpg?size=626&ext=jpg',
      'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52345.jpg?size=626&ext=jpg',
      'https://img.freepik.com/free-photo/gourmet-chicken-biryani-with-steamed-basmati-rice-generated-by-ai_188544-13480.jpg?size=626&ext=jpg',
      'https://img.freepik.com/premium-photo/indian-vegetable-pulav-biryani-made-using-basmati-rice-served-terracotta-bowl-selective-focus_466689-55615.jpg?size=626&ext=jpg'
    ];
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    file_images = [];
    cross_file_images = [];
    listOfMenuRemoteImages = [];
    selectedMenuImage = '';
    selectedMenuFileImage = XFile('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: BlocBuilder<MenuBloc, MenuState>(
        key: const Key('menu-form5-page-bloc-builder-widget'),
        bloc: context.watch<MenuBloc>(),
        buildWhen: (previous, current) {
          if (previous is PushMenuEntityDataState && current is PushMenuEntityDataState) {
            if (previous.menuFormStage is MenuForm5Page && current.menuFormStage is MenuForm5Page) {
              return true;
            }
            return false;
          } else if (previous is PullMenuEntityDataState && current is PullMenuEntityDataState) {
            if (previous.menuFormStage is MenuForm5Page && current.menuFormStage is MenuForm5Page) {
              return true;
            }
            return false;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is PushMenuEntityDataState && state.menuFormStage is MenuForm5Page) {}
          if (state is PullMenuEntityDataState && state.menuFormStage is MenuForm5Page) {}
          return Column(
            //controller: scrollController,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Wrap(
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    children: [
                      Text(
                        'Menu Image',
                        style: context.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                  Wrap(
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    children: [
                      Text(
                        'Upload your menu image or select menu theme image',
                        style: context.labelMedium,
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        maxLines: 2,
                        softWrap: true,
                      ).translate(),
                    ],
                  ),
                ],
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              listOfMenuRemoteImages.isNotEmpty && selectedMenuImage.isNotEmpty
                  ? Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        border: BorderDirectional(
                          start: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                          ),
                          end: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                          ),
                          top: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                          ),
                          bottom: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                          ),
                        ),
                        color: Color.fromRGBO(238, 238, 238, 1.0),
                      ),
                      child: Image.network(
                        selectedMenuImage,
                        fit: BoxFit.contain,
                        height: 100,
                        width: 100,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(10),
                            border: BorderDirectional(
                              start: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(238, 238, 238, 1.0),
                              ),
                              end: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(238, 238, 238, 1.0),
                              ),
                              top: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(238, 238, 238, 1.0),
                              ),
                              bottom: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(238, 238, 238, 1.0),
                              ),
                            ),
                            color: Color.fromRGBO(238, 238, 238, 1.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              const Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Color.fromRGBO(201, 201, 203, 1),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Upload menu cover photo',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade400,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.center,
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              ).translate(),
                            ],
                          ),
                        ),
                      ),
                    ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              Wrap(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Text(
                    'Make sure your menu image is clear and visible with jpg or png format',
                    style: context.labelMedium!.copyWith(
                      color: Color.fromRGBO(127, 129, 132, 1),
                    ),
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ).translate(),
                ],
              ),
              const AnimatedGap(18, duration: Duration(milliseconds: 500)),
              Flexible(
                child: CarouselImages(
                  //scaleFactor: 0.9,
                  listImages: listOfMenuRemoteImages,
                  height: 130.0,
                  borderRadius: 10.0,
                  cachedNetworkImage: true,
                  viewportFraction: 0.65,
                  verticalAlignment: Alignment.bottomCenter,
                  onTap: (index) {
                    print('Tapped on page $index');
                    setState(() {
                      selectedMenuImage = listOfMenuRemoteImages[index];
                    });
                    final nameOfurl = Uri.parse(listOfMenuRemoteImages[index]).path.split("/").last;
                    final File file = XFile(listOfMenuRemoteImages[index]);
                    final filename = path.basename(file.path);
                    final nameWithoutExtension = path.basenameWithoutExtension(file.path);
                    final fileExtenion = path.extension(file.path);
                    serviceLocator<MenuEntity>().menuImages = [
                      MenuImage(
                        imageId: '0',
                        assetPath: listOfMenuRemoteImages[index],
                        assetExtension: fileExtenion,
                        metaInfo: {
                          'name': filename,
                        },
                      )
                    ];
                    context.read<MenuBloc>().add(
                          PushMenuEntityData(
                            menuEntity: serviceLocator<MenuEntity>(),
                            menuFormStage: MenuFormStage.form1,
                            menuEntityStatus: MenuEntityStatus.push,
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
