import 'package:disposebag/disposebag.dart';
import 'package:distinct_value_connectable_stream/distinct_value_connectable_stream.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'home_state_action.dart';

// ignore_for_file: close_sinks
class HomeBloc {
  static const maxSeconds = 10; // 10 seconds

  /// Inputs
  final void Function() start;
  final void Function() pause;
  final void Function() reset;

  /// Outputs
  final ValueStream<HomeState> state$;

  /// Dispose
  final void Function() dispose;

  HomeBloc._({
    @required this.start,
    @required this.pause,
    @required this.reset,
    @required this.dispose,
    @required this.state$,
  });

  factory HomeBloc() {
    final actionS = PublishSubject<HomeAction>();
    final state$ = _transform(actionS);
    return HomeBloc._(
      dispose: DisposeBag([
        actionS,
        state$.listen((state) => print('[STATE] $state')),
        state$.connect(),
      ]).dispose,
      pause: () => actionS.add(HomeAction.pause),
      reset: () => actionS.add(HomeAction.reset),
      start: () => actionS.add(HomeAction.start),
      state$: state$,
    );
  }

  static DistinctValueConnectableStream<HomeState> _transform(
    Stream<HomeAction> action$,
  ) {
    DistinctValueConnectableStream<HomeState> state$;

    final idledState = HomeState((b) => b
      ..seconds = 0
      ..state = WatchState.idle);

    int resume = 0;
    state$ = action$
        .doOnData((action) => print('[ACTION] $action'))
        .switchMap((action) {
      switch (action) {
        case HomeAction.start:
          return Stream.periodic(
                  const Duration(seconds: 1), (i) => i + 1 + resume)
              .startWith(resume)
              .takeWhile((secs) => secs <= maxSeconds)
              .map((secs) => HomeState((b) => b
                ..seconds = secs
                ..state = WatchState.running));
        case HomeAction.pause:
          resume = state$.value.seconds;
          return Stream.value(HomeState((b) => b
            ..seconds = resume
            ..state = WatchState.paused));
        case HomeAction.reset:
          resume = 0;
          return Stream.value(idledState);
      }
      throw StateError('Invalid action: $action');
    }).publishValueSeededDistinct(seedValue: idledState);

    return state$;
  }
}

void main() async {
  var homeBloc = HomeBloc();
  homeBloc.state$.listen(print);

  homeBloc.start();
  await Future.delayed(const Duration(seconds: 5));
  homeBloc.pause();
  await Future.delayed(const Duration(seconds: 2));
  homeBloc.start();
  await Future.delayed(const Duration(seconds: 10));
}
