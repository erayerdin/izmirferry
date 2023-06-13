part of 'add_favorite_form_bloc.dart';

@freezed
class AddFavoriteFormState with _$AddFavoriteFormState {
  const factory AddFavoriteFormState.processing() = _ProcessingState;
  const factory AddFavoriteFormState.valid({required Favorite favorite}) =
      _ValidState;
}
