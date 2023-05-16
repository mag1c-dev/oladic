import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oladic/content_page.dart';
import 'package:oladic/words.dart';
import 'package:url_strategy/url_strategy.dart';


void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
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
        return ShellPage(
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ContentPage(),
          parentNavigatorKey: _shellKey,
        ),
        GoRoute(
            path: '/collection',
            builder: (context, state) => const SizedBox(),
            routes: [
              GoRoute(
                  path: ':word',
                  builder: (context, state) =>
                      ContentPage(word: state.pathParameters['word']!),
                  parentNavigatorKey: _shellKey)
            ]),
      ],
    ),
  ],
  debugLogDiagnostics: true,
);

class ShellPage extends StatefulWidget {
  const ShellPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  @override
  void initState() {
    _searchController.addListener(() {
      setState(() {});
      if (words.contains(_searchController.text)) {
        context.go('/collection/${_searchController.text}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(4, 120, 87, 1)),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          context.go('/');
                        },
                        child: Text(
                          'OLADIC',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).textScaleFactor * 22,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    LimitedBox(
                      maxWidth: 300,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: Center(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                hintText: 'Collection dictionary',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    99.0,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      _searchController.text = '';
                                    },
                                    icon: const Icon(Icons.clear))),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (words
                .where((element) => element.contains(_searchController.text))
                .isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Center(
                  child: MaxWidthBox(
                    maxWidth: 1100,
                    child: Wrap(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextButton(
                              onPressed: null,
                              child: Icon(
                                Icons.search,
                                color: Color.fromRGBO(4, 120, 87, 1),
                                size: 18,
                              )),
                        ),
                        ...words
                            .where((element) =>
                                element.contains(_searchController.text))
                            .take(10)
                            .map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextButton(
                                  onPressed: () {
                                    _searchController.text = e;
                                  },
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(4, 120, 87, 1)),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        if (words
                                .where((element) =>
                                    element.contains(_searchController.text))
                                .length >
                            10)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.more_horiz,
                              color: Color.fromRGBO(4, 120, 87, 1),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            Expanded(
              child: MaxWidthBox(maxWidth: 700, child: widget.child),
            ),
          ],
        );
      }),
    );
  }
}

class MaxWidthBox extends StatelessWidget {
  final double? maxWidth;
  final AlignmentGeometry alignment;
  final Widget child;
  final Widget? background;

  const MaxWidthBox(
      {Key? key,
      required this.maxWidth,
      required this.child,
      this.background,
      this.alignment = Alignment.topCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    if (maxWidth != null) {
      if (mediaQuery.size.width > maxWidth!) {
        mediaQuery =
            mediaQuery.copyWith(size: Size(maxWidth!, mediaQuery.size.height));
      }
    }

    return Stack(
      alignment: alignment,
      children: [
        background ?? const SizedBox.shrink(),
        MediaQuery(
            data: mediaQuery, child: SizedBox(width: maxWidth, child: child)),
      ],
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      window.onKeyPress.listen((KeyboardEvent e) {
        _searchFocusNode.requestFocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'OLADIC',
      routerConfig: _appRouter,
    );
  }
}
