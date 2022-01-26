import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
      ),
    );
  }
}
