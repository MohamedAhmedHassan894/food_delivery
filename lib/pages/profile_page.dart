import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnNotification = false;
  bool turnOnLocation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(0.0, 4.0),
                          ),
                        ],
                        image: DecorationImage(
                            image:
                                ExactAssetImage("assets/images/breakfast.jpeg"),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Mohamed Hassan",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "+201097816790",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 30.0,
                        width: 65.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.blue,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Edit",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Text("Account",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 15.0,
              ),
              Card(
                elevation: 3.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.visibility,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "Change Password",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "Shipping",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.payment,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              "Payment",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Notifications",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Card(
                elevation: 3.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("App Notification"),
                          Switch(
                            value: turnOnNotification,
                            onChanged: (bool value) {
                              setState(() {
                                turnOnNotification = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Location Tracking"),
                          Switch(
                            value: turnOnLocation,
                            onChanged: (bool value) {
                              setState(() {
                                turnOnLocation = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Other",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Language",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Divider(
                          height: 30.0,
                          color: Colors.grey,
                        ),
                        Text(
                          "Currency",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Divider(
                          height: 30.0,
                          color: Colors.grey,
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
}
