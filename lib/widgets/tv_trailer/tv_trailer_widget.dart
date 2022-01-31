import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class TvTrailerWidget extends StatefulWidget {
  final String youtubeKey;
  const TvTrailerWidget({ Key? key,required this.youtubeKey }) : super(key: key);

  @override
  _TvTrailerWidgetState createState() => _TvTrailerWidgetState();
}

class _TvTrailerWidgetState extends State<TvTrailerWidget> {
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
      appBar: AppBar(title: Text('Trailer'),),
     body: Center(child:  player,),
     );
       }
       
       );
   
      
    
  }
}