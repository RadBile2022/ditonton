// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/movie.dart';
// import 'package:ditonton/presentation/bloc/movie_list_bloc/top_rated/top_rated_bloc.dart';
// import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
// import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
//
// import 'top_rated_movies_page_test.mocks.dart';
//
// @GenerateMocks([TopRatedBloc])
// void main() {
//
//   late MockTopRatedBloc mockBloc;
//
//   setUp(() {
//     mockBloc = MockTopRatedBloc();
//   });
//
//
//   Widget _makeTestableWidget(Widget body) {
//     return BlocProvider<TopRatedBloc>.value(
//       value: mockBloc,
//       child: MaterialApp(
//         home: body,
//       ),
//     );
//   }
//
//   testWidgets('Page should display progress bar when loading',
//       (WidgetTester tester) async {
//     when(mockBloc.state).thenReturn(TopRatedListLoading());
//
//     final progressFinder = find.byType(CircularProgressIndicator);
//     final centerFinder = find.byType(Center);
//
//     await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
//
//     expect(centerFinder, findsOneWidget);
//     expect(progressFinder, findsOneWidget);
//   });
//
//   testWidgets('Page should display when data is loaded',
//       (WidgetTester tester) async {
//
//         when(mockBloc.state).thenReturn(TopRatedListHasData(<Movie>[]));
//
//
//     final listViewFinder = find.byType(ListView);
//
//     await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
//
//     expect(listViewFinder, findsOneWidget);
//   });
//
//   testWidgets('Page should display text with message when Error',
//       (WidgetTester tester) async {
//     when(mockBloc.state).thenReturn(TopRatedListError('Error message'));
//
//     final textFinder = find.byKey(Key('error_message'));
//
//     await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));
//
//     expect(textFinder, findsOneWidget);
//   });
// }
