import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oladic/words.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context, index) => ListTile(
                title: Text(
                  words[index],
                ),
                onTap: () {
                  context.go('/collection/${words[index]}');
                },
              ),
          itemCount: words.length),
    );
  }
}
