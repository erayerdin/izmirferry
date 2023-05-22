part of 'station_bloc.dart';

@freezed
class StationState with _$StationState {
  const factory StationState.loading() = _LoadingState;
  const factory StationState.loaded({
    required Iterable<Station> stations,
  }) = _LoadedState;
}
