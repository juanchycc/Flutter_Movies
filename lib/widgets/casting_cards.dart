import 'package:flutter/cupertino.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final String movieId;

  const CastingCards({
    super.key,
    required this.movieId
  });

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.getMovieCast(movieId),
      builder: ((_, AsyncSnapshot<List<Cast>> snapshot) {
        
        if( !snapshot.hasData ){
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only( bottom: 30 ),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((_, index) {
              return _CastCard( actor: cast[index] );
            })
          ),
        );
      }),
    );

  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({
    required this.actor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.getImg),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox( height: 5,),

          Text(
            actor.name == null ? 'no-name' : actor.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center, 
          )

        ]),
    );
  }
}