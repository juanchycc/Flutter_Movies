import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/helpers/debouncer.dart';
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '0db32b83579802d38b8563aae83df00e';
  final String _language = 'es-AR';

  List<Movie> movies = [];
  List<Movie> populars = [];

  Map<String, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration( milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;
  
  MoviesProvider(){
    print('Movies Provider Inicializado');

    getOnDisplayMovies();
    getPopularMovies();

  }

  Future<String> _getJsonData( String baseVar, [int pageNum = 1] ) async{

    var url = Uri.https(_baseUrl, '3/movie/$baseVar' , {
      'api_key': _apiKey,
      'language': _language,
      'page': '$pageNum'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    if( response.statusCode != 200 ) return 'error';

    return response.body;
  }

  getOnDisplayMovies() async{

    final body = await _getJsonData('now_playing');

    //Convierte la respuesta de la petición http en la clase 
    final nowPlayingResponse = NowPlayingResponse.fromJson( body );
    
    movies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async{

    _popularPage++;

    final body = await _getJsonData('popular', _popularPage);
    //Convierte la respuesta de la petición http en la clase 
    final popularResponse = PopularResponse.fromJson( body );
    
    populars = [ ...populars, ...popularResponse.results ];

    notifyListeners();

  }

  Future<List<Cast>> getMovieCast( String id ) async {

    if( moviesCast.containsKey(id)) return moviesCast[id]!;

    final body = await _getJsonData('$id/credits', _popularPage);
    final creditsResponse = CreditsResponse.fromJson( body );

    moviesCast[id] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies( String query ) async{

    //if( query.isEmpty ) return [];

    var url = Uri.https(_baseUrl, '3/search/movie' , {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponses = SearchResponse.fromJson( response.body );

    return searchResponses.results;
  }

  void getSuggestionsByQuery( String searchTerm ){

    debouncer.value = '';
    debouncer.onValue = ((value) async {
      
      final results = await searchMovies(value);
      _suggestionStreamController.add( results );

    });
    
    final timer = Timer.periodic( const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration( milliseconds: 301)).then((_) => timer.cancel());

  }

}





