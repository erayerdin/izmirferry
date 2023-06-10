import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:izmirferry/favorite/data/models/favorite/favorite.model.dart';

part 'favorite_bloc.freezed.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState.loading()) {
    on<FavoriteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
