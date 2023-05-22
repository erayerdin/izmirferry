import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/data/repositories/schedule/schedule.repository.dart';
import 'package:izmirferry/shared/constants.dart';

part 'station_bloc.freezed.dart';
part 'station_event.dart';
part 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  late ScheduleRepository _scheduleRepository;

  StationBloc({required ScheduleRepository scheduleRepository})
      : super(const StationState.loading()) {
    _scheduleRepository = scheduleRepository;

    on<StationEvent>((event, emit) async {
      emit(const StationState.loading());

      await event.map(
        load: (event) async {
          final endStationsTask = _scheduleRepository.getEndStations(
            startStation: event.startStation,
            day: event.day,
          );
          final schedulesTask = _scheduleRepository.getSchedules(
            startStation: event.startStation,
            endStation: event.endStation,
            day: event.day,
          );
          final results = await Future.wait([endStationsTask, schedulesTask]);
          final Iterable<Station> endStations = List<Station>.from(results[0]);
          final Iterable<String> schedules = List<String>.from(results[1]);

          emit(
            StationState.loaded(
              startStation: event.startStation,
              endStations: endStations,
              day: event.day,
              schedules: schedules,
            ),
          );
        },
      );
    });
  }
}
