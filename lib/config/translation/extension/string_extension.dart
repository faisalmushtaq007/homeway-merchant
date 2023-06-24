import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/core/extensions/aync_extension/async_extension.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';

extension StringTranslateExtension on String {
  String tr([bool usePlaceholder = false, String placeholder = "..."]) {
    String globalData = this;
    AsyncBuilderCustom<String>(
      future: AppTranslator.instance.translate(globalData),
      builder: (value) {
        String response = globalData;
        /*if (usePlaceholder) {
          response = placeholder;
        } else {
          response = globalData;
        }*/
        if (value != null && value.isNotEmpty) {
          globalData = value;
          response = value;
        }
        return response;
      },
    );
    //return globalData;
    return globalData;
  }
}

/// Signature for a function that builds a widget from a value.
typedef ValueBuilderStringFn<T> = T Function(T? value);

/// Signature for a function that builds a widget from an exception.
typedef ErrorBuilderStringFn<T> = T Function(
    Object error, StackTrace? stackTrace);

/// Signature for a function that reports a flutter error, e.g. [FlutterError.reportError].
typedef ErrorReporterStringFn<T> = void Function(FlutterErrorDetails details);

typedef WidgetStringBuilder<T> = T Function();

/// A Widget that builds depending on the state of a [Future] or [Stream].
///
/// AsyncBuilder must be given either a [future] or [stream], not both.
///
/// This is similar to [FutureBuilder] and [StreamBuilder] but accepts separate
/// callbacks for each state. Just like the built in builders, the [future] or
/// [stream] should not be created at build time because it would restart
/// every time the ancestor is rebuilt.
///
/// If [stream] is an rxdart [ValueStream] with an existing value, that value
/// will be available on the first build. Otherwise when no data is available
/// this builds either [waiting] if provided, or [builder] with a null value.
///
/// If [initial] is provided, it is used in place of the value before one is
/// available.
///
/// If [retain] is true, the current value is retained when the [stream] or
/// [future] instances change. Otherwise when [retain] is false or omitted, the
/// value is reset.
///
/// If the asynchronous operation completes with an error this builds [error].
/// If [error] is not provided [reportError] is called with the [FlutterErrorDetails].
///
/// When [stream] closes and [closed] is provided, [closed] is built with the
/// last value emitted.
///
/// If [pause] is true, the [StreamSubscription] used to listen to [stream] is
/// paused.
///
/// Example using [future]:
///
/// ```dart
/// AsyncBuilder<String>(
///   future: myFuture,
///   waiting: (context) => Text('Loading...'),
///   builder: (context, value) => Text('$value'),
///   error: (context, error, stackTrace) => Text('Error! $error'),
/// )
/// ```
///
/// Example using [stream]:
///
/// ```dart
/// AsyncBuilder<String>(
///   stream: myStream,
///   waiting: (context) => Text('Loading...'),
///   builder: (context, value) => Text('$value'),
///   error: (context, error, stackTrace) => Text('Error! $error'),
///   closed: (context, value) => Text('$value (closed)'),
/// )
/// ```
class AsyncBuilderCustom<T> {
  /// Creates a widget that builds depending on the state of a [Future] or [Stream].
  AsyncBuilderCustom({
    String? key,
    this.waiting,
    required this.builder,
    this.error,
    this.closed,
    this.future,
    this.stream,
    this.initial,
    this.retain = false,
    this.pause = false,
    bool? silent,
    this.keepAlive = false,
    ErrorReporterStringFn<T>? reportError,
  })  : silent = silent ?? error != null,
        reportError = reportError ?? FlutterError.reportError,
        assert(!((future != null) && (stream != null)),
            'AsyncBuilder should be given either a stream or future'),
        assert(future == null || closed == null,
            'AsyncBuilder should not be given both a future and closed builder') {
    initState().build();
  }

  /// The builder that should be called when no data is available.
  final WidgetStringBuilder<T>? waiting;

  /// The default value builder.
  final ValueBuilderStringFn<T> builder;

  /// The builder that should be called when an error was thrown by the future
  /// or stream.
  final ErrorBuilderStringFn<T>? error;

  /// The builder that should be called when the stream is closed.
  final ValueBuilderStringFn<T>? closed;

  /// If provided, this is the future the widget listens to.
  final Future<T>? future;

  /// If provided, this is the stream the widget listens to.
  final Stream<T>? stream;

  /// The initial value used before one is available.
  final T? initial;

  /// Whether or not the current value should be retained when the [stream] or
  /// [future] instances change.
  final bool retain;

  /// Whether or not to suppress printing errors to the console.
  final bool silent;

  /// Whether or not to pause the stream subscription.
  final bool pause;

  /// If provided, overrides the function that prints errors to the console.
  final ErrorReporterStringFn<T> reportError;

  /// Whether or not we should send a keep alive
  /// notification with [AutomaticKeepAliveClientMixin].
  final bool keepAlive;

  T? _lastValue;

  set lastValue(T? value) {
    _lastValue = value;
  }

  T? get lastValue => _lastValue;
  Object? _lastError;
  StackTrace? _lastStackTrace;
  bool _hasFired = false;
  bool _isClosed = false;
  StreamSubscription<T>? _subscription;

  void _cancel() {
    _lastValue = null;
    _lastError = null;
    _lastStackTrace = null;
    _hasFired = false;
    _isClosed = false;
    _subscription?.cancel();
    _subscription = null;
  }

  void _handleError(Object error, StackTrace? stackTrace) {
    _lastError = error;
    _lastStackTrace = stackTrace;
    if (error != null) {}
    if (!silent) {
      reportError(FlutterErrorDetails(
        exception: error,
        stack: stackTrace ?? StackTrace.empty,
        context: ErrorDescription('While updating AsyncBuilderCustom'),
      ));
      build();
    }
  }

  void _initFuture() {
    _cancel();
    final Future<T> future = this.future!;
    future.then((T value) {
      if (future != future) return; // Skip if future changed
      _lastValue = value;
      _hasFired = true;
      build();
    }, onError: _handleError);
  }

  void _updatePause() {
    if (_subscription != null) {
      if (pause && !_subscription!.isPaused) {
        _subscription!.pause();
      } else if (!pause && _subscription!.isPaused) {
        _subscription!.resume();
      }
    }
  }

  void _initStream() {
    _cancel();
    final Stream<T> stream = this.stream!;
    var skipFirst = false;
    if (stream is ValueStream<T> && stream.hasValue) {
      skipFirst = true;
      _hasFired = true;
      _lastValue = stream.value;
    }
    _subscription = stream.listen(
      (T event) {
        if (skipFirst) {
          skipFirst = false;
          return;
        }
        _hasFired = true;
        _lastValue = event;
        build();
      },
      onDone: () {
        _isClosed = true;
        if (closed != null) {
          build();
        }
      },
      onError: _handleError,
    );
  }

  AsyncBuilderCustom<T> initState() {
    if (future != null) {
      _initFuture();
    } else if (stream != null) {
      _initStream();
      _updatePause();
    }
    return this;
  }

  T? build() {
    if (_lastError != null && error != null) {
      return error!(_lastError!, _lastStackTrace);
    }

    if (_isClosed && closed != null) {
      return closed!(_hasFired ? _lastValue : initial);
    }

    if (!_hasFired && waiting != null) {
      return waiting!();
    }
    builder(_hasFired ? _lastValue : initial);
    return _lastValue;
  }

  void dispose() {
    _cancel();
  }
}
