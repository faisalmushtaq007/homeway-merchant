import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_type_enum.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/document/business_document_uploaded_entity.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/document/business_document_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/uploaded_document_child_widget.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';
import 'package:path/path.dart' as path;

class BusinessDocumentPage extends StatefulWidget {
  const BusinessDocumentPage({super.key});

  @override
  State<BusinessDocumentPage> createState() => _BusinessDocumentPageState();
}

class _BusinessDocumentPageState extends State<BusinessDocumentPage> {
  late final ScrollController scrollController;
  late final ScrollController innerListScrollController;
  List<BusinessDocumentUploadedEntity> allBusinessDocuments = [];
  final List<TextEditingController> textEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<DocumentType> documentTypes = [
    DocumentType.tradeLicence,
    DocumentType.nationalID,
    DocumentType.selfie,
  ];

  @override
  void initState() {
    allBusinessDocuments = [];
    allBusinessDocuments.clear();
    super.initState();
    scrollController = ScrollController();
    innerListScrollController = ScrollController();
    allBusinessDocuments.insert(
      0,
      BusinessDocumentUploadedEntity(
        documentType: DocumentType.tradeLicence,
        businessDocumentAssetsEntity: [],
      ),
    );

    context.read<PermissionBloc>().add(const RequestLocationPermissionEvent());
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: PlatformScaffold(
        material: (context, platform) {
          return MaterialScaffoldData(
            resizeToAvoidBottomInset: false,
          );
        },
        cupertino: (context, platform) {
          return CupertinoPageScaffoldData(
            resizeToAvoidBottomInset: false,
          );
        },
        appBar: PlatformAppBar(
          trailingActions: const [
            Padding(
              padding: EdgeInsetsDirectional.only(end: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: Directionality(
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          child: PageBody(
            controller: scrollController,
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: media.size.height,
            ),
            child: BlocBuilder<PermissionBloc, PermissionState>(
              key: const Key(
                'business-document-permission-bloc-builder-widget-key',
              ),
              bloc: context.read<PermissionBloc>(),
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.topLeft,
                  clipBehavior: Clip.none,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.only(
                        start: margins * 2.5,
                        end: margins * 2.5,
                        top: topPadding,
                        bottom: bottomPadding,
                      ),
                      children: [
                        Wrap(
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            Text(
                              'Upload Legal Documents',
                              style: context.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            )
                          ],
                        ),
                        const AnimatedGap(8,
                            duration: Duration(milliseconds: 300)),
                        Wrap(
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            Text(
                              'Share with us commercial license and government ID for your business verification',
                              style: context.labelMedium!.copyWith(),
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            )
                          ],
                        ),
                        const AnimatedGap(
                          8,
                          duration: Duration(milliseconds: 300),
                        ),
                        BlocBuilder<BusinessDocumentBloc,
                            BusinessDocumentState>(
                          bloc: context.watch<BusinessDocumentBloc>(),
                          builder: (context, state) {
                            state.maybeMap(
                              orElse: () {},
                              addNewAssetState: (value) {},
                              addNewDocumentState: (value) {
                                int index=value.currentIndex;
                                var document=value.allBusinessDocuments[index];
                                /*allBusinessDocuments =
                                    List<BusinessDocumentUploadedEntity>.from(
                                  value.allBusinessDocuments.toList(),
                                );*/

                                //allBusinessDocuments=value.allBusinessDocuments!;
                                allBusinessDocuments.toList().removeAt(index);
                                allBusinessDocuments.insert(index, document);
                                appLog.d('BlocBuilder Data: ${allBusinessDocuments[index].documentFrontAssets?.assetOriginalName}');
                                appLog.d('BlocBuilder Data value: ${allBusinessDocuments[0].documentFrontAssets?.assetName} - ${allBusinessDocuments[0].documentFrontAssets?.assetPath}');
                                allBusinessDocuments.insert(
                                  value.newIndexPosition,
                                  BusinessDocumentUploadedEntity(
                                    documentType: value.documentType,
                                    businessDocumentAssetsEntity: [],
                                  ),
                                );
                              },
                            );
                            return ImplicitlyAnimatedList<
                                BusinessDocumentUploadedEntity>(
                              key: const Key(
                                  'allBusinessDocuments-listview-widget-key'),
                              controller: scrollController,
                              items: allBusinessDocuments,
                              updateDuration: const Duration(milliseconds: 400),
                              areItemsTheSame: (a, b) => a == b,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, animation, assets, index) {
                                return SizeFadeTransition(
                                  key: ObjectKey(assets),
                                  sizeFraction: 0.7,
                                  curve: Curves.easeInOut,
                                  animation: animation,
                                  child: _buildItem(assets, index),
                                );
                              },
                              updateItemBuilder: (context, animation, assets) {
                                return FadeTransition(
                                  key: ObjectKey(assets),
                                  opacity: animation,
                                  child: _buildItem(assets),
                                );
                              },
                              removeItemBuilder:
                                  (context, animation, oldAssets) {
                                return FadeTransition(
                                  key: ObjectKey(oldAssets),
                                  opacity: animation,
                                  child: _buildItem(oldAssets),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BusinessDocumentUploadedEntity assets, [
    int index = -1,
  ]) {
    final List<BusinessDocumentAssetsEntity> entries = [];
    if (assets.documentFrontAssets != null) {
      entries.add(assets.documentFrontAssets!);
    }
    if (assets.documentBackAssets != null) {
      entries.add(assets.documentBackAssets!);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UploadedDocumentChildWidget(
          allBusinessDocumentAssets: entries.toList(),
          keyNameOfListView: '${assets.documentType.documentTypeName}-Key',
          hasEnableTextField: index == 0 || false,
          labelOfTextField: 'Trade License Number',
          textEditingController: textEditingControllers[index],
          onChanged: (value) {},
          onSubmitted: (value) {},
        ),
        const AnimatedGap(10, duration: Duration(milliseconds: 500)),
        AnimatedCrossFade(
          crossFadeState: (assets.documentFrontAssetsUploadStatus !=
                  DocumentUploadStatus.uploaded)
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 400),
          firstChild: ElevatedButton.icon(
            onPressed: () async {
              final List<dynamic>? result = await context.push<List<dynamic>>(
                Routes.UPLOAD_DOCUMENT_PAGE,
                extra: jsonEncode(
                  {
                    'documentType': assets.documentType.name,
                  },
                ),
              );
              await Future.delayed(const Duration(milliseconds: 500), () {});
              if (result != null && result.isNotEmpty) {
                var currentIndex=index;
                if ((index + 1) <= documentTypes.length) {
                  /*await Future.delayed(
                      const Duration(milliseconds: 500), () {});
                  if (!mounted) return;*/
                  context.read<BusinessDocumentBloc>().add(
                        AddNewDocument(
                          newIndexPosition: index + 1,
                          documentType: documentTypes[index + 1],
                          allBusinessDocuments: allBusinessDocuments.toList(),
                          businessDocumentUploadedEntity:
                              allBusinessDocuments[currentIndex],
                          currentIndex: currentIndex,
                          uploadedData: result,
                        ),
                      );
                }

                /*item.businessDocumentAssetsEntity.add(
                  BusinessDocumentAssetsEntity(
                    assetName: fileNameWithExtension,
                    assetOriginalName: path.basenameWithoutExtension(xFile.path ?? file.path),
                    assetPath: filePath,
                    assetExtension: fileExtension,
                    assetIdNumber: textEditingControllers[0].value.text.trim(),
                  ),
                );*/
              }
            },
            icon: const Icon(
              Icons.upload_file,
              color: Color.fromRGBO(42, 45, 50, 1),
            ),
            label: Text(
              'Upload ${assets.documentType.documentTypeName} Document',
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              style: context.labelLarge!.copyWith(
                  color: const Color.fromRGBO(42, 45, 50, 1),
                  ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: Size(context.width, 46),
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}
