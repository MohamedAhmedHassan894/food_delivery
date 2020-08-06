import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/admin/pages/add_food_item.dart';
import 'package:food_delivery/pages/signIn.dart';
import '../pages/home_page.dart';
import '../pages/order_page.dart';
import '../pages/explore_page.dart';
import '../pages/profile_page.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../provider/user_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HomePage homePage;

  OrderPage orderPage;
  ExplorePage explorePage;
  ProfilePage profilePage;
  List<Widget> pages;
  Widget currentPage;
  int currentTabIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    homePage = HomePage();
    orderPage = OrderPage();
    explorePage = ExplorePage();
    profilePage = ProfilePage();
    pages = [homePage, explorePage, orderPage, profilePage];
    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            currentTabIndex == 0
                ? "Food App"
                : currentTabIndex == 1
                    ? "All Food Items"
                    : currentTabIndex == 2 ? "Orders" : "Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {}),
            IconButton(icon: _buildShoppingCart()),
          ],
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50), topRight: Radius.circular(50)),
          child: Container(
            height: MediaQuery.of(context).size.height*.3,
            width: MediaQuery.of(context).size.width * .45,
            child: Drawer(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * .13,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Center(
                      child:RaisedButton.icon(
                        color: Colors.orangeAccent,
                          onPressed: () async {
                            Navigator.of(context).pop();
                            final bool response = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return AddFoodItem();
                            // ignore: missing_return
                            }));
                            if(response){
                              SnackBar snackBar = SnackBar(
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.blueAccent,
                                  content: Text(
                                    "Food item successfully added",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ));
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                            }, icon: Icon(Icons.add,color: Colors.white,), label: Text("add food item")),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 17,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton.icon(
                      onPressed: () {
                        user.signOut();
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return SignIn();
                        }));
                      },
                      color: Colors.blueAccent,
                      label: Text("Log out"),
                      icon: Icon(
                        Icons.transit_enterexit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Colors.white54,
          selectedIndex: currentTabIndex,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (int index) {
            setState(() {
              currentTabIndex = index;
              currentPage = pages[index];
            });
          },
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                activeColor: Colors.blueAccent,
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: Icon(Icons.explore),
                title: Text("Explore"),
                activeColor: Colors.blueAccent,
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text("Orders"),
                activeColor: Colors.blueAccent,
                textAlign: TextAlign.center),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                activeColor: Colors.blueAccent,
                textAlign: TextAlign.center),
          ],
        ),
        body: currentPage,
      ),
    );
  }

  Widget _buildShoppingCart() {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.shopping_cart,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            height: 14.0,
            width: 12.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), color: Colors.red),
            child: Center(
              child: Text(
                "1",
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
