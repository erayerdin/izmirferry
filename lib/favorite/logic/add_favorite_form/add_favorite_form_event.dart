part of 'add_favorite_form_bloc.dart';

@freezed
class AddFavoriteFormEvent with _$AddFavoriteFormEvent {
  const factory AddFavoriteFormEvent.changeStartStation({
    required Station station,
  }) = _ChangeStartStationEvent;
  const factory AddFavoriteFormEvent.changeEndStation({
    required Station station,
  }) = _ChangeEndStationEvent;
  const factory AddFavoriteFormEvent.changeDay({
    required Day? day,
  }) = _ChangeDayEvent;
}
