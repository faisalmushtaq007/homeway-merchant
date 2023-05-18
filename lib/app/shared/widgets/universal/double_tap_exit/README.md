# DoubleTapToExit

Add double-tapping the back-button to exit functionality to your app using this package !

## Usage

First, you just have to import the package using:

```dart
import 'double_tap_to_exit.dart';
```

Wrap your `Scaffold` widget with the `DoubleTapToExit` widget, passing an optional `snackBar`:


```dart

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: Scaffold(),
      snackBar: const SnackBar(
        content: Text('Tap again to exit !'),
      ),
    );
  }
}

```