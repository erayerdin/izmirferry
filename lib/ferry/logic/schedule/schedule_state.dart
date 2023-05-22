part of 'schedule_bloc.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState.loading() = _LoadingState;
  const factory ScheduleState.loaded({required Iterable<String> hours}) =
      _LoadedState;
}
