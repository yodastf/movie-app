import 'package:flutter/cupertino.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/navigation/main_navigation.dart';

class MyAppModel{
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async{
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSessionId(BuildContext context) async{
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setaccountId(null);
    await Navigator.of(context).pushNamedAndRemoveUntil(MainNvigationRouteName.auth, (route) => false);
  }
}