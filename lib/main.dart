import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oladic/word_page.dart';
import 'package:oladic/words.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();
final _searchFocusNode = FocusNode();
final _searchController = TextEditingController();
final _appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) {
        return Scaffold(
          // appBar: PreferredSize(preferredSize: const Size(double.infinity, 60), child: Container(
          //   width: double.infinity,
          //   height: 60,
          //   decoration: const BoxDecoration(color: Color.fromRGBO(4, 120, 87, 1)),
          //   child: Center(
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         TextButton(
          //             onPressed: () {
          //               context.go('/');
          //             },
          //             child: const Text(
          //               'OLADIC',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 32,
          //                   fontWeight: FontWeight.bold),
          //             )),
          //         const SizedBox(
          //           width: 30,
          //         ),
          //         SizedBox(
          //           width: 300,
          //           child: Center(
          //             child: TextField(
          //               controller: _searchController,
          //               focusNode: _searchFocusNode,
          //               onChanged: (value) {
          //                 if (words.contains(value)) {
          //                   context.go('/collection/$value');
          //                 }
          //               },
          //               textAlignVertical: TextAlignVertical.center,
          //               decoration:  InputDecoration(
          //                   hintText: 'Collection word',
          //                   border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(99.0,),
          //                     borderSide: BorderSide.none,
          //                   ),
          //                   fillColor: Colors.white,
          //                   filled: true,
          //                   contentPadding: EdgeInsets.zero,
          //                   isDense: true,
          //                   prefixIcon: const Icon(Icons.search),
          //                   suffixIcon: IconButton(onPressed: () {
          //                     _searchController.text = '';
          //                   }, icon: const Icon(Icons.clear))),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // )),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(color: Color.fromRGBO(4, 120, 87, 1)),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          onPressed: () {
                            context.go('/');
                          },
                          child: const Text(
                            'OLADIC',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: Center(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            onChanged: (value) {
                              if (words.contains(value)) {
                                context.go('/collection/$value');
                              }
                            },
                            textAlignVertical: TextAlignVertical.center,
                            decoration:  InputDecoration(
                                hintText: 'Collection word',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(99.0,),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: IconButton(onPressed: () {
                                  _searchController.text = '';
                                }, icon: const Icon(Icons.clear))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if(words.where((element) => element.contains(_searchController.text)).isNotEmpty) Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200]
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: words.where((element) => element.contains(_searchController.text)).take(10).map((e) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(e, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(4,120,87, 1)),),
                        ),
                        ).toList(),
                  ),
                ),
              ),
              Expanded(child: child),
            ],
          ),
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    window.onKeyPress.listen((KeyboardEvent e) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _appRouter,
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(color: Color.fromRGBO(4, 120, 87, 1)),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () {
                  context.go('/');
                },
                child: const Text(
                  'OLADIC',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              width: 30,
            ),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (value) {
                    if (words.contains(value)) {
                      context.go('/collection/$value');
                    }
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration:  InputDecoration(
                      hintText: 'Collection word',
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(onPressed: () {
                        _searchController.text = '';
                      }, icon: const Icon(Icons.clear))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 80;

  @override
  // TODO: implement minExtent
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
