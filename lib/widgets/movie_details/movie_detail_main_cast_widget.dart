import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/resources/app_images.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';

class MovieDetailMainCastWidget extends StatelessWidget {
  const MovieDetailMainCastWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    

    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Series Cast',style: TextStyle(fontSize:15,fontWeight:FontWeight.w700),),
          ),
          SizedBox(
            height:300,
            child: Scrollbar(
              child: _ActorListWidget(),
            ),
          ),
         MaterialButton(onPressed: () {},
           
            textColor: Colors.blue,
            child: Text(' Full Cast & Crew',
            style: TextStyle(fontSize:16,fontWeight: FontWeight.w400),
            ),),

        ]
      ),
      
    );
  }
}

class _ActorListWidget extends StatelessWidget {
  const _ActorListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final model =NotifierProvider.watch<MovieDetailsModel>(context);
    var cast = model?.movieDetails?.credits.cast;
     if(cast == null || cast.isEmpty) return SizedBox.shrink();

    return ListView.builder(
      itemCount:10,
      itemExtent: 120,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context,int index)
    {
      return _ActorListItemWidget(actorIndex: index,);
    }
    );
  }
}

class _ActorListItemWidget extends StatelessWidget {
  final int actorIndex;
  const _ActorListItemWidget({
    Key? key,required this.actorIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final model =NotifierProvider.read<MovieDetailsModel>(context);
    final actor = model!.movieDetails!.credits.cast[actorIndex];
    final profilePath = actor.profilePath;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
        color:Colors.white,
        border: Border.all(color:Colors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow:[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 6),
          ),
        ],
      ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                clipBehavior: Clip.hardEdge,
                      child: Column(
          children:[
            profilePath != null ? Image.network(ApiClient.imageUrl(profilePath)) : SizedBox.shrink(),
           
            Expanded(
              child: Padding(padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
              Text(actor.name,maxLines: 1,),
              SizedBox(height:7),
              Text(actor.character,maxLines: 3,),
              SizedBox(height:7),
           
            
                ]
              ),
              ),
            ),

            
          ]
        ),
              ),
      )
    );
  }
}