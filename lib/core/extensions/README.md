# async_extension

Dart [async][dart_async] extensions, to help usage of `Future`, `FutureOr` and `async` methods. Also
allows performance improvements when using `sync` and `async` code.

## Usage

`async_extension` helps interoperability of `sync` and `async` code and improves performance and
memory usage.

In the example below `computeSomething` can return an `int` (synced computation) or
a `Future` (async computation). The method `doComputation` doesn't need to be
declared as an `async` method, avoiding creation of `Future` instances, listeners and
dispatch/schedule of `Future` instances. This improves debugging flow,
reduces `GC` workload and avoids `async` overhead.

```dart
import 'package:async_extension/async_extension.dart';

// Sync/Async Computation without declare an `async` method:
void doComputation() {

  // Compute something that can be a `Future` or an `int`:
  FutureOr<int> n = computeSomething();

  // Resolves `n` and multiply by 10:
  var n10 = n.resolveMapped((n) => n * 10);

  // When `n10` is resolved, print it:
  n10.onResolve((n) => print('n10: $n'));

  // Call an `async` method and maps its result:
  var resultUpper = processResult(n10).resolveMapped((r) => r.toUpperCase());

  resultUpper.onResolve((r) {
    print('Final result: $r');
  });
  
}

// An `async` method (a `Future` instance is always created):
Future<String> processResult(FutureOr<int> n) async {
  var result = await n ;
  
  return 'result: $result' ;
}
```

### asyncTry 

You can use the function `asyncTry` to execute a `block` in a `try`, `then`, `catch` and `finally` execution chain.

```dart
import 'package:async_extension/async_extension.dart';

// All the `asyncTry` below are similar,
// returning the value `246` and printing `Finally`.
void main() async {
  var r1 = asyncTry<int>(
    // A normal `sync` block, returning a value:
    () => 123, 
    then: (n) => n! * 2,
    onFinally: () => print('Finally 1'),
  );

  print(r1);

  var r2 = await asyncTry<int>(
    // An `async` block, returning a `Future`:
    () async => 123, 
    then: (n) => n! * 2,
    onFinally: () => print('Finally 2'),
  );

  print(r2);

  var r3 = await asyncTry<int>(
    // An `async` block, returning a delayed `Future`:
    () => Future.delayed(Duration(milliseconds: 100), () => 123),
    then: (n) => Future.delayed(Duration(milliseconds: 100), () => n! * 2),
    // `asyncTry` only returns after `onFinally` is executed:
    onFinally: () =>
            Future.delayed(Duration(milliseconds: 100), () => print('Finally 3')),
  );

  print(r3);

  var errors = [];

  var r4 = await asyncTry<int>(
    // Force an error in the main block:
    () => throw StateError('Force error'),
    onError: (e) {
      errors.add(e); // Catche the error.
      return -246; // Return value `-246` on error.
    },
    // `asyncTry` only returns after `onFinally` is executed:
    onFinally: () => Future.microtask(() => print('Finally 4')), 
  );

  print(r4);

  print('Caught errors: $errors');
}
```

OUTPUT:

```text
Finally 1
246
Finally 2
246
Finally 3
246
Finally 4
-246
Caught errors: [Bad state: Force error]
```

## Arithmetic operators

The arithmetic operators for `Future` and `FutureOr` are implemented for direct use. 

### Usage of `Future` arithmetic operators:

```text

  var sum = await (Future.value(10) + Future.value(20)) ;

  var sub = await (Future.value(10) - Future.value(20)) ;
  
  var mul = await (Future.value(10) * Future.value(20)) ;
  
  var div = await (Future.value(10) / Future.value(20)) ;
  
  var divInt = await (Future.value(10) ~/ Future.value(20)) ;

```

### Usage of `FutureOr` arithmetic operators (2nd term):

```text

  var sum = await (Future.value(10) + 20) ;

  var sub = await (Future.value(10) - 20) ;
  
  var mul = await (Future.value(10) * 20) ;
  
  var div = await (Future.value(10) / 20) ;
  
  var divInt = await (Future.value(10) ~/ 20) ;

```

## VM Optimization

This paradigm shows that it's possible to improve the Dart VM performance
rewriting `async` methods during JIT/AOT optimizations.

It's very clear that most `async` methods can be written using the patterns
enabled by `async_extension`.

I hope that in the future the Dart VM moves to use something like that,
since `async` methods are a bottleneck, specially for the VM `GC`.

## Benchmark

See the benchmark at `example/async_extension_benchmark.dart`. 

An example of the benchmark output:

```text
//-------------------------------------------------
// OUTPUT
//-------------------------------------------------
// session[9]> Benchmark[await:ComputationSync]{ sum: 999999000000, iterations: 1000000, time: 778ms , speed: 1285347.0437017994 iter./s }
// session[9]> Benchmark[await:ComputationAsync]{ sum: 999999000000, iterations: 1000000, time: 899ms , speed: 1112347.0522803115 iter./s }
// session[9]> Benchmark[optimized:ComputationSync]{ sum: 999999000000, iterations: 1000000, time: 28ms , speed: 35714285.71428572 iter./s }
// session[9]> Benchmark[optimized:ComputationAsync]{ sum: 999999000000, iterations: 1000000, time: 810ms , speed: 1234567.9012345679 iter./s }
//
```

The optimized benchmark (that uses `async_extension`) is fast in both scenarios
(when the computation is `sync` or `async`). It shows that when the computation is `sync`, the avoidance of `Future`
instances (and related dispatch/schedule) improves the performance significantly. Also shows that for `async` computation the
optimized benchmark is not slower than a normal Dart `async` method version. 

## Source

The official source code is [hosted @ GitHub][github_async_extension]:

- https://github.com/eneural-net/async_extension

[github_async_extension]: https://github.com/eneural-net/async_extension