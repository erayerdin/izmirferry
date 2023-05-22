import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:izmirferry/ferry/data/repositories/schedule/schedule.repository.dart';

part 'schedule_bloc.freezed.dart';
part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  late ScheduleRepository _scheduleRepository;

  ScheduleBloc({required ScheduleRepository scheduleRepository})
      : super(const ScheduleState.initial()) {
    _scheduleRepository = scheduleRepository;

    on<ScheduleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
