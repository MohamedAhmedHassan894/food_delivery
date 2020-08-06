import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/provider/card.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    CardProvider cardProvider = Provider.of<CardProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: cardProvider.foodWithQuantityLength >= 1
            ? ListView(children: <Widget>[
                Column(
                    children:
                        cardProvider.foodWithQuantity.map(orderCard).toList()),
                buildTotalContainer(cardProvider.foodWithQuantity)
              ])
            : Center(
                child: Container(
                  child: Text(
                    "no order food added to cart",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent.withOpacity(.6)),
                  ),
                ),
              ),
      ),
    );
  }

  Widget orderCard(Food food) {
    CardProvider cardProvider = Provider.of<CardProvider>(context);
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Color(0xFFD3D3D3)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 75.0,
              width: 45.0,
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      cardProvider.increaseOrDecreaseQuantity(food, food.id, 1);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Color(0xFFD3D3D3),
                    ),
                  ),
                  Text(
                    food.quantity.toString(),
                    style: TextStyle(fontSize: 18.0, color: Color(0xFFD3D3D3)),
                  ),
                  InkWell(
                      onTap: () {
                        cardProvider.increaseOrDecreaseQuantity(
                            food, food.id, 0);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFFD3D3D3),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(food.imageUrl),
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: BorderRadius.circular(45.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white10,
                    offset: Offset(0.0, 1.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  food.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  food.price.toString(),
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 25.0,
                  width: 140.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              food.description,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                cardProvider.deleteFood(food.id);
              },
              child: Icon(
                Icons.cancel,
                color: Colors.grey,
                size: 25.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTotalContainer(List<Food> foods) {
    return Container(
      height: 220.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Cart Total",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 16.0),
              ),
              Text(
                calculateTotalPrice(foods),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Discount",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 16.0),
              ),
              Text(
                calculateDiscount(foods),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Tax",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 16.0),
              ),
              Text(
                "0.${foods.length}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0),
              ),
            ],
          ),
          Divider(
            height: 40.0,
            color: Color(0xFFD3D3D3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Sub Total",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 16.0),
              ),
              Text(
                 calculateSubTotal(foods),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Center(
                child: Text(
                  "processed to checkout",
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
    );
  }

  String calculateTotalPrice(List<Food> foods) {
    double total = 0.0;
    if (foods.length > 0) {
      for (int i = 0; i < foods.length; i++) {
        total = foods[i].quantity > 0
            ? total + (foods[i].quantity) * (foods[i].price)
            : total + (foods[i].price);
      }
      total=total.roundToDouble();
      return "$total";
    } else {
      return "0";
    }
  }

  String calculateDiscount(List<Food> foods) {
    double discount = 0.0;
    if (foods.length > 0) {
      for (int i = 0; i < foods.length; i++) {
        discount = foods[i].quantity > 0
            ? discount + (foods[i].quantity) * (foods[i].discounts)
            : discount + (foods[i].discounts);
      }
      discount=discount.roundToDouble();
      return "$discount";
    } else {
      return "0";
    }
  }

  String calculateSubTotal(List<Food> foods) {
    double subTotal=0.0;
    if (foods.length > 0) {
      for (int i = 0; i < foods.length; i++) {
        subTotal = foods[i].quantity > 0
            ? subTotal + (foods[i].quantity) * ((foods[i].price)+(foods[i].discounts))
            : subTotal + (foods[i].price+foods[i].discounts);
      }
      subTotal=subTotal+(foods.length/10);
      subTotal=subTotal.roundToDouble();
      return "$subTotal";
    } else {
      return "0";
    }
  }
}
