import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oladic/home_page.dart';
import 'package:oladic/word_page.dart';

void main() {
  runApp(MyApp());
}

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellKey,
        builder: (context, state, child) {
          return Scaffold(
            appBar:PreferredSize(
              child:  Container(
                width: double.infinity,
                height: 80,
                decoration:
                const BoxDecoration(color: Color.fromRGBO(4, 120, 87, 1)),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'OLADIC',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 30,),
                      Container(
                        width: 300,
                        height: 50,
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                              hintText: 'Collection word',
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: Icon(Icons.clear)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              preferredSize: const Size(double.infinity, 80),
            ),
            body: child,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
            parentNavigatorKey: _shellKey,
          ),
          GoRoute(
              path: '/collection',
              builder: (context, state) => const SizedBox(),
              routes: [
                GoRoute(
                    path: ':word',
                    builder: (context, state) =>
                        WordPage(word: state.pathParameters['word']!),
                    parentNavigatorKey: _shellKey)
              ]),
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _appRouter,
    );
  }
}
