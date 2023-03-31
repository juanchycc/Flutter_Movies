import 'package:flutter/material.dart';
import 'package:peliculas_app/search/search.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Películas en Cines'),
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon( Icons.search_rounded ),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate())
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            CardSwiper( movies: moviesProvider.movies ),
      
            MovieSlider( 
              movies: moviesProvider.populars,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovies()
            ),
      
          ],
        ),
      )
  );
  }
}