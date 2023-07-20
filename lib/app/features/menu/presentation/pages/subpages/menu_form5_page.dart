part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm5Page extends StatefulWidget {
  const MenuForm5Page({super.key});

  @override
  State<MenuForm5Page> createState() => _MenuForm5PageState();
}

class _MenuForm5PageState extends State<MenuForm5Page> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
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
                  Text(
                    'Stocks',
                    style: context.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  ).translate(),
                  const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                  Text(
                    'Select menu minimum and maximum stock',
                    style: context.labelMedium,
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  ).translate(),
                ],
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
            ],
          );
        },
      ),
    );
  }
}
