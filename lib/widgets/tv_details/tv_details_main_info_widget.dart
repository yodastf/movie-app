import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_credit.dart';
import 'package:themoviedb/domain/entity/tv_details_credit.dart';
import 'package:themoviedb/navigation/main_navigation.dart';
import 'package:themoviedb/resources/app_images.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/tv_details/tv_details_model.dart';

class TvDetailMainInfo extends StatelessWidget {
  const TvDetailMainInfo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopPosterWidget(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: _MovieNameWidget(),
        ),
        _Score(),
        _SummaryWidget(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _OverviewWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        SizedBox(height:20),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:  _PeopleWidget(),
        ),
       
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model =NotifierProvider.watch<TvDetailsModel>(context);
    return Text(model?.tvDetails?.overview ?? '',
    style: TextStyle(
            color: Colors.white,
            fontSize:15,
            fontWeight: FontWeight.w400),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Overview',
    style: TextStyle(
              color: Colors.white,
              fontSize:15,
              fontWeight: FontWeight.w400),);
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model=NotifierProvider.watch<TvDetailsModel>(context);
    final backdropPath = model?.tvDetails?.backdropPath;
    final posterPath = model?.tvDetails?.posterpath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          backdropPath != null ? Image.network(ApiClient.imageUrl(backdropPath)) : SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null ? Image.network(ApiClient.imageUrl(posterPath)) : SizedBox.shrink(),),
            Positioned(
              top:5,
              right: 5,
              child: IconButton(onPressed: () => model?.toggleFavorite(), 
              icon: Icon(model?.isFavorite == true ? Icons.star : Icons.star_border_outlined,size: 30,))
            )
        ],
        
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model=NotifierProvider.watch<TvDetailsModel>(context);
    var year = model?.tvDetails?.firstAirDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(
          children:[
            TextSpan(
              text: model?.tvDetails?.name ?? '',
              
              style: TextStyle(
                fontSize:20,
                fontWeight: FontWeight.w600),
              ),
              TextSpan(text: year ,
              style: TextStyle(
                color: Colors.grey,
                fontSize:15,
                fontWeight: FontWeight.w400),),
          ],
        ),
        
        
      ),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvDetails =NotifierProvider.watch<TvDetailsModel>(context)?.tvDetails;
    var voteAverage = tvDetails?.voteAverage ?? 0;
    voteAverage = voteAverage *10;
    final videos = tvDetails?.videos.results.where((video)=> video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key :null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(onPressed: () {},
           
            textColor: Colors.white,
            child: Row(
              children: [
                Icon(Icons.score),
                Text(' ' + voteAverage.toStringAsFixed(0),
                style: TextStyle(fontSize:16,fontWeight: FontWeight.w400),
                ),
              ],
            ),),
        Container(width: 1, height:15,color: Colors.grey,),
         trailerKey != null ? MaterialButton(
           onPressed: () => Navigator.of(context).pushNamed(MainNvigationRouteName.tvTrailerWidget,
           arguments: trailerKey),
            
            textColor: Colors.white,
            child: Row(
              children: [
                Icon(Icons.play_arrow),
                Text(' Play Trailer',
                style: TextStyle(fontSize:16,fontWeight: FontWeight.w400),
                ),
              ],
            ),) : SizedBox.shrink(),
      ],
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final model =NotifierProvider.watch<TvDetailsModel>(context);
     if(model == null) return SizedBox.shrink();
     var text = <String>[];
     final releaseDate = model.tvDetails?.firstAirDate;
     if(releaseDate != null){
       
       text.add(model.stringFormatDate(releaseDate));
     }
     final productionCountries = model.tvDetails?.productionCountries;
     if(productionCountries != null && productionCountries.isNotEmpty){
       text.add('(${productionCountries.first.iso31661})');
     }
     final runtime = model.tvDetails?.episodeRunTime?.first ?? 0;
     
     final duration = Duration(minutes: runtime);
     final hours = duration.inHours;
     final minutes =duration.inMinutes.remainder(60);
     text.add('${hours}h ${minutes}m');
     final genres = model.tvDetails?.genres;
    if(genres != null && genres.isNotEmpty){
      var genresNames = <String> [];
      for (var genr in genres) {
        genresNames.add(genr.name);
      }
      text.add(genresNames.join(', '));
    }

    return ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65,vertical: 10),
            child: Text(text.join(' '),
      
        maxLines: 3,
        textAlign: TextAlign.center,
        style: TextStyle(
                  color: Colors.white,
                  fontSize:15,
                  fontWeight: FontWeight.w400),
      ),
          ),
    );
  }
}



class _PeopleWidget extends StatelessWidget {
   _PeopleWidget({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final model =NotifierProvider.watch<TvDetailsModel>(context);
    var crew = model?.tvDetails?.credits.crew;
     if(crew == null || crew.isEmpty) return SizedBox.shrink();
     crew = crew.length > 4 ? crew.sublist(0,4) : crew;
     var crewChunks = <List<Crew>>[];
     for (var i = 0; i < crew.length; i+=2) {
       crewChunks.add(crew.sublist(i,i+2 > crew.length ? crew.length : i+2));
       
     }
    return  Column(
       children: crewChunks
       .map((chunk) => Padding(padding: EdgeInsets.only(bottom: 20),
       child: _peopleWidgetRow(crews: chunk)
       ),
       
    ).toList()
    );
  }
}

class _peopleWidgetRow extends StatelessWidget {
  final List<Crew> crews;
  const _peopleWidgetRow({ Key? key,required this.crews }) : super(key: key);
     
  @override
  Widget build(BuildContext context) {
    
    return Row(
          mainAxisSize: MainAxisSize.max,
          
              children: crews.map((crews) => _peopleWidgetRowItem(crew: crews,)).toList(),
          
            );
  }
}

class _peopleWidgetRowItem extends StatelessWidget {
  final Crew crew;
  const _peopleWidgetRowItem({ Key? key,required this.crew }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameStyle =TextStyle(
                  color: Colors.white,
                  fontSize:15,
                  fontWeight: FontWeight.w400);
  final jobStyle =TextStyle(
                  color: Colors.white,
                  fontSize:15,
                  fontWeight: FontWeight.w400); 
    return Expanded(
      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(crew.name,style: nameStyle,),
                      Text(crew.job, style: jobStyle,),
                    ],
                  ),
    );
  }
}