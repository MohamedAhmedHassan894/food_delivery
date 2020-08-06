import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/widgets/loading.dart';
import '../pages/SignUp.dart';
import '../provider/user_provider.dart';
import '../screens/main_screen.dart';
import '../widgets/show_dialog.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _toggleVisibility = true;

  String _Password;

  String _email;

  GlobalKey<FormState> _formKey = GlobalKey();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: user.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                          child: Text(
                            'Food',
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: 65.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 175, 0, 0),
                          child: Text(
                            'Delivery',
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: 65.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 35, left: 25, right: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            onChanged: (String email) {
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
                              fillColor: Colors.blueGrey.shade700,
                              labelText: "EMAIL",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            obscureText: _toggleVisibility,
                            onChanged: (String Password) {
                              _Password = Password;
                            },
                            validator: (String Password) {
                              String errorMessage;
                              if (!Password.isNotEmpty) {
                                errorMessage = "Password required";
                              }
                              return errorMessage;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.blueGrey.shade700,
                              labelText: "PASSWORD",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _toggleVisibility = !_toggleVisibility;
                                  });
                                },
                                icon: _toggleVisibility
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.blue,
                                      )
                                    : Icon(Icons.visibility,
                                        color: Colors.blue),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            alignment: Alignment(1, 0),
                            padding: EdgeInsets.only(top: 15, left: 20.0),
                            child: InkWell(
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
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
                                    'LOGIN',
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
                          GestureDetector(
                            onTap: () async {
                              showLoadingIndicator(context, "Signing in....");
                              if (!await user.googleSignIn()) {
                                _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text("Sign in failed")));
                                return;
                              }
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return MainScreen();
                              }));
                            },
                            child: Container(
                              height: 40,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 2.0,
                                  ),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Icon(
                                        FontAwesomeIcons.google,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Center(
                                      child: Text(
                                        "Log in With Google",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Need An Account ?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SignUp();
                          }));
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  void onSubmit(Function authenticate) {
    if (_formKey.currentState.validate()) {
      showLoadingIndicator(context, "Signing in....");
      authenticate(_email, _Password).then((final response) {
        if (!response['hasError']) {
          Navigator.of(context).pop();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MainScreen();
          }));
        } else {
          Navigator.of(context).pop();
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text("incorrect email or Password"),
          )); // show error in snackBar
        }
      });
    }
  }
}
