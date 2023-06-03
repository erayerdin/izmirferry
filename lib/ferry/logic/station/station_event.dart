part of 'station_bloc.dart';

@freezed
class StationEvent with _$StationEvent {
  const factory StationEvent.load({
    @Default(false) bool isStartChange,
    required Station startStation,
    required Station endStation,
    required Day day,
  }) = _GetEndStationsEvent;
  const factory StationEvent.changeStartStation(Station station) =
      _ChangeStartStationEvent;
  const factory StationEvent.changeEndStation(Station station) =
      _ChangeEndStationEvent;
  const factory StationEvent.changeDay(Day day) = _ChangeDayEvent;
}
