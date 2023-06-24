import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/config/translation/utils/text_span_function.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_builder/src/async_builder.dart';

import '../language_controller.dart';

extension TranslateText on TextField {
  /// Translate the text to the defined language using
  /// the `app_translator` using the `FutureBuilder` widget.
  ///
  /// If the [usePlaceholder] arguments is false then it will show the original while awaits.
  /// If the [placeholder] arguments is null then it will show three dots.
  Widget translateTextField(
      [bool usePlaceholder = false, String placeholder = "..."]) {
    String? data;
    String? splitKeyWord;

    return AsyncBuilder<String>(
      future: AppTranslator.instance.translate(data!),
      builder: (context, value) async {
        String response = '';
        if (usePlaceholder) {
          response = placeholder;
        } else {
          response = data ?? '';
        }
        if (value != null && value.isNotEmpty) {
          response = value;
        }
        InputDecoration? inputDecoration = this.decoration;
        final String? labelText =
            await AppTranslator.instance.translate(inputDecoration?.labelText);
        final String? hintText =
            await AppTranslator.instance.translate(inputDecoration?.hintText);
        final String? errorText =
            await AppTranslator.instance.translate(inputDecoration?.errorText);
        final String? counterText = await AppTranslator.instance
            .translate(inputDecoration?.counterText);
        final String? helperText =
            await AppTranslator.instance.translate(inputDecoration?.helperText);
        final String? prefixText =
            await AppTranslator.instance.translate(inputDecoration?.prefixText);
        final String? semanticCounterText = await AppTranslator.instance
            .translate(inputDecoration?.semanticCounterText);
        final String? suffixText =
            await AppTranslator.instance.translate(inputDecoration?.suffixText);
        final cacheInputDecoration = this.decoration!.copyWith(
              icon: this.decoration?.icon,
              iconColor: this.decoration?.iconColor,
              label: this.decoration?.label,
              labelText: labelText ?? this.decoration?.labelText,
              labelStyle: this.decoration?.labelStyle,
              floatingLabelStyle: this.decoration?.floatingLabelStyle,
              helperText: helperText ?? this.decoration?.helperText,
              helperStyle: this.decoration?.helperStyle,
              helperMaxLines: this.decoration?.helperMaxLines,
              hintText: hintText ?? this.decoration?.hintText,
              hintStyle: this.decoration?.hintStyle,
              hintTextDirection: this.decoration?.hintTextDirection,
              hintMaxLines: this.decoration?.hintMaxLines,
              errorText: errorText ?? this.decoration?.errorText,
              errorStyle: this.decoration?.errorStyle,
              errorMaxLines: this.decoration?.errorMaxLines,
              floatingLabelBehavior: this.decoration?.floatingLabelBehavior,
              floatingLabelAlignment: this.decoration?.floatingLabelAlignment,
              isCollapsed: this.decoration?.isCollapsed,
              isDense: this.decoration?.isDense,
              contentPadding: this.decoration?.contentPadding,
              prefixIcon: this.decoration?.prefixIcon,
              prefix: this.decoration?.prefix,
              prefixText: prefixText ?? this.decoration?.prefixText,
              prefixStyle: this.decoration?.prefixStyle,
              prefixIconColor: this.decoration?.prefixIconColor,
              prefixIconConstraints: this.decoration?.prefixIconConstraints,
              suffixIcon: this.decoration?.suffixIcon,
              suffix: this.decoration?.suffix,
              suffixText: suffixText ?? this.decoration?.suffixText,
              suffixStyle: this.decoration?.suffixStyle,
              suffixIconColor: this.decoration?.suffixIconColor,
              suffixIconConstraints: this.decoration?.suffixIconConstraints,
              counter: this.decoration?.counter,
              counterText: counterText ?? this.decoration?.counterText,
              counterStyle: this.decoration?.counterStyle,
              filled: this.decoration?.filled,
              fillColor: this.decoration?.fillColor,
              focusColor: this.decoration?.focusColor,
              hoverColor: this.decoration?.hoverColor,
              errorBorder: this.decoration?.errorBorder,
              focusedBorder: this.decoration?.focusedBorder,
              focusedErrorBorder: this.decoration?.focusedErrorBorder,
              disabledBorder: this.decoration?.disabledBorder,
              enabledBorder: this.decoration?.enabledBorder,
              border: this.decoration?.border,
              enabled: this.decoration?.enabled,
              semanticCounterText:
                  semanticCounterText ?? this.decoration?.semanticCounterText,
              alignLabelWithHint: this.decoration?.alignLabelWithHint,
              constraints: this.decoration?.constraints,
            );
        return Directionality(
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          child: TextField(
            key: this.key,
            textDirection: this.textDirection,
            onTap: this.onTap,
            controller: this.controller,
            focusNode: this.focusNode,
            undoController: this.undoController,
            decoration: cacheInputDecoration ?? this.decoration,
            keyboardType: this.keyboardType,
            textInputAction: this.textInputAction,
            textCapitalization: this.textCapitalization,
            style: this.style,
            strutStyle: this.strutStyle,
            textAlign: this.textAlign,
            textAlignVertical: this.textAlignVertical,
            readOnly: this.readOnly,
            showCursor: this.showCursor,
            autofocus: this.autofocus,
            obscuringCharacter: this.obscuringCharacter,
            obscureText: this.obscureText,
            autocorrect: this.autocorrect,
            smartDashesType: this.smartDashesType,
            smartQuotesType: this.smartQuotesType,
            enableSuggestions: this.enableSuggestions,
            maxLines: this.maxLines,
            minLines: this.minLines,
            expands: this.expands,
            maxLength: this.maxLength,
            maxLengthEnforcement: this.maxLengthEnforcement,
            onChanged: this.onChanged,
            onEditingComplete: this.onEditingComplete,
            onSubmitted: this.onSubmitted,
            onAppPrivateCommand: this.onAppPrivateCommand,
            inputFormatters: this.inputFormatters,
            enabled: this.enabled,
            cursorWidth: this.cursorWidth,
            cursorHeight: this.cursorHeight,
            cursorRadius: this.cursorRadius,
            cursorOpacityAnimates: this.cursorOpacityAnimates,
            cursorColor: this.cursorColor,
            selectionHeightStyle: this.selectionHeightStyle,
            selectionWidthStyle: this.selectionWidthStyle,
            keyboardAppearance: this.keyboardAppearance,
            scrollPadding: this.scrollPadding,
            dragStartBehavior: this.dragStartBehavior,
            enableInteractiveSelection: this.enableInteractiveSelection,
            selectionControls: this.selectionControls,
            onTapOutside: this.onTapOutside,
            mouseCursor: this.mouseCursor,
            buildCounter: this.buildCounter,
            scrollController: this.scrollController,
            scrollPhysics: this.scrollPhysics,
            autofillHints: this.autofillHints,
            contentInsertionConfiguration: this.contentInsertionConfiguration,
            clipBehavior: this.clipBehavior,
            restorationId: this.restorationId,
            scribbleEnabled: this.scribbleEnabled,
            enableIMEPersonalizedLearning: this.enableIMEPersonalizedLearning,
            contextMenuBuilder: this.contextMenuBuilder,
            canRequestFocus: this.canRequestFocus,
            spellCheckConfiguration: this.spellCheckConfiguration,
            magnifierConfiguration: this.magnifierConfiguration,
          ),
        );
      },
    );
  }
}
