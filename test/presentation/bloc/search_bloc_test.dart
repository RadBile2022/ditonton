import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'search_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchMovies>()])
void main() {
  late MovieSearchBloc searchBloc;
late MockSearchMovies searchMovies;

setUp(() {
  searchMovies = MockSearchMovies();
  searchBloc = MovieSearchBloc(searchMovies);
});

test("Should be empty", () {
  expect(searchBloc.state, SearchEmpty());
});

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';
blocTest<MovieSearchBloc, MovieSearchState>("Should emit [Loading, HasData] when data is gotten successfully", build: () {
when(searchMovies.execute(tQuery)).thenAnswer((_)async => Right(tMovieList));
return searchBloc;
},
act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
  wait: const Duration(milliseconds: 100),

  expect: () => [
    SearchLoading(),
    SearchHasData(tMovieList),
  ],
  verify: (bloc) {
    verify(searchMovies.execute(tQuery));
  },
);

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(searchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(searchMovies.execute(tQuery));
    },
  );
}