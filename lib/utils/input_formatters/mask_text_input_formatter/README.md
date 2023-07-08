# mask_text_input_formatter

1Import the library:

```dart
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
```

2Create mask formatter:

```dart
var maskFormatter = new MaskTextInputFormatter(
  mask: '+# (###) ###-##-##', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);
```

3Set it to text field:

```dart
TextField(inputFormatters: [maskFormatter])
```

## Get value

Get masked text:

```dart
print(maskFormatter.getMaskedText()); // -> "+0 (123) 456-78-90"
```

Get unmasked text:

```dart
print(maskFormatter.getUnmaskedText()); // -> 01234567890
```

## Change the mask

You can use the `updateMask` method to change the mask after the formatter was created:

```dart
var textEditingController = TextEditingController(text: "12345678");
var maskFormatter = new MaskTextInputFormatter(mask: '####-####', filter: { "#": RegExp(r'[0-9]') });

TextField(controller: textEditingController, inputFormatters: [maskFormatter])  // -> "1234-5678"

textEditingController.value = maskFormatter.updateMask(mask: "##-##-##-##"); // -> "12-34-56-78"
```
