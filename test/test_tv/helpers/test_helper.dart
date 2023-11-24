import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data_tv/datasources/db/database_helper.dart';
import 'package:ditonton/data_tv/datasources/tv_local_data_source.dart';
import 'package:ditonton/data_tv/datasources/tv_remote_data_source.dart';
import 'package:ditonton/domain_tv/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
  NetworkInfo
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
