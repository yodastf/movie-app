import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerWidget extends StatefulWidget {
  final String youtubeKey;
  const MovieTrailerWidget({ Key? key,required this.youtubeKey }) : super(key: key);

  @override
  _MovieTrailerWidgetState createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {

  late final YoutubePlayerController _controller ;

  @override
  void initState() {
    super.initState();
  }
  @override
    Widget build(BuildContext context) {

 final player =YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
    
);
    return YoutubePlayerBuilder(
       player: player,
       builder:(context, player){
         return  Scaffold(
      appBar: AppBar(title: Text('Movie'),),
     body: Center(child:  player,),
     );
       }
       
       );
   
      
    
  }
}