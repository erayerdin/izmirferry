import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/data/repositories/schedule/schedule.repository.dart';
import 'package:izmirferry/shared/constants.dart';

part 'schedule_bloc.freezed.dart';
part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  late ScheduleRepository _scheduleRepository;

  ScheduleBloc({required ScheduleRepository scheduleRepository})
      : super(const ScheduleState.loading()) {
    _scheduleRepository = scheduleRepository;

    on<ScheduleEvent>((event, emit) async {
      emit(const ScheduleState.loading());

      await event.map(
        getSchedules: (event) async {
          final schedules = await _scheduleRepository.getSchedules(
            startStation: event.startStation,
            endStation: event.endStation,
            day: event.day,
          );

          emit(ScheduleState.loaded(hours: schedules));
        },
      );
    });
  }
}
