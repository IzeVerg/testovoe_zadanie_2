part of 'cards_bloc.dart';

@freezed
class CardsEvent with _$CardsEvent {
  const factory CardsEvent.init() = _Init;

  const factory CardsEvent.userScrolledToMaxExtent() = _UserScrolledToMaxExtent;

  const factory CardsEvent.userMovedToInfoScreen(int index) = _UserMovedToInfoScreen;
}
