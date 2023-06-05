import 'package:flutter/widgets.dart';

class StreamTuple<T1, T2, T3, T4, T5> {
  StreamTuple([
    this.stream1,
    this.stream2,
    this.stream3,
    this.stream4,
    this.stream5,
  ]);
  final Stream<T1>? stream1;
  final Stream<T2>? stream2;
  final Stream<T3>? stream3;
  final Stream<T4>? stream4;
  final Stream<T5>? stream5;
}

class SnapshotTuple<T1, T2, T3, T4, T5> {
  SnapshotTuple([
    this.snapshot1,
    this.snapshot2,
    this.snapshot3,
    this.snapshot4,
    this.snapshot5,
  ]);
  final AsyncSnapshot<T1>? snapshot1;
  final AsyncSnapshot<T2>? snapshot2;
  final AsyncSnapshot<T3>? snapshot3;
  final AsyncSnapshot<T4>? snapshot4;
  final AsyncSnapshot<T5>? snapshot5;
}

class InitialDataTuple<T1, T2, T3, T4, T5> {
  InitialDataTuple([
    this.data1,
    this.data2,
    this.data3,
    this.data4,
    this.data5,
  ]);
  final T1? data1;
  final T2? data2;
  final T3? data3;
  final T4? data4;
  final T5? data5;
}

typedef MultipleStreamBuilderWidgetBuilder<T1, T2, T3, T4, T5> = Widget
    Function(
  BuildContext context,
  SnapshotTuple<T1, T2, T3, T4, T5> snapshots,
);

class MultipleStreamBuilder<T1, T2, T3, T4, T5> extends StatelessWidget {
  const MultipleStreamBuilder({
    super.key,
    required this.streams,
    required this.builder,
    this.initialData,
  });
  final StreamTuple<T1, T2, T3, T4, T5> streams;
  final MultipleStreamBuilderWidgetBuilder<T1, T2, T3, T4, T5> builder;
  final InitialDataTuple<T1, T2, T3, T4, T5>? initialData;

  @override
  Widget build(BuildContext context) {
    if (streams.stream1 == null || streams.stream2 == null) {
      return builder(
        context,
        SnapshotTuple(),
      );
    }

    return StreamBuilder<T1>(
      stream: streams.stream1,
      initialData: initialData?.data1,
      builder: (context1, snapshot1) {
        return StreamBuilder<T2>(
          stream: streams.stream2,
          initialData: initialData?.data2,
          builder: (context2, snapshot2) {
            if (streams.stream3 == null) {
              return builder(
                context2,
                SnapshotTuple(
                  snapshot1,
                  snapshot2,
                ),
              );
            }

            return StreamBuilder<T3>(
              stream: streams.stream3,
              initialData: initialData?.data3,
              builder: (context3, snapshot3) {
                if (streams.stream4 == null) {
                  return builder(
                    context3,
                    SnapshotTuple(
                      snapshot1,
                      snapshot2,
                      snapshot3,
                    ),
                  );
                }

                return StreamBuilder<T4>(
                  stream: streams.stream4,
                  initialData: initialData?.data4,
                  builder: (context4, snapshot4) {
                    if (streams.stream5 == null) {
                      return builder(
                        context4,
                        SnapshotTuple(
                          snapshot1,
                          snapshot2,
                          snapshot3,
                          snapshot4,
                        ),
                      );
                    }

                    return StreamBuilder<T5>(
                      stream: streams.stream5,
                      initialData: initialData?.data5,
                      builder: (context5, snapshot5) {
                        return builder(
                          context5,
                          SnapshotTuple(
                            snapshot1,
                            snapshot2,
                            snapshot3,
                            snapshot4,
                            snapshot5,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
