import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tz/bloc/cards_bloc.dart';
import 'package:tz/ui/actions_widget.dart';

import 'data/cardRepository/card_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => CardsBloc(cardRepository: CardRepositoryImpl())..add(const CardsEvent.init()),
      child: const MaterialApp(
        home: SafeArea(
          child: ActionsWidget(),
        ),
      ),
    );
  }
}
