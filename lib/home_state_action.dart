import 'package:built_value/built_value.dart';

part 'home_state_action.g.dart';

enum WatchState { idle, running, paused }

extension WatchStateExtension on WatchState {
  bool get isStartEnabled {
    switch (this) {
      case WatchState.idle:
        return true;
      case WatchState.running:
        return false;
      case WatchState.paused:
        return true;
    }
    return false;
  }

  bool get isPauseEnabled => !isStartEnabled;

  bool get isResetEnabled => this != WatchState.idle;
}

extension IntExtension on int {
  String get twoDigits => toString().padLeft(2, '0');

  String get formatted {
    final m = (this ~/ 60).twoDigits;
    final s = (this % 60).twoDigits;
    return '$m:$s';
  }
}

abstract class HomeState implements Built<HomeState, HomeStateBuilder> {
  int get seconds;

  WatchState get state;

  HomeState._();

  factory HomeState([void Function(HomeStateBuilder) updates]) = _$HomeState;
}

enum HomeAction { start, pause, reset }
