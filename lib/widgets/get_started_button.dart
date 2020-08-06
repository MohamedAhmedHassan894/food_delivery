import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/constants.dart';
import '../pages/signIn.dart';
class GetStartedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 40.0,
      width: 130.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(27.0),
        ),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                _updateSeen();
                return SignIn();
              }));
        },
        color: Colors.blueGrey.shade300,
        child: Center(
            child: Padding(
          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: Text(
            "GET STARTED",
            style: TextStyle(
              fontFamily: Constants.POPPINS,
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        )),
      ),
    );
  }
  void _updateSeen()async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('seen', true);
  }
}
