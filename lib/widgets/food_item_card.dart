import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/provider/card.dart';
import 'package:provider/provider.dart';

class FoodItemCard extends StatefulWidget {
  final String title;
  final Food food;
  final String description;
  final String price;
  final String image;

  FoodItemCard({
    this.title,
    this.description,
    this.price,
    this.image,
    this.food,
  });

  @override
  _FoodItemCardState createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  @override
  Widget build(BuildContext context) {
    CardProvider cardProvider = Provider.of<CardProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 140.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 0.5,
            color: Colors.black12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: 10.0,
            ),
            height: 105.0,
            width: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Text(
                "${widget.title}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  width: 200,
                  child: Text(
                    "${widget.description}",
                    style: TextStyle(
                      color: Colors.black87.withOpacity(.7),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "\$ ${widget.price}",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (cardProvider.cardFoods.contains(widget.food)) {
                          cardProvider.deleteFood(widget.food.id);
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
                        height: 30.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.blue,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            cardProvider.cardFoods.contains(widget.food)
                                ? "done"
                                : "Buy",
                            style: TextStyle(
                                color:
                                    cardProvider.cardFoods.contains(widget.food)
                                        ? Colors.orange
                                        : Colors.blue,
                                fontSize: 17.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
