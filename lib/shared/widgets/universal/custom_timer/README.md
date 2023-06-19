# Custom Timer ⌛

A Flutter package to create a customizable timer.

<br>

## 🎉 Features

- Timer controller.
- Auto count up / down timer.
- Custom builder.
- Millisecond support.

<br>

## 📌 Usage

<br>

![example1](https://user-images.githubusercontent.com/44307990/147802076-3206db9d-d5f6-4ce4-a3f9-7e139910d822.gif)

<br>

Add SingleTickerProviderStateMixin to your stateful widget. 👇

```dart
class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
```

Then define a CustomTimer controller

```dart
late CustomTimerController _controller = CustomTimerController(
  vsync: this,
  begin: Duration(hours: 24),
  end: Duration(),
  initialState: CustomTimerState.reset,
  interval: CustomTimerInterval.milliseconds
);
```

And you are ready to use the timer:

```dart
CustomTimer(
  controller: _controller,
  builder: (state, time) {
    // Build the widget you want!🎉
    return Text(
      "${time.hours}:${time.minutes}:${time.seconds}.${time.milliseconds}",
      style: TextStyle(fontSize: 24.0)
    );
  }
)
```

Now you can use the controller methods:

```dart
_controller.reset();
_controller.start();
_controller.pause();
_controller.finish();

_controller.add(Duration(minutes: 30));
_controller.subtract(Duration(minutes: 30));
_controller.jumpTo(Duration(hours: 12));
```

You can also set the begin or end, even with the counter running:
```dart
_controller.begin = Duration();
_controller.end = Duration(hours 12);
```


And add listeners to state changes or just use the properties when you need them:

```dart
_controller.state.addListener(() {
  print(_controller.state.value); // 👉 CustomTimerState.paused
  print(_controller.remaining.value.hours); // 👉 12h
});
```

Remember to dispose when you are no longer using it.
