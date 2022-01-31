import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/entity/tv_details.dart';


class TvDetailsModel extends ChangeNotifier{
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  final int tvId;
  TvDetails? _tvDetails;
  String _locale='';
  late DateFormat _dateFormat;
  bool _isFavorite = false;
  Future<void>? Function()? onSessionExpired;

  
  TvDetails? get tvDetails => _tvDetails;
  bool get isFavorite => _isFavorite;

  TvDetailsModel(this.tvId);

  String stringFormatDate(DateTime? date) => date !=null ? _dateFormat.format(date) : '';
  
  Future<void> setupLocale(BuildContext context) async{
    final locale = Localizations.localeOf(context).toLanguageTag();
    if(_locale == locale) return;
    _locale=locale;
    _dateFormat = DateFormat.yMMMd(locale);
  
    await loadDetails();
  }
  Future<void> loadDetails() async{

    try {
      _tvDetails = await _apiClient.tvDetails(tvId, _locale);
    final sessionId = await _sessionDataProvider.getSessionId();
    if(sessionId != null){
      _isFavorite = await _apiClient.isFavoriteTv(tvId, sessionId);
    }
    
    notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }


  }

  Future<void> toggleFavorite() async{
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getaccountId();
    if(sessionId == null || accountId == null) return;

     _isFavorite = !_isFavorite;
    
      notifyListeners();

      try {
        await _apiClient.markAsFavorite(
      accountId: accountId, 
       sessionId: sessionId,
      
      mediaType: MediaType.Tv,
      mediaId: tvId,
      isFavorite: _isFavorite);
      } on ApiClientException catch (e) {
      _handleApiClientException(e);
    

      
      }
  }

  void _handleApiClientException(ApiClientException exception){
     switch (exception.type) {
        
        case ApiClientExceptionType.SessionExpired:
         onSessionExpired?.call();
          break;
        default: print(exception);
      }

  }

}