
import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/my_app_model.dart';
import 'package:themoviedb/widgets/movie_details/movie_detail_main_cast_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/tv_details/tv_details_main_cast_widget.dart';
import 'package:themoviedb/widgets/tv_details/tv_details_main_info_widget.dart';
import 'package:themoviedb/widgets/tv_details/tv_details_model.dart';



class TvDetailsWidget extends StatefulWidget {

  const TvDetailsWidget({ 
    Key? key,

    }) : super(key: key);

  @override
  _TvDetailsWidgetState createState() => _TvDetailsWidgetState();
}

class _TvDetailsWidgetState extends State<TvDetailsWidget> {

  @override
  void initState() {
    super.initState();
    final model= NotifierProvider.read<TvDetailsModel>(context);
    final appModel = Provider.read<MyAppModel>(context);
    model?.onSessionExpired = () => appModel?.resetSessionId(context);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    NotifierProvider.read<TvDetailsModel>(context)?.setupLocale(context);
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
     final model=NotifierProvider.watch<TvDetailsModel>(context);
    return Text( model?.tvDetails?.originalName ?? 'Loading');
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model=NotifierProvider.watch<TvDetailsModel>(context);
    final tvDetails = model?.tvDetails;
    if(tvDetails == null){
      return Center(child: CircularProgressIndicator());
    }
    return ListView(
          children:[
            TvDetailMainInfo(),
            SizedBox(height:30),
            TvDetailMainCastWidget(),
          ]
        );
  }
}