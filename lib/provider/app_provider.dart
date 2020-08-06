import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/models/food.dart';
import 'package:http/http.dart' as http;

class AppProvider with ChangeNotifier {
  AppProvider() {
    fetchFoods();
  }

  List<Food> _foods = List<Food>();
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Food> get foods {
    return List.from(_foods);
  }

  int get foodLength {
    return _foods.length;
  }

  Future<bool> addFood(Food food) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> foodData = {
        "name": food.name,
        "description": food.description,
        "category": food.category,
        "price": food.price,
        "discount": food.discounts,
        "image": food.imageUrl
      };
      final http.Response response = await http.post(
          "https://food-e6ef9.firebaseio.com/foods.json",
          body: json.encode(foodData));

      final Map<String, dynamic> responeData = json.decode(response.body);

      Food foodWithID = Food(
          id: responeData["name"],
          name: food.name,
          description: food.description,
          category: food.category,
          discounts: food.discounts,
          price: food.price,
          imageUrl: food.imageUrl);

      _foods.add(foodWithID);
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> fetchFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
          await http.get("https://food-e6ef9.firebaseio.com/foods.json");
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((String id, dynamic foodData) {
        Food foodItem = Food(
            id: id,
            name: foodData["name"],
            description: foodData["description"],
            category: foodData["category"],
            price: double.parse(foodData["price"].toString()),
            discounts: double.parse(foodData["discount"].toString()),
            imageUrl: foodData["image"]);

        foodItems.add(foodItem);
      });

      _foods = foodItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      print("The error: $error");
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> updateFood(Map<String, dynamic> foodData, String foodId) async {
    _isLoading = true;
    notifyListeners();

    // get the food by id
    Food theFood = getFoodItemById(foodId);

    // get the index of the food
    int foodIndex = _foods.indexOf(theFood);
    try {
      await http.put("https://food-e6ef9.firebaseio.com/foods/${foodId}.json",
          body: json.encode(foodData));

      Food updateFoodItem = Food(
          id: foodId,
          name: foodData["name"],
          category: foodData["category"],
          discounts: foodData['discount'],
          price: foodData['price'],
          description: foodData['description'],
          imageUrl: foodData["image"]);

      _foods[foodIndex] = updateFoodItem;

      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> deleteFood(String foodId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http
          .delete("https://food-e6ef9.firebaseio.com/foods/${foodId}.json");

      // delete item from the list of food items
      _foods.removeWhere((Food food) => food.id == foodId);

      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Food getFoodItemById(String foodId) {
    Food food;
    for (int i = 0; i < _foods.length; i++) {
      if (_foods[i].id == foodId) {
        food = _foods[i];
        break;
      }
    }
    return food;
  }
}
