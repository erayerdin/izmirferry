import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:izmirferry/ferry/data/repositories/schedule/schedule.repository.dart';

part 'station_bloc.freezed.dart';
part 'station_event.dart';
part 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  late ScheduleRepository _scheduleRepository;

  StationBloc({required ScheduleRepository scheduleRepository})
      : super(const StationState.initial()) {
    _scheduleRepository = scheduleRepository;

    on<StationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
