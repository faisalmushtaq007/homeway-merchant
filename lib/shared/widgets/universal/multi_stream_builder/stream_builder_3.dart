import 'package:flutter/widgets.dart';
import 'multiple_stream_builder_wrapper.dart';

// Wrapper for 3 [Stream]s. Intended to be used with [StreamBuilder3]
class StreamTuple3<T1, T2, T3> {
  StreamTuple3(
    this.stream1,
    this.stream2,
    this.stream3,
  );
  // returns the first stream of the tuple
  final Stream<T1> stream1;

  // returns the second stream of the tuple
  final Stream<T2> stream2;

  // returns the third stream of the tuple
  final Stream<T3> stream3;
}

// Wrapper for 3 [AsyncSnapshot]s Intended to be used with [StreamBuilder3]
class SnapshotTuple3<T1, T2, T3> {
  SnapshotTuple3(
    this.snapshot1,
    this.snapshot2,
    this.snapshot3,
  );
  // returns the first snapshot of the tuple
  final AsyncSnapshot<T1> snapshot1;

  // returns the second snapshot of the tuple
  final AsyncSnapshot<T2> snapshot2;

  // returns the third snapshot of the tuple
  final AsyncSnapshot<T3> snapshot3;
}

// Wrapper for 3 `initialData` values for [StreamBuilder3]
class InitialDataTuple3<T1, T2, T3> {
  InitialDataTuple3([
    this.data1,
    this.data2,
    this.data3,
  ]);
  // returns the first item of the tuple
  final T1? data1;

  // returns the second item of the tuple
  final T2? data2;

  // returns the third item of the tuple
  final T3? data3;
}

// A variant of [AsyncWidgetBuilder] that uses [SnapshotTuple3]
typedef AsyncWidgetBuilder3<T1, T2, T3> = Widget Function(
  BuildContext context,
  SnapshotTuple3<T1, T2, T3> snapshots,
);

// Wraps the normal [StreamBuilder] widget to allow 3 streams in
// in the form of a [StreamTuple3]. Can also accept multiple values for
// [initialData] using a [InitialDataTuple3].
class StreamBuilder3<T1, T2, T3> extends StatelessWidget {
  const StreamBuilder3({
    Key? key,
    this.initialData,
    required this.streams,
    required this.builder,
  }) : super(key: key);
  // Collection of streams for this widget to listen to.
  // New data in any stream triggers [builder] to rerun
  final StreamTuple3<T1, T2, T3> streams;

  // A builder that gets passed multiple snapshots.
  // see [StreamBuilder.builder] for more info
  final AsyncWidgetBuilder3<T1, T2, T3> builder;

  // Initial data for when the [streams] don't have any.
  // see [StreamBuilder.initialData] for more info
  final InitialDataTuple3<T1, T2, T3>? initialData;

  @override
  Widget build(BuildContext _) {
    return MultipleStreamBuilder<T1, T2, T3, dynamic, dynamic>(
      streams: StreamTuple(
        streams.stream1,
        streams.stream2,
        streams.stream3,
      ),
      initialData: InitialDataTuple(
        initialData?.data1,
        initialData?.data2,
        initialData?.data3,
      ),
      builder: (context, snapshots) {
        return builder(
          context,
          SnapshotTuple3(
            snapshots.snapshot1!,
            snapshots.snapshot2!,
            snapshots.snapshot3!,
          ),
        );
      },
    );
  }
}
