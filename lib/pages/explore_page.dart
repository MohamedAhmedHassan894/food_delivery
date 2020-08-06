import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../admin/pages/add_food_item.dart';
import '../provider/app_provider.dart';
import '../widgets/food_item_card.dart';
import 'package:provider/provider.dart';
import '../widgets/show_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider =Provider.of<AppProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: RefreshIndicator(
              onRefresh: appProvider.fetchFoods,
              child: ListView.builder(
                  itemCount: appProvider.foodLength,
                  itemBuilder: (BuildContext ictx, int index) {
                    return GestureDetector(
                      onTap: () async {
                        AwesomeDialog(
                          dismissOnTouchOutside: false,
                          btnOkColor: Colors.lightBlue,
                          context: context,
                          dialogType: DialogType.WARNING,
                          headerAnimationLoop: false,
                          animType: AnimType.TOPSLIDE,
                          title: 'Warning',
                          desc: 'Are you sure you want to update the item',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async{
                            final bool response = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return AddFoodItem(
                                    food: appProvider.foods[index],
                                  );
                                }));
                            if (response) {
                              SnackBar snackBar = SnackBar(
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.blueAccent,
                                  content: Text(
                                    "Food item successfully updated",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ));
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          },
                        )..show();

                      },
                      onDoubleTap: () {
                        // delete food item
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          headerAnimationLoop: false,
                          animType: AnimType.RIGHSLIDE,
                          title: 'Warning',
                          desc: 'Are you sure you want to delete the item',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            showLoadingIndicator(context, "Deleting food item...");
                            appProvider.deleteFood(appProvider.foods[index].id)
                                .then((bool response) {
                              Navigator.of(context).pop();//this to remove dialog
                            });
                          },
                        )..show();


                      },
                      child: FoodItemCard(
                        title: appProvider.foods[index].name,
                        description: appProvider.foods[index].description,
                        price: appProvider.foods[index].price.toString(),
                        image : appProvider.foods[index].imageUrl,
                        food: appProvider.foods[index],
                      ),
                    );
                  })),
        ),
    );
  }
}
