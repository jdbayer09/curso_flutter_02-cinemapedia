import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}