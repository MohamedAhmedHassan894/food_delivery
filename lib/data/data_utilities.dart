import '../models/category_model.dart';
import '../models/food.dart';

List<Category> addCategories() {
  List<Category> categories = [];
  categories.add(Category(
    numberOfItems: 43,
    imagePath: 'assets/images/burger.png',
    categoryName: " Burger ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/pizza.png',
    categoryName: " Pizza ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/breakfast.png',
    categoryName: " breakfast ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/beer.png',
    categoryName: " beer ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/cheeseburger.png',
    categoryName: " cheeseburger ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/coffee-cup.png',
    categoryName: " coffee-cup ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/cupcake.png',
    categoryName: " cupcake ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/lunch.jpeg',
    categoryName: " lunch ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/supper_1.jpeg',
    categoryName: " supper ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/turkey.png',
    categoryName: " turkey ",
  ));
  categories.add(Category(
    numberOfItems: 23,
    imagePath: 'assets/images/breakfast.jpeg',
    categoryName: " breakfast ",
  ));
  return categories;
}


