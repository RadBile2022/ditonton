import 'dart:convert';

import 'package:ditonton/data_tv/models/tv_model.dart';
import 'package:ditonton/data_tv/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tMovieModel = TvModel(
    adult: false,
    backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
    genreIds: [10763],
    id: 94722,
    originalTitle: "Tagesschau",
    overview: "German daily news program, the oldest still existing program on German television.",
    popularity: 3499.583,
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    releaseDate: "1952-12-26",
    title: "Tagesschau",
    video: false,
    voteAverage: 7.174,
    voteCount: 164,
  );
  final tMovieResponseModel =   TvResponse(movieList: <TvModel>[tMovieModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'adult': false,
            'backdrop_path': '/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg',
            'genre_ids': [10763],
            'id': 94722,
            'original_title': 'Tagesschau',
            'overview': 'German daily news program, the oldest still existing program on German television.',
            'popularity': 3499.583,
            'poster_path': '/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg',
            'release_date': '1952-12-26',
            'title': 'Tagesschau',
            'video': false,
            'vote_average': 7.174,
            'vote_count': 164
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
