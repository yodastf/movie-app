


import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:themoviedb/widgets/tv_details/tv_details_model.dart';
import 'package:themoviedb/widgets/tv_details/tv_details_widget.dart';

abstract class MainNvigationRouteName{
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
    static const movieTrailerWidget = '/movie_details/trailer';
    static const tvDetails = '/tv_details';
    static const tvTrailerWidget = '/tv_details/trailer';

}

class MainNavigation{

  String initialroute(bool isAuth) => isAuth ?  MainNvigationRouteName.mainScreen : MainNvigationRouteName.auth;

  final routes = <String, Widget Function(BuildContext)>{
   MainNvigationRouteName.auth: (context)=> NotifierProvider(create:() => AuthModel(), child: AuthWidget()),
        MainNvigationRouteName.mainScreen: (context)=> NotifierProvider(create:() => MainScreenModel(),child:MainScreenWidget() ,),

    
  };

  Route<Object> onGenerateRoute(RouteSettings settings){
    switch (settings.name){
      case MainNvigationRouteName.movieDetails:
      final arguments =settings.arguments;
      final movieId = arguments is int ? arguments : 0;
      return MaterialPageRoute(
        builder: (context) => NotifierProvider(create:() => MovieDetailsModel(movieId), child: MovieDetailsWidget()), 
        );
      case MainNvigationRouteName.movieTrailerWidget:
        final arguments =settings.arguments;
      final youtubeKey = arguments is String ? arguments : '';
       return MaterialPageRoute(
        builder: (context) => MovieTrailerWidget(youtubeKey: youtubeKey)
        
        );
        case MainNvigationRouteName.tvDetails:
      final arguments =settings.arguments;
      final tvId = arguments is int ? arguments : 0;
      return MaterialPageRoute(
        builder: (context) => NotifierProvider(create:() => TvDetailsModel(tvId), child: TvDetailsWidget()),
        );
        case MainNvigationRouteName.tvTrailerWidget:
        final arguments =settings.arguments;
      final youtubeKey = arguments is String ? arguments : '';
       return MaterialPageRoute(
        builder: (context) => MovieTrailerWidget(youtubeKey: youtubeKey));
      default:
      const widget = Text('Navigation error');
      return MaterialPageRoute(builder: (context) => widget); 
      

    }
  }
}