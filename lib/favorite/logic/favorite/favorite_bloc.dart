import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';
import 'package:izmirferry/favorite/data/repository/favorite/favorite.repository.dart';
import 'package:izmirferry/ferry/data/models/station/station.model.dart';
import 'package:izmirferry/shared/constants.dart';

part 'favorite_bloc.freezed.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({required FavoriteRepository favoriteRepository})
      : super(const FavoriteState.loading()) {
    _favoriteRepository = favoriteRepository;

    on<FavoriteEvent>((event, emit) async {
      emit(const FavoriteState.loading());

      await event.map(
        add: (event) async {
          // TODO impl already exists

          await _favoriteRepository.add(
            startStation: event.startStation,
            endStation: event.endStation,
            day: event.day,
          );
          emit(const FavoriteState.added());
          add(const FavoriteEvent.list());
        },
        list: (event) async {
          final favorites = await _favoriteRepository.list();
          emit(FavoriteState.listed(favorites));
        },
        delete: (event) async {
          // TODO impl does not exist

          await _favoriteRepository.delete(event.favorite);
          emit(const FavoriteState.deleted());
          add(const FavoriteEvent.list());
        },
      );
    });
  }

  late FavoriteRepository _favoriteRepository;
}
