import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';

class MovieSlider extends StatefulWidget {
  
  final String? title;
  final List<Movie> movies;
  final Function onNextPage;

  const MovieSlider({
    super.key,
    this.title,
    required this.movies,
    required this.onNextPage
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    
    scrollController.addListener(() {
      //Si nos acercamos al final de la lista de populares tenemos que cargar la nueva página
      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ){
        widget.onNextPage();
      }

    });

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if( widget.title != null )
            Padding(
            padding: const EdgeInsets.symmetric( horizontal: 15, vertical: 3),
            child: Text(widget.title!, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold )),
            ),


          const SizedBox( height: 5,),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _, int index) => _MoviePoster( movie: widget.movies[index] ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster({required this.movie});

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'slider-${movie.id}';

    return Container(
      height: 350,
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
  
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage( movie.getImg ),
                  width: 130,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox( height: 5,),

          Expanded(
            child: Text(
              movie.title ?? 'no-name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle( color: Colors.white, fontSize: 13, ),
            ),
          ),

        ],
      ),
    );
  }
}