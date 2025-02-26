import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';


class MoviedbDatasource extends MoviesDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key' : Environment.movieDbKey,
      'language' : 'es-MX'
    }
  ));

  Future<List<Movie>> _jsonToMovie(Map<String, dynamic> json) async {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    return movieDbResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (e) => MovieMapper.movieDbToEntity(e)
    ).toList();
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page
    });
    return _jsonToMovie(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page
    });
    return _jsonToMovie(response.data);
  }


  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page
    });
    return _jsonToMovie(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page
    });
    return _jsonToMovie(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie with id: $id not found');

    final movieDetails = MovieDetails.fromJson(response.data);

    return MovieMapper.movieDetailsToEntity(movieDetails);
  }
  

}