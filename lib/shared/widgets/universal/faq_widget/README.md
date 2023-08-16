# Flutter FaqWidgets [Frequently Asked Question]

This plugin helps you to display FaqWidgets in your Flutter projects as a custom widget.

## Table of contents

- [Features](#features)
- [Installation](#installation)
- [Usages](#usages)
- [Support and feedback](#support-and-feedback)


## Features

You can:
*  use this for showing FaqWidgets.
*  add textstyle for both questions and answers.
*  give your icons on expnding and collasped.
*  give padding to answers.
*  show divider or not or your own widget as a separator.


Add FaqWidget widget to the widget tree

```dart
FaqWidget(question: "Question 1", answer: "data"),
```

For Styling Questions and Answers

```dart
FaqWidget(
    question: "Question",
    answer: "data",
    ansStyle: const TextStyle(color: Colors.blue, fontSize: 15),
    queStyle: const TextStyle(color: Colors.green, fontSize: 35),
    ),
```

For giving color and borderRadius

```dart
FaqWidget(
    question: "Question",
    answer: data,
    ansDecoration: BoxDecoration(
        color: Colors.grey[550],
        borderRadius: const BorderRadius.all(Radius.circular(20))),
    queDecoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: const BorderRadius.all(Radius.circular(20))),
    ),
```

For giving padding in answer

```dart
FaqWidget(
    question: "Question",
    answer: "data",
    ansPadding: const EdgeInsets.all(50),
    ),
```

For giving custom divider

```dart
FaqWidget(
    question: "Question",
    answer: "data",
    separator: Container(
        height: 5,
        width: double.infinity,
        color: Colors.purple,
    ),
    ),
```

For giving custom expanded and collapsed icon

```dart
FaqWidget(
    question: "Question",
    answer: "data",
    expandedIcon: const Icon(Icons.minimize),
    collapsedIcon: const Icon(Icons.add),
    ),
```

For no showing divider

```dart
FaqWidget(
    question: "Question",
    answer: "data",
    separator:false
    ),
```