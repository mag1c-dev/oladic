// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// // **************************************************************************
// // AutoRouterGenerator
// // **************************************************************************
//
// // ignore_for_file: type=lint
// // coverage:ignore-file
//
// part of 'app_router.dart';
//
// abstract class _$AppRouter extends RootStackRouter {
//   // ignore: unused_element
//   _$AppRouter({super.navigatorKey});
//
//   @override
//   final Map<String, PageFactory> pagesMap = {
//     HomeRoute.name: (routeData) {
//       return AutoRoutePage<dynamic>(
//         routeData: routeData,
//         child: const HomePage(),
//       );
//     },
//     WordRoute.name: (routeData) {
//       final pathParams = routeData.inheritedPathParams;
//       final args = routeData.argsAs<WordRouteArgs>(
//           orElse: () => WordRouteArgs(word: pathParams.getString('word')));
//       return AutoRoutePage<dynamic>(
//         routeData: routeData,
//         child: WordPage(
//           key: args.key,
//           word: args.word,
//         ),
//       );
//     },
//   };
// }
//
// /// generated route for
// /// [HomePage]
// class HomeRoute extends PageRouteInfo<void> {
//   const HomeRoute({List<PageRouteInfo>? children})
//       : super(
//           HomeRoute.name,
//           initialChildren: children,
//         );
//
//   static const String name = 'HomeRoute';
//
//   static const PageInfo<void> page = PageInfo<void>(name);
// }
//
// /// generated route for
// /// [WordPage]
// class WordRoute extends PageRouteInfo<WordRouteArgs> {
//   WordRoute({
//     Key? key,
//     required String word,
//     List<PageRouteInfo>? children,
//   }) : super(
//           WordRoute.name,
//           args: WordRouteArgs(
//             key: key,
//             word: word,
//           ),
//           rawPathParams: {'word': word},
//           initialChildren: children,
//         );
//
//   static const String name = 'WordRoute';
//
//   static const PageInfo<WordRouteArgs> page = PageInfo<WordRouteArgs>(name);
// }
//
// class WordRouteArgs {
//   const WordRouteArgs({
//     this.key,
//     required this.word,
//   });
//
//   final Key? key;
//
//   final String word;
//
//   @override
//   String toString() {
//     return 'WordRouteArgs{key: $key, word: $word}';
//   }
// }
