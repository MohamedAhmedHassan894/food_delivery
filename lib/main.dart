import 'package:flutter/material.dart';
import 'package:food_delivery/pages/onboardingpage.dart';
import 'package:food_delivery/pages/signIn.dart';
import 'package:food_delivery/provider/app_provider.dart';
import 'package:food_delivery/provider/card.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:food_delivery/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool seen = pref.getBool('seen');
  Widget _screen ;
  if(seen==null||seen==false){
    _screen=OnBoardingPage();
  }else{
    _screen=ScreensController();
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider.value(value: CardProvider()),

  ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.blueAccent
        ),
        home: _screen,
      )));
}

class ScreensController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
      case Status.Unauthenticated:
        return SignIn();
      case Status.Authenticating:
        return SignIn();
      case Status.Authenticated:
        return MainScreen();
    }
  }
}
