import 'package:flutter/widgets.dart';
import 'multiple_stream_builder_wrapper.dart';

// Wrapper for 2 [Stream]s. Intended to be used with [StreamBuilder2]
class StreamTuple2<T1, T2> {
  StreamTuple2(
    this.stream1,
    this.stream2,
  );
  // returns the first stream of the tuple
  final Stream<T1> stream1;

  // returns the second stream of the tuple
  final Stream<T2> stream2;
}

// Wrapper for 2 [AsyncSnapshot]s Intended to be used with [StreamBuilder2]
class SnapshotTuple2<T1, T2> {
  SnapshotTuple2(
    this.snapshot1,
    this.snapshot2,
  );
  // returns the first snapshot of the tuple
  final AsyncSnapshot<T1> snapshot1;

  // returns the second snapshot of the tuple
  final AsyncSnapshot<T2> snapshot2;
}

// Wrapper for 2 `initialData` values for [StreamBuilder2]
class InitialDataTuple2<T1, T2> {
  InitialDataTuple2([
    this.data1,
    this.data2,
  ]);
  // returns the first item of the tuple
  final T1? data1;

  // returns the second item of the tuple
  final T2? data2;
}

// A variant of [AsyncWidgetBuilder] that uses [SnapshotTuple2]
typedef AsyncWidgetBuilder2<T1, T2> = Widget Function(
  BuildContext context,
  SnapshotTuple2<T1, T2> snapshots,
);

// Wraps the normal [StreamBuilder] widget to allow 2 streams in
// in the form of a [StreamTuple2]. Can also accept multiple values for
// [initialData] using a [InitialDataTuple2].
class StreamBuilder2<T1, T2> extends StatelessWidget {
  const StreamBuilder2({
    Key? key,
    this.initialData,
    required this.streams,
    required this.builder,
  }) : super(key: key);
  // Collection of streams for this widget to listen to.
  // New data in any stream triggers [builder] to rerun
  final StreamTuple2<T1, T2> streams;

  // A builder that gets passed multiple snapshots.
  // see [StreamBuilder.builder] for more info
  final AsyncWidgetBuilder2<T1, T2> builder;

  // Initial data for when the [streams] don't have any.
  // see [StreamBuilder.initialData] for more info
  final InitialDataTuple2<T1, T2>? initialData;

  @override
  Widget build(BuildContext _) {
    return MultipleStreamBuilder<T1, T2, dynamic, dynamic, dynamic>(
      streams: StreamTuple(
        streams.stream1,
        streams.stream2,
      ),
      initialData: InitialDataTuple(
        initialData?.data1,
        initialData?.data2,
      ),
      builder: (context, snapshots) {
        return builder(
          context,
          SnapshotTuple2(
            snapshots.snapshot1!,
            snapshots.snapshot2!,
          ),
        );
      },
    );
  }
}
