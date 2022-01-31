import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/widgets/home_screen/home_screen_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_widget.dart';
import 'package:themoviedb/widgets/tv_list/tv_list_model.dart';
import 'package:themoviedb/widgets/tv_list/tv_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({ Key? key }) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab=0;
  final movieListModel = MovieListModel();
  final tvListModel = TvListModel();
  

  void onSelectedTab(int index){
    if(_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });

  }

    
    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      movieListModel.setupLocale(context);
      tvListModel.setupLocale(context);
      
    }

  @override
  Widget build(BuildContext context) {
       final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null), 
            icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
         
          NotifierProvider(
            create:() => movieListModel,
            isManagingModel: false,
            child:HomeScreenWidget()),
          NotifierProvider(
            create:() => movieListModel,
            isManagingModel: false,
            child: MovieListWidget()),
         
         NotifierProvider(
         
            create:() => tvListModel,
            isManagingModel: false,
            child: TvListWidget()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title:Text('Home'),),
          BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          title:Text('Movie'),),
          BottomNavigationBarItem(
          icon: Icon(Icons.tv),
          title:Text('TV Shows'),),
          
      ],
      onTap: onSelectedTab,
      )
      
    );
  }
}