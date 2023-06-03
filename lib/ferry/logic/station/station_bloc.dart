import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/data/repositories/schedule/schedule.repository.dart';
import 'package:izmirferry/ferry/data/repositories/station/station.repository.dart';
import 'package:izmirferry/shared/constants.dart';

part 'station_bloc.freezed.dart';
part 'station_event.dart';
part 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  late ScheduleRepository _scheduleRepository;
  late StationRepository _stationRepository;
  late Map<String, dynamic> currentParams;

  StationBloc(
      {required ScheduleRepository scheduleRepository,
      required StationRepository stationRepository})
      : super(const StationState.loading()) {
    _scheduleRepository = scheduleRepository;
    _stationRepository = stationRepository;
    currentParams = {
      'startStation': allStation.firstWhere((s) => s.id == 1),
      'endStation': null,
      'day': Day.monday,
    };

    on<StationEvent>((event, emit) async {
      emit(const StationState.loading());

      await event.map(
        changeStartStation: (event) {
          currentParams['startStation'] = event.station;
          add(
            StationEvent.load(
              startStation: currentParams['startStation'],
              endStation: currentParams['endStation'],
              day: currentParams['day'],
              isStartChange: true,
            ),
          );
        },
        changeEndStation: (event) {
          currentParams['endStation'] = event.station;
          add(
            StationEvent.load(
              startStation: currentParams['startStation'],
              endStation: currentParams['endStation'],
              day: currentParams['day'],
            ),
          );
        },
        changeDay: (event) {
          currentParams['day'] = event.day;
          add(
            StationEvent.load(
              startStation: currentParams['startStation'],
              endStation: currentParams['endStation'],
              day: currentParams['day'],
            ),
          );
        },
        load: (event) async {
          final endStationsTask = _stationRepository.getEndStations(
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

          if (event.isStartChange) {
            add(StationEvent.changeEndStation(endStations.first));
            return;
          }

          currentParams['startStation'] = event.startStation;
          currentParams['endStation'] = event.endStation;
          currentParams['day'] = event.day;

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
