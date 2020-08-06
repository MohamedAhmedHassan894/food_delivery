import 'package:flutter/cupertino.dart';
import 'package:food_delivery/models/food.dart';
import 'package:http/http.dart' as http;

class CardProvider with ChangeNotifier {
  List<Food> _cardFoods = List<Food>();
  bool _isLoading = false;
  List<Food> _foodWithQuantity = List<Food>();


  bool get isLoading {
    return _isLoading;
  }

  List<Food> get foodWithQuantity {
    return List.from(_foodWithQuantity);
  }
  List<Food> get cardFoods {
    return List.from(_cardFoods);
  }

  int get foodWithQuantityLength {
    return _foodWithQuantity.length;
  }
  int get cardFoodLength {
    return _cardFoods.length;
  }
  Future<void> increaseOrDecreaseQuantity(Food food,String foodId,int inc) async {
    _isLoading = true;
    notifyListeners();
    Food theFood = getFoodItemById(foodId);
    int foodIndex = _foodWithQuantity.indexOf(theFood);
    Food  updateFoodItem = Food(
        imageUrl: food.imageUrl,
        id: food.id,
        discounts: food.discounts,
        description: food.description,
        category: food.category,
        name: food.name,
        price: food.price,
        quantity:  inc==1?food.quantity+1:food.quantity<=0?0:food.quantity-1);
    _foodWithQuantity[foodIndex] = updateFoodItem;
    notifyListeners();
  }

  Future<bool> addCardFood(Food food) async {
    _isLoading = true;
    notifyListeners();
    try {
      Food foodWithQuantity = Food(
          imageUrl: food.imageUrl,
          id: food.id,
          discounts: food.discounts,
          description: food.description,
          category: food.category,
          name: food.name,
          price: food.price,
          quantity: 0);

      _cardFoods.add(food);
      _foodWithQuantity.add(foodWithQuantity);
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> deleteFood(String foodId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // delete item from the list of food items
      _cardFoods.removeWhere((Food food) => food.id == foodId);
      _foodWithQuantity.removeWhere((Food food) => food.id == foodId);

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
    for (int i = 0; i < _foodWithQuantity.length; i++) {
      if (_foodWithQuantity[i].id == foodId) {
        food = _foodWithQuantity[i];
        break;
      }
    }
    return food;
  }
}
