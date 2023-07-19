import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tz/data/cardRepository/card_repository.dart';
import 'package:tz/data/cardModel/card_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ActionsWidget extends StatefulWidget {
  const ActionsWidget({Key? key}) : super(key: key);

  @override
  State<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  final List<CardModel> _cardsList = [];
  final CardRepositoryImpl _repository = CardRepositoryImpl();
  late final ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_controllerListener);
    _getInitialCards();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_controllerListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Акции',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: MasonryGridView.count(
          controller: _scrollController,
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: _cardsList.length,
          itemBuilder: (_, int index) {
            return GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                    color: Colors.black.withOpacity(0.6),
                    colorBlendMode: BlendMode.darken,
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    imageUrl: 'https://bonus.andreyp.ru${_cardsList[index].image}',
                  ),
                  Align(
                    heightFactor: 0.9,
                    alignment: Alignment.center,
                    child: Text(
                      _cardsList[index].title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            _cardsList[index].shop,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getInitialCards() async {
    List<CardModel> newList = [];

    newList = await _repository.getCardsPagination();

    /// Сделано так, потому что некорректно работает запрос при count > 5
    _cardsList.addAll(newList);
    _cardsList.addAll(newList);
    _cardsList.addAll(newList);
    setState(() {});
  }

  Future<void> _getNewCards() async {
    List<CardModel> newList = [];

    newList = await _repository.getCardsPagination();

    setState(() {
      _cardsList.addAll(newList);
    });
  }

  void _controllerListener() {
    final double nextPageTrigger = _scrollController.position.maxScrollExtent;

    if (_scrollController.position.pixels > nextPageTrigger) {
      _loading = true;
      _getNewCards();
    }
  }
}
