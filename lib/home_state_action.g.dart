// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeState extends HomeState {
  @override
  final int seconds;
  @override
  final WatchState state;

  factory _$HomeState([void Function(HomeStateBuilder) updates]) =>
      (new HomeStateBuilder()..update(updates)).build();

  _$HomeState._({this.seconds, this.state}) : super._() {
    if (seconds == null) {
      throw new BuiltValueNullFieldError('HomeState', 'seconds');
    }
    if (state == null) {
      throw new BuiltValueNullFieldError('HomeState', 'state');
    }
  }

  @override
  HomeState rebuild(void Function(HomeStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeStateBuilder toBuilder() => new HomeStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeState &&
        seconds == other.seconds &&
        state == other.state;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, seconds.hashCode), state.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomeState')
          ..add('seconds', seconds)
          ..add('state', state))
        .toString();
  }
}

class HomeStateBuilder implements Builder<HomeState, HomeStateBuilder> {
  _$HomeState _$v;

  int _seconds;
  int get seconds => _$this._seconds;
  set seconds(int seconds) => _$this._seconds = seconds;

  WatchState _state;
  WatchState get state => _$this._state;
  set state(WatchState state) => _$this._state = state;

  HomeStateBuilder();

  HomeStateBuilder get _$this {
    if (_$v != null) {
      _seconds = _$v.seconds;
      _state = _$v.state;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HomeState;
  }

  @override
  void update(void Function(HomeStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HomeState build() {
    final _$result = _$v ?? new _$HomeState._(seconds: seconds, state: state);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
