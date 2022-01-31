
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/domain/entity/popular_tv_response.dart';
import 'package:themoviedb/domain/entity/tv_popular.dart';
import 'package:themoviedb/navigation/main_navigation.dart';

class TvListModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final _tvs = <TvPopular>[]; 
  List<TvPopular> get tvs => List.unmodifiable(_tvs);
  late DateFormat _dateFormat;
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;
   String _locale= 'uk-UA';
   String? _searchQuery;
   Timer? searchDebounce;

   Future<void> setupLocale(BuildContext context) async{
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale=locale;
    _dateFormat = DateFormat.yMMMd(locale);
  
    await _resetList();
  }

  Future<void> _resetList() async{
     _currentPage =0;
    _totalPage = 1;
    _tvs.clear();
    await _loadNextPage();
  }
  
  Future<PopularTvResponse> _loadTv(int nextPage, String locale) async{
    final query = _searchQuery;
    if(query == null){
      return await _apiClient.popularTv(nextPage, _locale);
    }else{
       return await _apiClient.searchTv(nextPage, _locale,query);
    }
  }

  Future<void> _loadNextPage() async{
    if(_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    
    final nextPage = _currentPage + 1;

    try {
       
        final tvResponse = await _loadTv(nextPage, _locale);
    _tvs.addAll(tvResponse.tvs);
    _currentPage = tvResponse.page;
    _totalPage =tvResponse.totalPages;
    _isLoadingInProgress = false;
    notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
   

  }

  void showMoiveAtIndex(int index){
    if(index < _tvs.length - 1) return;
    _loadNextPage();

  }
 
  String stringFormatDate(DateTime? date) => date !=null ? _dateFormat.format(date) : '';


  Future<void> searchMovie(String text) async{
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 300),() async{

      final searchQuery = text.isNotEmpty ? text : null;
    if(_searchQuery == searchQuery) return;
    _searchQuery =searchQuery;
    await _resetList();
    });
    
  }

   void onTvTap(BuildContext context, int index) {
     
    final id = _tvs[index].id;
    Navigator.of(context).pushNamed(MainNvigationRouteName.tvDetails,
    arguments: id,
    );


    }
}