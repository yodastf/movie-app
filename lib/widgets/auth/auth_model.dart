import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();
   final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController(); 
  String? _errorMessage;
  String? get errorMessage =>_errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async{
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if(login.isEmpty || password.isEmpty){
      _errorMessage = 'Input login and password';
      notifyListeners();
      return;
    }

    _errorMessage =null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    int? accountId;
    try {
       sessionId = await _apiClient.auth(username: login, password: password);
       accountId = await _apiClient.getAccountInfo(sessionId);
      
    } on ApiClientException catch (e) {
      switch (e.type) {
        
        case ApiClientExceptionType.Network:
          _errorMessage = 'Server error.Check your internet connecion';
          break;
        case ApiClientExceptionType.Auth:
           _errorMessage = 'Incorrect login or password';
          break;
        case ApiClientExceptionType.Other:
           _errorMessage = 'Error.Try again';
          break;
        case ApiClientExceptionType.SessionExpired:
           _errorMessage = 'Session Expired';
          break;
      }
     
    }
    
    _isAuthProgress = false;
    
    if(_errorMessage != null) {
      
      notifyListeners();
      return;
    }
     
    if(sessionId == null || accountId == null){
      _errorMessage = 'Error, try again';

      notifyListeners();
     
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setaccountId(accountId);
    unawaited( Navigator.of(context).pushReplacementNamed(MainNvigationRouteName.mainScreen));


    

  }

}



