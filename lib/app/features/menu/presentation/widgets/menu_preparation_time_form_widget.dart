part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuPreparationTimeFormField extends FormField<String> {
  MenuPreparationTimeFormField({
    required this.onSaved,
    required this.validator,
    this.initialValue = '',
    AutovalidateMode autovalidate = AutovalidateMode.disabled,
    this.title = 'Min or Hr',
    this.hintWidget = const Text('Tap to select one or more'),
    this.required = false,
    this.errorText = 'Please select one or more options',
    this.leading,
    //this.dataSource,
    this.textField,
    this.valueField,
    required this.onChanged,
    this.open,
    this.close,
    this.fillColor,
    this.border,
    this.trailing,
    this.enabled = true,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTap,
    this.onTapOutside,
    this.controller,
    required this.suffixIcon,
    this.hintText,
    super.key,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidate,
          builder: (FormFieldState<String> state) {
            // String selectedChoice = "";
            print('Error ${state.hasError}, ${state.errorText}');
            return InputDecorator(
              decoration: InputDecoration(
                //filled: true,
                errorText: state.hasError ? state.errorText : null,
                errorMaxLines: 1,
                fillColor: fillColor ?? Theme.of(state.context).canvasColor,
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsetsDirectional.zero,
                errorBorder: InputBorder.none,
              ),
              isEmpty: state.value == null || state.value!.isEmpty,
              child: SizedBox(
                height: 48,
                child: Card(
                  margin: EdgeInsetsDirectional.zero,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromRGBO(201, 201, 203, 1),
                    ),
                    borderRadius: BorderRadiusDirectional.circular(10.0),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 16,
                            ),
                            child: Text(
                              title,
                              //style: context.labelLarge,
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Color.fromRGBO(201, 201, 203, 1),
                          thickness: 1,
                        ),
                        Expanded(
                          child: AppTextFieldWidget(
                            controller: controller,
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            //focusNode: menuForm3FocusList[0],
                            textInputAction: TextInputAction.next,
                            //onFieldSubmitted: (_) => fieldFocusChange(context, menuForm3FocusList[0], menuForm3FocusList[1]),
                            //keyboardType: TextInputType.numberWithOptions(),
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: hintText ?? 'Min or Hr',
                              border: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 14),
                              suffixIcon: suffixIcon,
                            ),
                            onChanged: (value) {
                              state.didChange(value);
                              onChanged!(value);
                            },
                            key: Key('${title}-text-form-field'),

                            onEditingComplete: () {
                              if (onEditingComplete != null) {
                                return onEditingComplete!();
                              }
                            },
                            validator: (value) {
                              if (validator != null) {
                                return validator!(value);
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (onSaved != null) {
                                state.save();
                                return onSaved!(value);
                              }
                              state.save();
                            },
                            onFieldSubmitted: (value) {
                              if (onSubmitted != null) {
                                return onSubmitted!(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /* child: MenuPreparationTimeWidget(
                title: title,
                suffixIcon: suffixIcon,
                controller: controller,
                onChanged: (value) {
                  state.didChange(value);
                  onChanged!(value);
                },
                key: Key('${title}-text-form-field'),
                validator: (value) {
                  if (validator != null) {
                    return validator!(value);
                  }
                  return null;
                },
                onEditingComplete: () {
                  if (onEditingComplete != null) {
                    return onEditingComplete!();
                  }
                },
                onSaved: (value) {
                  if (onSaved != null) {
                    return onSaved!(value);
                  }
                },
                onSubmitted: (value) {
                  if (onSubmitted != null) {
                    return onSubmitted!(value);
                  }
                },
                hintText: hintText,
              ),*/
            );
          },
        );
  final String title;
  final Widget hintWidget;
  final bool required;
  final String errorText;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final TextEditingController? controller;
  final String initialValue;
  final String? textField;
  final String? valueField;
  final ValueChanged<String>? onChanged;
  final Function? open;
  final Function? close;
  final Widget? leading;
  final Widget? trailing;
  final Color? fillColor;
  final InputBorder? border;
  final bool enabled;
  final Widget suffixIcon;
  final String? hintText;
}

class MenuPreparationTimeWidget extends StatefulWidget {
  const MenuPreparationTimeWidget({
    super.key,
    required this.title,
    required this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.onSubmitted,
    required this.suffixIcon,
    this.hintText,
  });

  final String title;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final Widget suffixIcon;
  final String? hintText;

  @override
  State<MenuPreparationTimeWidget> createState() => _MenuPreparationTimeWidgetState();
}

class _MenuPreparationTimeWidgetState extends State<MenuPreparationTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        /*Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 16,
            ),
            child: Text(
              widget.title,
              style: context.labelLarge,
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
          ),
        ),
        const VerticalDivider(
          color: Color.fromRGBO(201, 201, 203, 1),
          thickness: 1,
        ),*/
        Directionality(
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          child: Expanded(
            child: AppTextFieldWidget(
              controller: widget.controller,
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              //focusNode: menuForm3FocusList[0],
              textInputAction: TextInputAction.next,
              //onFieldSubmitted: (_) => fieldFocusChange(context, menuForm3FocusList[0], menuForm3FocusList[1]),
              //keyboardType: TextInputType.numberWithOptions(),
              readOnly: true,
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Min or Hr',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                contentPadding: const EdgeInsetsDirectional.only(start: 12, end: 12, top: 14, bottom: 14),
                suffixIcon: widget.suffixIcon,
                prefixIcon: Container(
                  width: kMinInteractiveDimension * 3.25,
                  constraints: const BoxConstraints(
                    minWidth: kMinInteractiveDimension * 3.25,
                    //minHeight: kMinInteractiveDimension,
                  ),
                  child: Row(
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    children: [
                      const AnimatedGap(18, duration: Duration(milliseconds: 100)),
                      Text('${widget.title}'),
                      Spacer(),
                      Container(
                        //width: kMinInteractiveDimension * 2,
                        constraints: const BoxConstraints(
                          // minWidth: kMinInteractiveDimension * 2,
                          minHeight: kMinInteractiveDimension,
                        ),
                        decoration: const BoxDecoration(
                          border: BorderDirectional(
                            start: BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(
                                201,
                                201,
                                203,
                                1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const AnimatedGap(12, duration: Duration(milliseconds: 100)),
                    ],
                  ),
                ),
              ),
              validator: widget.validator,
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
            ),
          ),
        ),
      ],
    );
  }
}
