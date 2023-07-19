import 'package:flutter/material.dart';

class ActionItemWidget extends StatelessWidget {
  final String description;

  const ActionItemWidget({required this.description, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
    ),
    body: Center(
      child: Text(description),
    ),
  );
}