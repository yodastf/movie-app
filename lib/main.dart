

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/Theme/app_colors.dart';
import 'package:themoviedb/my_app_model.dart';
import 'package:themoviedb/navigation/main_navigation.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();   

   final app = MyApp();

  final widget = Provider(model: model, child: app);
  runApp(widget);
}

class MyApp extends StatelessWidget {

  static final mainNvigation = MainNavigation();


  const MyApp({Key? key, 

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.read<MyAppModel>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color:AppColors.mainDarkBlue),
        

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor:AppColors.mainDarkBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          
          ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('uk','UA'),
        Locale('en','US'),
        
      ],
      routes: mainNvigation.routes,
      initialRoute: mainNvigation.initialroute(model?.isAuth == true),
      onGenerateRoute: mainNvigation.onGenerateRoute,
    );
  }
}

