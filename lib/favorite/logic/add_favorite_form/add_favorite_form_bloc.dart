import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/ferry/constants.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/ferry/data/repositories/station/station.repository.dart';
import 'package:izmirferry/shared/constants.dart';

part 'add_favorite_form_bloc.freezed.dart';
part 'add_favorite_form_event.dart';
part 'add_favorite_form_state.dart';

class AddFavoriteFormBloc
    extends Bloc<AddFavoriteFormEvent, AddFavoriteFormState> {
  AddFavoriteFormBloc({
    required StationRepository stationRepository,
  }) : super(const AddFavoriteFormState.processing()) {
    _stationRepository = stationRepository;
    startStation = allStation.firstWhere((s) => s.name == 'Konak');
    endStation = allStation.firstWhere((s) => s.name == 'Karşıyaka');
    day = null;

    on<AddFavoriteFormEvent>((event, emit) async {
      final now = DateTime.now();
      emit(const AddFavoriteFormState.processing());

      await event.map(
        changeStartStation: (event) async {
          final stations = await _stationRepository.getEndStations(
            startStation: event.station,
            day: now.dayValue,
          );
          endStations = stations.toList(growable: false);
          startStation = event.station;
          day = now.dayValue;
          add(
            AddFavoriteFormEvent.changeEndStation(station: endStations.first),
          );
        },
        changeEndStation: (event) {
          endStation = event.station;
          emit(
            AddFavoriteFormState.valid(
              favorite: Favorite(
                id: -1,
                startStation: startStation,
                endStation: endStation,
                day: day,
                lastUpdate: now,
              ),
            ),
          );
        },
        changeDay: (event) {
          day = event.day;
          emit(
            AddFavoriteFormState.valid(
              favorite: Favorite(
                id: -1,
                startStation: startStation,
                endStation: endStation,
                day: day,
                lastUpdate: now,
              ),
            ),
          );
        },
      );
    });
  }

  late StationRepository _stationRepository;
  late Station startStation;
  late Station endStation;
  late List<Station> endStations;
  late Day? day;
}
