import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;
import '../enums/auth_model.dart';

enum Status{Uninitialized,Authenticated,Authenticating,Unauthenticated}

class UserProvider with ChangeNotifier{
  bool _isLoading=false;
  User _authenticateUser;
  FirebaseUser _user;
  FirebaseAuth _auth;
  Status _status = Status.Unauthenticated;
  Status get status => _status;
  FirebaseUser get user => _user;

  UserProvider.initialize() : _auth = FirebaseAuth.instance{
    // this will be just listening to the state of the user
    // so every time the state of the user change , onStatusChanged method will be called
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  User get authenticateUser{
    return _authenticateUser;
  }
  bool get isLoading{
    return _isLoading;
  }


  Future<Map<String,dynamic>> authenticate(String email,String password,{AuthModel authModel = AuthModel.signIn}) async{
    _status = Status.Authenticating;
    _isLoading=true;
    notifyListeners();
    Map<String,dynamic> authData ={
      "email":email,
      "password":password,
      "returnSecureToken":true,
    };
    String message;
    bool hasError =false;
    try{
      http.Response  response;
      if(authModel==AuthModel.signUp){
        _status = Status.Authenticating;
        notifyListeners();
        response =await http.post("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBV2MQr5vuRUizyrNpQGdTOx8trWJDN7ys",
            body:json.encode(authData),
            headers:{'Content-Type':'application/json'});
      }else if(authModel==AuthModel.signIn){
        _status = Status.Authenticating;
        notifyListeners();
        response =await http.post("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBV2MQr5vuRUizyrNpQGdTOx8trWJDN7ys",
            body:json.encode(authData),
            headers:{'Content-Type':'application/json'});
      }
      Map<String,dynamic> responseBody=json.decode(response.body);
      if(responseBody.containsKey('idToken')){
        _authenticateUser=User(
          id: responseBody["localId"],
          email: responseBody["email"],
          token: responseBody["idToken"],
          userType: "customer",
        );
        if(authModel==AuthModel.signUp){
          _status = Status.Authenticated;
          message="sign up successfully";
        }else{
          _status = Status.Authenticated;
          message="sign in successfully";
        }
      }else{
        hasError =true;
        if(responseBody['error']['message']=='EMAIL_EXISTS'){
          message="Email already exists";
          print("failed //////////////////");
        }else if(responseBody['error']['message']=='EMAIL_NOT_FOUND'){
          message="Email does not exists";
        }else if(responseBody['error']['message']=='INVALID_ PASSWORD'){
          message="password is incorrect";
        }
      }
      _status = Status.Unauthenticated;
      _isLoading=false;
      notifyListeners();
      return {
        'message':message,
        'hasError':hasError,
      };
    }catch(e){
      Fluttertoast.showToast(msg: "Login Failed ");
      _status = Status.Unauthenticated;
      _isLoading=false;
      notifyListeners();
      return{
        'message':'Failed to sign up successfully',
        'hasError':!hasError
      };
      print("signing up error is : $e");
    }
  }
  Future<bool> googleSignIn() async {
    try{
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      //we will sign this user in (googleUser) bellow
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      //and we will authenticate this user which we just signed in
      GoogleSignInAuthentication googleSignInAuthentication =await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken:googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser firebaseUser = authResult.user;
      if(credential!=null){
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      }else{
        Fluttertoast.showToast(msg: "Login Failed :(");
        _status = Status.Unauthenticated;
        notifyListeners();
        return false;
      }
    }catch(e){
      print("failed //////////////////$e");
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }



  Future signOut ()async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    _auth.signOut();
    _status=Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser user) async{
    if(user==null){
      _status=Status.Unauthenticated;
      notifyListeners();
    }else{
      _user=user;
      _status=Status.Authenticated;
      notifyListeners();

    }
  }
}
