import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tz/data/cardRepository/card_repository.dart';
import 'package:tz/data/cardModel/card_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tz/ui/actions_item_widget.dart';

class ActionsWidget extends StatefulWidget {
  const ActionsWidget({Key? key}) : super(key: key);

  @override
  State<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  final List<CardModel> cardsList = [];
  final CardRepositoryImpl _repository = CardRepositoryImpl();
  late final ScrollController _scrollController = ScrollController();

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
          itemCount: cardsList.length,
          itemBuilder: (_, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActionItemWidget(description: cardsList[index].description),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                    color: Colors.black.withOpacity(0.6),
                    colorBlendMode: BlendMode.darken,
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    imageUrl: 'https://bonus.andreyp.ru${cardsList[index].image}',
                  ),
                  Align(
                    heightFactor: 0.9,
                    alignment: Alignment.center,
                    child: Text(
                      cardsList[index].title,
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
                            cardsList[index].shop,
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
    cardsList.addAll(newList);
    cardsList.addAll(newList);
    cardsList.addAll(newList);
    setState(() {});
  }

  Future<void> _getNewCards() async {
    List<CardModel> newList = [];

    newList = await _repository.getCardsPagination();

    setState(() {
      cardsList.addAll(newList);
    });
  }

  void _controllerListener() {
    final double nextPageTrigger = _scrollController.position.maxScrollExtent;

    if (_scrollController.position.pixels > nextPageTrigger) {
      _getNewCards();
    }
  }
}


