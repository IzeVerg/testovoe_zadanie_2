import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tz/data/cardModel/card_model.dart';
import 'package:tz/data/cardRepository/card_repository.dart';

part 'cards_bloc.freezed.dart';

part 'cards_event.dart';

part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc({
    required CardRepository cardRepository,
  })  : _cardRepository = cardRepository,
        super(const CardsState()) {
    on<_Init>(_onInit);
    on<_UserScrolledToMaxExtent>(_onUserScrolledToMaxExtent);
    on<_UserMovedToInfoScreen>(_onUserMovedToInfoScreen);
  }

  final CardRepository _cardRepository;

  List<CardModel> paginationList = [];

  Future<void> _onInit(_Init event, Emitter emit) async {
    final List<CardModel> newList = [];
    paginationList = await _cardRepository.getCardsPagination();

    /// Сделано так, потому что некорректно работает запрос при count > 5

    newList.addAll(paginationList);
    newList.addAll(paginationList);
    newList.addAll(paginationList);

    emit(state.copyWith(cardsList: newList));
  }

  Future<void> _onUserMovedToInfoScreen(_UserMovedToInfoScreen event, Emitter emit) async {
    final String description = state.cardsList[event.index].description;
    emit(state.copyWith(action: NavigateToDescription(description: description)));
  }

  Future<void> _onUserScrolledToMaxExtent(_UserScrolledToMaxExtent event, Emitter emit) async {
    final List<CardModel> newList = List.from(state.cardsList);
    newList.addAll(paginationList);
    emit(state.copyWith(cardsList: newList));
  }
}
