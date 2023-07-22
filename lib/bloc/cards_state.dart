part of 'cards_bloc.dart';

@freezed
class CardsState with _$CardsState {
  const factory CardsState({
    @Default([]) List<CardModel> cardsList,
    BlocAction? action,
  }) = _CardsState;
}

abstract class BlocAction {}

class NavigateToDescription extends BlocAction {
  NavigateToDescription({required this.description});

  final String description;
}
