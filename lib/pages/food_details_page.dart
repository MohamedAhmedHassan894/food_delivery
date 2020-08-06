import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/provider/card.dart';
import 'package:provider/provider.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;

  FoodDetailsPage(this.food);

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int qua = 0;

  var _mediumSpace = SizedBox(
    height: 20.0,
  );

  var _smallSpace = SizedBox(
    height: 10.0,
  );

  var _largeSpace = SizedBox(
    height: 50.0,
  );
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    CardProvider cardProvider = Provider.of<CardProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Food details",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.food.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              _mediumSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.food.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "\u{20b5} ${widget.food.price}",
                    style: TextStyle(
                        fontSize: 16.0, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              _mediumSpace,
              Text("Description",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  )),
              _smallSpace,
              Text(
                "${widget.food.description}",
                textAlign: TextAlign.justify,
              ),
              _mediumSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {
                        setState(() {
                          qua++;
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.food.quantity == null
                        ? qua.toString()
                        : widget.food.quantity.toString(),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() {
                          qua <= 0 ? qua = 0 : qua--;
                        });
                      }),
                ],
              ),
              _largeSpace,
              GestureDetector(
                onTap: () async{
                  if (cardProvider.cardFoods.contains(widget.food)) {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                      content: Text("Already in the cart",style: TextStyle(fontSize: 16),),
                    ));
                  } else {
                    cardProvider.addCardFood(widget.food);
                    await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.TOPSLIDE,
                        padding: EdgeInsets.all(0),
                  title: "!تم الإضافة بنجاح",
                  desc: "this food has been added successfully",
                  dismissOnTouchOutside: true,
                  headerAnimationLoop: false,
                  ).show();
                }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color:cardProvider.cardFoods.contains(widget.food) ?Colors.orangeAccent.withOpacity(.8):Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text(
                      cardProvider.cardFoods.contains(widget.food)
                          ? "Already in the cart"
                          : "Add to cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
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
