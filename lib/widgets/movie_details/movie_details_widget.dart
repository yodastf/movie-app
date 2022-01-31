
import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/my_app_model.dart';
import 'package:themoviedb/widgets/movie_details/movie_detail_main_cast_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';

import 'movie_details_main_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {

  const MovieDetailsWidget({ 
    Key? key,

    }) : super(key: key);

  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {

  @override
  void initState() {
    super.initState();
    final model= NotifierProvider.read<MovieDetailsModel>(context);
    final appModel = Provider.read<MyAppModel>(context);
    model?.onSessionExpired = () => appModel?.resetSessionId(context);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _TitleWidget()
      ),
      body: ColoredBox(
          color:Color.fromRGBO(24, 23, 27, 1.0),
               child: _BodyWidget()

      ),
      
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final model=NotifierProvider.watch<MovieDetailsModel>(context);
    return Text( model?.movieDetails?.title ?? 'Loading');
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model=NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if(movieDetails == null){
      return Center(child: CircularProgressIndicator());
    }
    return ListView(
          children:[
            MovieDetailMainInfo(),
            SizedBox(height:30),
            MovieDetailMainCastWidget(),
          ]
        );
  }
}