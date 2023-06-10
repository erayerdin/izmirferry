part of 'favorite_bloc.dart';

@freezed
class FavoriteEvent with _$FavoriteEvent {
  const factory FavoriteEvent.add() = _AddEvent;
  const factory FavoriteEvent.list() = _ListEvent;
  const factory FavoriteEvent.delete() = _DeleteEvent;
}
