part of 'package:homemakers_merchant/app/features/menu/index.dart';

class FormPageView extends StatefulWidget {
  final ProgressIndicatorType? progress;
  final List<FormPageModel> pages;
  final Function() onFormSubmitted;
  final bool? showAppBar;
  final bool? showBackButton;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? buttonPadding;
  final EdgeInsetsGeometry? progressPadding;
  final PageController controller;
  final FormPageStyle? style;
  final PreloadPageController preloadPageController;
  final ValueChanged<int>? onPageChanged;
  final OnStepChanged? onStepChanged;

  const FormPageView({
    Key? key,
    this.progress = ProgressIndicatorType.linear,
    required this.pages,
    required this.onFormSubmitted,
    required this.controller,
    this.contentPadding,
    this.buttonPadding,
    this.progressPadding,
    this.style,
    this.showAppBar,
    this.showBackButton,
    required this.preloadPageController,
    this.onPageChanged,
    this.onStepChanged,
  }) : super(key: key);

  @override
  _FormPageViewState createState() => _FormPageViewState();
}

class _FormPageViewState extends State<FormPageView> {
  int _currentPageIndex = 0;
  final StepProgressController _stepProgressController = StepProgressController(initialStep: 0, totalStep: 4);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    widget.preloadPageController.dispose();
    super.dispose();
  }

  bool _validateCurrentPage() {
    final page = widget.pages[_currentPageIndex];
    if (page.formKey != null) {
      final form = page.formKey!.currentState!;
      if (form.validate()) {
        form.save();
      } else {
        return false;
      }
    }
    return true;
  }

  void _onNextPressed() {
    if (_validateCurrentPage()) {
      setState(() {
        if (_currentPageIndex < widget.pages.length - 1) {
          _currentPageIndex++;
          widget.controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
          widget.preloadPageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
        } else {
          widget.onFormSubmitted();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.style?.backgroundColor ?? Colors.white,
      appBar: widget.showAppBar != null
          ? AppBar(
              centerTitle: widget.style?.appBarCenterTitle ?? false,
              elevation: widget.style?.appBarElevation ?? 4,
              backgroundColor: widget.style?.appBarBackgroundColor ?? Colors.white,
              toolbarHeight: widget.style?.appBarHeight ?? 56,
              leading: widget.showBackButton != null
                  ? IconButton(
                      onPressed: () {
                        if (_currentPageIndex > 0) {
                          setState(() {
                            _currentPageIndex--;
                            widget.controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                            widget.preloadPageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          });
                        }
                      },
                      icon: widget.style?.backButtonIcon ?? const Icon(Icons.arrow_back_ios),
                    )
                  : null,
              title: widget.pages[_currentPageIndex].title != null
                  ? Text(
                      widget.pages[_currentPageIndex].title!,
                      style: widget.style?.appBarTextStyle ??
                          const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  : null,
              actions: [
                widget.progress == ProgressIndicatorType.circular
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: 0,
                            end: _currentPageIndex / (widget.pages.length - 1),
                          ),
                          duration: const Duration(milliseconds: 300),
                          builder: (context, value, child) {
                            return SizedBox(
                              width: widget.style?.progressIndicatorSize ?? 40,
                              height: widget.style?.progressIndicatorSize ?? 40,
                              child: CircularProgressIndicator(
                                value: value,
                                strokeWidth: widget.style?.progressIndicatorStrokeWidth ?? 4,
                                color: widget.style?.progressIndicatorColor ?? Theme.of(context).primaryColor,
                                backgroundColor: widget.style?.progressIndicatorBackgroundColor,
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            )
          : null,
      body: Column(
        children: [
          widget.progress == ProgressIndicatorType.linear
              ? Padding(
                  padding: widget.progressPadding ?? const EdgeInsets.all(8.0),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: _currentPageIndex / (widget.pages.length - 1),
                    ),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        minHeight: widget.style?.progressIndicatorStrokeWidth ?? 4,
                        color: widget.style?.progressIndicatorColor ?? Theme.of(context).primaryColor,
                        backgroundColor: widget.style?.progressIndicatorBackgroundColor ?? Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.style?.progressIndicatorColor ?? Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),
          // PageView pour afficher les pages du formulaire
          /*Expanded(
            child: PageView.builder(
              controller: widget.controller,
              itemCount: widget.pages.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: widget.contentPadding ?? const EdgeInsets.all(16),
                  child: widget.pages[index].body,
                );
              },
            ),
          ),*/
          Expanded(
            child: PreloadPageView.builder(
              controller: widget.preloadPageController,
              itemCount: widget.pages.length,
              preloadPagesCount: widget.pages.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: widget.contentPadding ?? const EdgeInsets.all(16),
                  child: widget.pages[index].body,
                );
              },
              onPageChanged: widget.onPageChanged,
            ),
          ),
          Progress(
            stepProgressController: _stepProgressController,
            strokeColor: Color(0xff04A7B8),
            valueColor: Colors.white,
            backgroundColor: Color(0xff04A7B5),
            tickColor: Color(0xff04A7B5),
            onStepChanged: widget.onStepChanged,
          ),
          Padding(
            padding: widget.buttonPadding ?? const EdgeInsets.all(16),
            child: SizedBox(
              height: widget.style?.buttonHeight ?? 50,
              width: widget.style?.buttonWidth ?? double.infinity,
              child: ElevatedButton(
                onPressed: _onNextPressed,
                child: Text(
                  widget.pages[_currentPageIndex].textButton ?? 'Next',
                  style: widget.style?.buttonTextStyle ??
                      TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                ),
                style: widget.style?.buttonStyle ??
                    ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
