import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/widgets/loading.dart';
import '../enums/auth_model.dart';
import '../pages/signIn.dart';
import '../provider/user_provider.dart';
import '../screens/main_screen.dart';
import '../widgets/show_dialog.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _toggleVisibility = true;

  String _password;

  String _userName;

  String _email;

  GlobalKey<FormState> _formKey = GlobalKey();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        body: user.status==Status.Authenticating ? Loading():SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 100, 0, 0),
                      child: Text(
                        'Hello ',
                        style: TextStyle(
                          color: Colors.blue,
                            fontSize: 60.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        'There',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 60.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35, left: 25, right: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onSaved: (String userName) {
                            _userName = userName;
                          },
                          validator: (String userName) {
                            String errorMessage;
                            if (userName.isEmpty) {
                              errorMessage = "userName required";
                            }
                            return errorMessage;
                          },
                          decoration: InputDecoration(
                            labelText: "USERNAME",
                            prefixIcon: Icon(FontAwesomeIcons.userCircle,color: Colors.blueGrey,),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onSaved: (String email) {
                            _email = email;
                          },
                          validator: (String email) {
                            String errorMessage;
                            if (!email.contains("@")) {
                              errorMessage = "invalid email";
                            }
                            return errorMessage;
                          },
                          decoration: InputDecoration(
                            labelText: "EMAIL",
                            prefixIcon: Icon(Icons.email,color: Colors.blueGrey,),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: _toggleVisibility,
                          onSaved: (String Password) {
                            _password = Password;
                          },
                          validator: (String Password) {
                            String errorMessage;
                            if (Password.isEmpty) {
                              errorMessage = "Password required";
                            }
                            return errorMessage;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _toggleVisibility = !_toggleVisibility;
                                });
                              },
                              icon: _toggleVisibility
                                  ? Icon(
                                      Icons.visibility_off,color: Colors.blueGrey,
                                    )
                                  : Icon(Icons.visibility,color: Colors.blueGrey,),
                            ),
                            labelText: "PASSWORD",
                            prefixIcon: Icon(FontAwesomeIcons.passport,color: Colors.blueGrey,),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            onSubmit(user.authenticate);
                          },
                          child: Container(
                            height: 40,
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              shadowColor: Colors.orangeAccent,
                              color: Colors.orange,
                              elevation: 7.0,
                              child: Center(
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Already have an account ?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.orange
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: MediaQuery.of(context).size.width*.25,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black26.withOpacity(0.1),
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                color: Colors.blueGrey.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return SignIn();
                                        }));},
                                  child: Text('Sign In',
                                    style:TextStyle(
                                        color:Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                    ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSubmit(Function authenticate) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showLoadingIndicator(context, "Signing up....");
      authenticate(_email, _password, authModel: AuthModel.signUp)
          .then((final response) {
        Navigator.of(context).pop();
        if (!response['hasError']) {
          Navigator.of(context).pop();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return MainScreen();
          }));
          ;
          //navigate to the home page
        } else {
          Navigator.of(context).pop();
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text(response['message']),
          ));
        }
      });
    }
  }
}
