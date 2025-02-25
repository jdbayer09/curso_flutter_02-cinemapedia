import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }


  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideshowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.zero,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: slideshowMovies),
                  MovieHorizontalListview(
                    title: 'En Cines',
                    subTitle: 'Lunes 20',
                    movies: nowPlayingMovies,
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),
              
                  MovieHorizontalListview(
                    title: 'Proximamente',
                    subTitle: 'En este mes',
                    movies: nowPlayingMovies,
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),
              
                  MovieHorizontalListview(
                    title: 'Populares',
                    movies: popularMovies,
                    loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),
              
                  MovieHorizontalListview(
                    title: 'Mejor Calificadas',
                    subTitle: 'De todos los tiempos',
                    movies: nowPlayingMovies,
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),

                  SizedBox(height: 20)
                ],
              );
            },
            childCount: 1
          )
        )
      ]
    );
  }
}