import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/navigation/main_navigation.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:[
       SizedBox(height: 20,),
       Padding(
         padding: const EdgeInsets.only(left: 10),
         child: Text("What`s popular",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
       ) ,
       SizedBox(height: 20,),
      SizedBox(
        height: 300,

        child: PopularListWidget(),
        ),
      Padding(
        padding: const EdgeInsets.only(top:30,bottom: 20),
        child: TrailerInfoWidget(),
      )
    
        
        
        ]
      
    );
  }
}
  

class TrailerInfoWidget extends StatelessWidget {
  const TrailerInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if(model == null) return SizedBox.shrink();
     final movieDetails =NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
     final videos = movieDetails?.videos.results.where((video)=> video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key :null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Stack(
        children: [
          Container(
            height: 400,
            
             color: Color.fromRGBO(3, 37, 65, 0.9),
    
          ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 23,left: 10),
              child: Text('Latest Trailers',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            Center(
              child: SizedBox(
                height: 315,
                child: 
                ListView.builder(
                  itemCount: model.movies.length,
    
                itemExtent: 350,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context,int index)
      {          model.showMoiveAtIndex(index);
            final movie = model.movies[index];
            final backdropPath = movie.backdropPath;
                return    
                Padding(
     
       padding: const EdgeInsets.only(top:35.0,right: 10,left: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
        color:Colors.transparent,
       
        boxShadow:[
          BoxShadow(
            color: Colors.transparent,
          
          ),
        ],
      ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                clipBehavior: Clip.hardEdge,
                      child: Column(
          children:[
          
          Card(clipBehavior: Clip.hardEdge,
            child: Stack(
              children:[ SizedBox(
            
                height: 200,
                width:350 ,
                child: backdropPath !=null ? Image.network(ApiClient.imageUrl(backdropPath),fit: BoxFit.fill,
          
                ) : SizedBox.shrink(),),
                Positioned( 
                
                height: 200,width: 320,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pushNamed(MainNvigationRouteName.movieTrailerWidget,
           arguments: trailerKey), 
                  icon: Icon(Icons.play_arrow_rounded,size: 100,color: Colors.white,))),
                
              ]), 
          ),
           
            Expanded(
              child: Padding(padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
              
                Text(movie.title,
                
                maxLines: 1,style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height:7),
           
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
      ),
              ),
            ),
          ],
        ),
          
        ],

      ),
    );
  }
}





class PopularListWidget extends StatelessWidget {
    const PopularListWidget({ Key? key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if(model == null) return SizedBox.shrink();
    return Stack(
      children: [
        ListView.builder(
          scrollDirection: Axis.horizontal,
       
          itemCount: model.movies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index){
            model.showMoiveAtIndex(index);
            final movie = model.movies[index];
            final posterPath = movie.posterPath;

            return Padding(padding: EdgeInsets.symmetric(horizontal:16, vertical:10),
            child: Stack(
              children: [
                Container(
                  
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
                
                clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: 
                     [
       
                       posterPath != null ? Image.network(ApiClient.imageUrl(posterPath), ): SizedBox.shrink(),
       
                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height:10),
                               Text(
                                 movie.title,
                                 style: TextStyle(fontWeight: FontWeight.bold),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,

                               ),
                               SizedBox(height:5),
                               Text(
                                 model.stringFormatDate(movie.releaseDate),
                                 style: TextStyle(color: Colors.grey),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,

                               ),
                               SizedBox(height:20),
       
                                 
                             ],
                             
                           ),
                         ),
                       )

                     ],
                     ),
                ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => model.onMovieTap(context, index),
                  ),
              ),
              ],
            ),
            
            );
          
        }),
       
      ],
    );
  }
}