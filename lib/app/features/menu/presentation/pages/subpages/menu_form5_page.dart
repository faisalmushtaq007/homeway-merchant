part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm5Page extends StatefulWidget {
  const MenuForm5Page({
    super.key,
    this.haveNewMenu = true,
    this.menuEntity,
  });
  final bool haveNewMenu;
  final MenuEntity? menuEntity;

  @override
  State<MenuForm5Page> createState() => _MenuForm5PageState();
}

class _MenuForm5PageState extends State<MenuForm5Page>
    with AutomaticKeepAliveClientMixin<MenuForm5Page> {
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
      'https://img.freepik.com/premium-photo/indian-vegetable-pulav-biryani-made-using-basmati-rice-served-terracotta-bowl-selective-focus_466689-55615.jpg?size=626&ext=jpg',
      'https://img.freepik.com/free-photo/front-view-sweet-pancakes-tower-arrangement_23-2148654085.jpg',
      'https://img.freepik.com/free-photo/chocolate-cake-with-whipped-cream-fruits_140725-2715.jpg',
      'https://img.freepik.com/free-photo/dessert-fruitcake_144627-10454.jpg',
      'https://img.freepik.com/free-photo/lime-cocktail-mint-side-view_140725-11289.jpg',
      'https://img.freepik.com/free-photo/grilled-sandwich-with-bacon-fried-egg-tomato-lettuce-served-wooden-cutting-board_1150-42571.jpg',
      'https://img.freepik.com/free-photo/big-sandwich-hamburger-burger-with-beef-red-onion-tomato-fried-bacon_2829-5398.jpg',
      'https://img.freepik.com/free-photo/cup-coffee-with-heart-drawn-foam_1286-70.jpg',
      'https://img.freepik.com/free-photo/greek-salad-with-cucumber-tomato-sweet-pepper-lettuce-green-onion-feta-cheese-olives-with-olive-oil-healthy-food_2829-19692.jpg',
    ];
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    scrollController.dispose();
    /*file_images = [];
    cross_file_images = [];
    listOfMenuRemoteImages = [];
    selectedMenuImage = '';
    selectedMenuFileImage = XFile('');*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: BlocBuilder<MenuBloc, MenuState>(
        key: const Key('menu-form5-page-bloc-builder-widget'),
        bloc: context.watch<MenuBloc>(),
        buildWhen: (previous, current) {
          if (previous is PushMenuEntityDataState &&
              current is PushMenuEntityDataState) {
            if (previous.menuFormStage is MenuForm5Page &&
                current.menuFormStage is MenuForm5Page) {
              return true;
            }
            return false;
          } else if (previous is PullMenuEntityDataState &&
              current is PullMenuEntityDataState) {
            if (previous.menuFormStage is MenuForm5Page &&
                current.menuFormStage is MenuForm5Page) {
              return true;
            }
            return false;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is PushMenuEntityDataState &&
              state.menuFormStage is MenuForm5Page) {}
          if (state is PullMenuEntityDataState &&
              state.menuFormStage is MenuForm5Page) {}
          return Column(
            //controller: scrollController,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Menu Image',
                        style: context.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                  Wrap(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      Text(
                        'Upload your menu image or select menu theme image',
                        style: context.labelMedium,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        maxLines: 2,
                        softWrap: true,
                      ).translate(),
                    ],
                  ),
                ],
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              if (listOfMenuRemoteImages.isNotEmpty &&
                  selectedMenuImage.isNotEmpty)
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      border: Border.all(
                        width: 0.5,
                        color: const Color.fromRGBO(238, 238, 238, 1),
                      ),
                      color: const Color.fromRGBO(238, 238, 238, 1),
                    ),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ImageHelper(
                            image: selectedMenuImage,
                            filterQuality: FilterQuality.high,
                            borderRadius: BorderRadiusDirectional.circular(10),
                            imageType: findImageType(selectedMenuImage),
                            imageShape: ImageShape.rectangle,
                            width: 150,
                            height: 150,
                            boxFit: BoxFit.cover,
                            defaultErrorBuilderColor: Colors.blueGrey,
                            errorBuilder: const Icon(
                              Icons.image_not_supported,
                              size: 10000,
                            ),
                            // loader builder widget, default as icon if null
                            loaderBuilder: const CircularProgressIndicator(),
                            matchTextDirection: true,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            return await uploadMenuImage(context);
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white70,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    offset: const Offset(0, 2),
                                    blurRadius: 2,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.all(6),
                                child: Icon(
                                  Icons.edit,
                                  color: context.colorScheme.primary,
                                  size: 18,
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                GestureDetector(
                  onTap: () async {
                    return await uploadMenuImage(context);
                  },
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        border: const BorderDirectional(
                          start: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(238, 238, 238, 1),
                          ),
                          end: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(238, 238, 238, 1),
                          ),
                          top: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(238, 238, 238, 1),
                          ),
                          bottom: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(238, 238, 238, 1),
                          ),
                        ),
                        color: const Color.fromRGBO(238, 238, 238, 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
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
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                          ).translate(),
                        ],
                      ),
                    ),
                  ),
                ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
              Wrap(
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Text(
                    'Make sure your menu image is clear and visible with jpg or png format',
                    style: context.bodySmall!.copyWith(
                        //color: const Color.fromRGBO(127, 129, 132, 1),
                        ),
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ).translate(),
                ],
              ),
              const AnimatedGap(24, duration: Duration(milliseconds: 500)),
              Flexible(
                child: CarouselImages(
                  //scaleFactor: 0.9,
                  listImages: listOfMenuRemoteImages,
                  height: 130,
                  borderRadius: 10,
                  cachedNetworkImage: true,
                  viewportFraction: 0.65,
                  verticalAlignment: Alignment.bottomCenter,
                  onTap: (index) {
                    setState(() {
                      selectedMenuImage = listOfMenuRemoteImages[index];
                    });
                    final nameOfurl = Uri.parse(listOfMenuRemoteImages[index])
                        .path
                        .split("/")
                        .last;
                    final File file = File(listOfMenuRemoteImages[index]);
                    final filename = path.basename(file.path);
                    final nameWithoutExtension =
                        path.basenameWithoutExtension(file.path);
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

  Future<void> uploadMenuImage(BuildContext context) async {
    // Upload nenu image
    // Navigate to document picker page
    final List<dynamic>? result = await context.push<List<dynamic>>(
      Routes.UPLOAD_DOCUMENT_PAGE,
      extra: jsonEncode(
        {
          'documentType': DocumentType.other.name,
        },
      ),
    );
    // Check is Result exists or not
    if (result != null && result.isNotEmpty) {
      // Extarct and store the value
      String filePath = result[0] as String;
      XFile? xCroppedDocumentFile = result[1] as XFile;
      File? croppedDocumentFile = result[2] as File;
      XFile? xFile = result[5] as XFile;
      File? file = result[6] as File;
      String? assetNetworkUrl = result[7] as String?;
      final int timeStamp = DateTime.now().millisecondsSinceEpoch;
      var tempName = 'homeway_document_image_$timeStamp';
      var fileNameWithExtension = path.basename(
          xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? tempName);
      var fileNameWithoutExtension = path.basenameWithoutExtension(
          xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? tempName);
      String fileExtension = path.extension(
          xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? '.png');
      String croppedFilePath = (xCroppedDocumentFile.path.isEmpty)
          ? xCroppedDocumentFile.path
          : croppedDocumentFile.path;
      final fileReadAsBytes = await file.readAsBytes();
      final xFileReadAsBytes = await xFile.readAsBytes();
      final fileReadAsString = base64Encode(fileReadAsBytes);
      final xFileReadAsString = base64Encode(xFileReadAsBytes);
      final uuid = const Uuid().v4();
      final String mimeType =
          xCroppedDocumentFile.mimeType ?? xFile.mimeType ?? 'image/png';
      var decodedImage =
          await decodeImageFromList(xFileReadAsBytes ?? fileReadAsBytes);
      double height = decodedImage.height.toDouble();
      double width = decodedImage.width.toDouble();

      final Map<String, dynamic> metaData = {
        'captureDocumentID': uuid,
        'originalFilePath': filePath,
        'croppedFilePath': croppedFilePath,
        'fileExtension': fileExtension,
        'fileNameWithExtension': fileNameWithExtension,
        'fileName': fileNameWithoutExtension,
        'originalFile': file,
        'xOriginalFile': xFile,
        'xCroppedFile': xCroppedDocumentFile,
        'croppedFile': croppedDocumentFile,
        'networkUrl': assetNetworkUrl,
        'fileReadAsBytes': fileReadAsBytes,
        'xFileReadAsBytes': xFileReadAsBytes,
        'fileReadAsString': fileReadAsString,
        'xFileReadAsString': xFileReadAsString,
        'documentType': DocumentType.other.name,
        'blob': (xFileReadAsBytes.isNotNullOrEmpty)
            ? Blob(xFileReadAsBytes)
            : Blob(fileReadAsBytes),
        'base64': (xFileReadAsString.isNotEmpty)
            ? xFileReadAsString
            : fileReadAsString,
        'mimeType': mimeType,
        'height': height,
        'width': width,
      };
      final CaptureImageEntity captureImageEntity =
          CaptureImageEntity.fromMap(metaData);
      selectedMenuImage = croppedFilePath;
      serviceLocator<MenuEntity>().menuImages = [
        MenuImage(
          imageId: '0',
          assetPath: croppedFilePath,
          assetExtension: fileExtension,
          metaInfo: metaData,
        )
      ];
      setState(() {});
      if (!mounted) {
        return;
      }
      context.read<MenuBloc>().add(
            PushMenuEntityData(
              menuEntity: serviceLocator<MenuEntity>(),
              menuFormStage: MenuFormStage.form1,
              menuEntityStatus: MenuEntityStatus.push,
            ),
          );
    }
  }
}
