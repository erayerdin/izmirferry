part of 'favorite_bloc.dart';

@freezed
class FavoriteEvent with _$FavoriteEvent {
  const factory FavoriteEvent.add(Favorite favorite) = _AddEvent;
  const factory FavoriteEvent.list() = _ListEvent;
  const factory FavoriteEvent.delete(Favorite favorite) = _DeleteEvent;
}
