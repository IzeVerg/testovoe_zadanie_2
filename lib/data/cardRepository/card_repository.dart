import 'dart:convert';

import 'package:tz/data/cardModel/card_model.dart';
import 'package:http/http.dart' as http;

abstract class CardRepository {
  Future<List<CardModel>> getCardsPagination({int page, int count});
}

class CardRepositoryImpl implements CardRepository {
  final String _baseUrl = 'bonus.andreyp.ru';

  @override
  Future<List<CardModel>> getCardsPagination({int page = 1, int count = 5}) async {
    const String url = '/api/v1/promos';

    /// Запрос возвращает адекватный ответ только при статичных аргументах, где page = 1, count = 5
    final Map<String, String> queryParameters = {
      'page': page.toString(),
      'count': count.toString(),
    };
    final Uri resultUrl = Uri.https(_baseUrl, url, queryParameters);
    List<CardModel> result;

    try {
      final http.Response rawResult = await http.get(resultUrl);

      final Map<String, dynamic> rawResult1 = jsonDecode(rawResult.body);

      final List<dynamic> rawItems =
          rawResult1['serverResponse']['body']['promo']['list'];

      result = rawItems.map((element) => CardModel.fromJson(element)).toList();
    } catch (e) {
      result = <CardModel>[];
    }

    return result;
  }
}
