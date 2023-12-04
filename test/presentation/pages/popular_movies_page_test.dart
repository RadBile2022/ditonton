// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/movie.dart';
// import 'package:ditonton/presentation/bloc/movie_list_bloc/popular/popular_bloc.dart';
// import 'package:ditonton/presentation/pages/popular_movies_page.dart';
// import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
//
// import 'popular_movies_page_test.mocks.dart';
//
//
// @GenerateMocks([PopularBloc])
// void main() {
//   late MockPopularBloc mockBloc;
//
//   setUp(() {
//     mockBloc = MockPopularBloc();
//   });
//
//   Widget _makeTestableWidget(Widget body) {
//     return MaterialApp(
//       home: BlocProvider<PopularBloc>(
//         create: (_) => mockBloc,
//         child: body,
//       ),
//     );
//   }
//
//   testWidgets('Page should display center progress bar when loading',
//           (WidgetTester tester) async {
//         when(mockBloc.state).thenReturn(PopularListLoading());
//
//         final progressBarFinder = find.byType(CircularProgressIndicator);
//         final centerFinder = find.byType(Center);
//
//         await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
//
//         expect(centerFinder, findsOneWidget);
//         expect(progressBarFinder, findsOneWidget);
//
//
//       });
//
//   testWidgets('Page should display ListView when data is loaded',
//           (WidgetTester tester) async {
//         when(mockBloc.state).thenReturn(PopularListHasData(<Movie>[]));
//
//         final listViewFinder = find.byType(ListView);
//
//         await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
//
//         expect(listViewFinder, findsOneWidget);
//       });
//
//   testWidgets('Page should display text with message when Error',
//           (WidgetTester tester) async {
//         when(mockBloc.state).thenReturn(PopularListError('Error message'));
//
//         final textFinder = find.byKey(Key('error_message'));
//
//         await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
//
//         expect(textFinder, findsOneWidget);
//       });
// }
