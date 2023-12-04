import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

import '../../common/security.dart';
import '../models/tv_detail_model.dart';
import '../models/tv_model.dart';
import '../models/tv_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingMovies();
  Future<List<TvModel>> getPopularMovies();
  Future<List<TvModel>> getTopRatedMovies();
  Future<TvDetailResponse> getMovieDetail(int id);
  Future<List<TvModel>> getMovieRecommendations(int id);
  Future<List<TvModel>> searchMovies(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getNowPlayingMovies() async {
    final ioClient = await createIOClient();
    final response =
        await ioClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getMovieDetail(int id) async {
    final ioClient = await createIOClient();

    final response =
        await ioClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getMovieRecommendations(int id) async {
    final ioClient = await createIOClient();

    final response = await ioClient
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularMovies() async {
    final ioClient = await createIOClient();

    final response =
        await ioClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedMovies() async {
    final ioClient = await createIOClient();

    final response =
        await ioClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchMovies(String query) async {
    final ioClient = await createIOClient();

    final response = await ioClient
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
