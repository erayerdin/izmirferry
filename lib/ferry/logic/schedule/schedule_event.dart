part of 'schedule_bloc.dart';

@freezed
class ScheduleEvent with _$ScheduleEvent {
  const factory ScheduleEvent.getSchedules({
    required Station startStation,
    required Station endStation,
    required Days day,
  }) = _GetSchedulesEvent;
}
