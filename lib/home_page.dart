import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oladic/router/app_router.dart';
import 'package:oladic/words.dart';

@RoutePage()
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
                  context.pushRoute(WordRoute(word: words[index]));
                },
              ),
          itemCount: words.length),
    );
  }
}
