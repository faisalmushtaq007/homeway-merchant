import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';

class AddressFormPage extends StatefulWidget {
  const AddressFormPage({super.key});

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage>
    with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animationController.forward();
    context.read<PermissionBloc>().add(const RequestLocationPermissionEvent());
  }

  @override
  void dispose() {
    scrollController.dispose();
    _animationController.dispose();
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
              padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Transform(
              transform: Matrix4.translationValues(
                _animation.value * width,
                0.0,
                0.0,
              ),
              child: Directionality(
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                child: PageBody(
                  controller: scrollController,
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: media.size.height,
                  ),
                  child: BlocBuilder<PermissionBloc, PermissionState>(
                    bloc: context.read<PermissionBloc>(),
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      return ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsetsDirectional.only(
                          start: margins * 2.5,
                          end: margins * 2.5,
                        ),
                        children: const [
                          Center(
                            child: Text('New Screen'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
