import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/provider/card.dart';
import '../data/data_utilities.dart';
import '../models/category_model.dart';
import '../models/food.dart';
import '../provider/app_provider.dart';
import 'package:provider/provider.dart';
import '../pages/food_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Category> _categories = addCategories();
  TextStyle headerStyle = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider =Provider.of<AppProvider>(context);
    CardProvider cardProvider = Provider.of<CardProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          homeTopInfo(),
          foodCategory(),
          SizedBox(
            height: 20.0,
          ),
          searchField(),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Bought Foods ",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Column(children: appProvider.foods.map(_buildFoodItems).toList(),
          ),

        ],
      ),
    );
  }

  Widget homeTopInfo() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What Would",
                style: headerStyle,
              ),
              Text(
                "you Like to eat ☺?",
                style: headerStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget foodCategory() {
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int position) {
          return foodCard(position);
        },
        itemCount: _categories.length,
      ),
    );
  }

  Widget foodCard(int position) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage(_categories[position].imagePath),
                height: 65.0,
                width: 65.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _categories[position].categoryName,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text("${_categories[position].numberOfItems} kinds"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchField() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 14.0,
          ),
          hintText: "Search any food",
          suffixIcon: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              )),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget boughtFoods(
      {String id,
      String name,
      String imageUrl,
      String category,
      double price,
      double ratings,
      double discounts}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 215.0,
            width: 360.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              width: 360,
              height: 55.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black12,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 17.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 17.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 17.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 17.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 17.0,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "${ratings.toString()} reviews)",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    Text(
                      "Min Order",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItems(Food food) {
    return GestureDetector(
      onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FoodDetailsPage(food);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 23.0),
        child: boughtFoods(
            id: food.id,
            name: food.name,
            imageUrl: food.imageUrl,
            category: food.category,
            price: food.price,
            ratings: food.ratings,
            discounts: food.discounts),
      ),
    );
  }
}
