part of 'favorite_bloc.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState.loading() = _LoadingState;
  const factory FavoriteState.listed({required Iterable<Favorite> favorites}) =
      _ListedState;
  const factory FavoriteState.added() = _AddedState;
  const factory FavoriteState.deleted() = _DeletedState;
}
