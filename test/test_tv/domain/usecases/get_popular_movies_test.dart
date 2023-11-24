import 'package:dartz/dartz.dart';
import 'package:ditonton/domain_tv/entities/tv.dart';
import 'package:ditonton/domain_tv/usecases/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockTvRepository();
    usecase = GetPopularTv(mockMovieRpository);
  });

  final tMovies = <Tv>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRpository.getPopularMovies())
            .thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tMovies));
      });
    });
  });
}
