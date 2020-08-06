import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/provider/app_provider.dart';
import 'package:food_delivery/widgets/show_dialog.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class AddFoodItem extends StatefulWidget {
  final Food food;

  AddFoodItem({this.food});

  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  String title;

  String category;

  String description;

  String price;

  String discount;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  File _image1;
  bool isLoading = false;
  String imageUrl;
  bool imageExist;
  @override
  void initState() {
    imageExist=widget.food!=null?true:false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop(false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                }),
            title: Text(
                widget.food != null ? "Update Food Item" : "Add Food Item",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
          ),
          key: _scaffoldStateKey,
          body: Form(
            key: _foodItemFormKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              child: OutlineButton(
                                onPressed: () {
                                   _selectImage(pickImage :ImagePicker.pickImage(
                                       source: ImageSource.gallery));},
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 2.5),
                                child: displayChild1(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildTextFormField(
                      "Food Title",
                    ),
                    _buildTextFormField(
                      "Category",
                    ),
                    _buildTextFormField(
                      "Description",
                      maxLine: 5,
                    ),
                    _buildTextFormField("Price"),
                    _buildTextFormField(
                      "Discount",
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            onSubmit(
                                appProvider.addFood, appProvider.updateFood);
                          },
                          child: Text(
                            widget.food != null
                                ? "Update Food Item"
                                : "Add Food Item",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function addFood, Function updateFood) async {
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();
      //updating item
      if (widget.food != null) {
        if(_image1==null&&title==widget.food.name&&
            category==widget.food.category&&
            description==widget.food.description&&price.toString()==widget.food.price.toString()&&discount.toString()==widget.food.discounts.toString()){
          SnackBar snackBar = SnackBar(
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
              content: Text("warning: you didn't update food item "));
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }else if(_image1==null) {
          Fluttertoast.showToast(
              msg: " you didn't update food image",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
          showLoadingIndicator(context, "updating food item....");
          Map<String, dynamic> updateFoodItem = {
            "name": title,
            "category": category,
            "description": description,
            "price": double.parse(price),
            "discount": discount != null ? double.parse(discount) : 0.0,
            "image": widget.food.imageUrl
          };
          final bool response =
          await updateFood(updateFoodItem, widget.food.id);
          if (response) {
            Navigator.of(context).pop(); //this pop to remove the alert dialog
            Navigator.of(context).pop(
                response); // and this to move to the previous page  sending value which =true pop(*)
          }else if (!response) {
            Navigator.of(context).pop();
            SnackBar snackBar = SnackBar(
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
                content: Text("Failed to update Food item"));
            _scaffoldStateKey.currentState.showSnackBar(snackBar);
          }
        }else if(_image1!=null) {
          showLoadingIndicator(context, "updating food item....");
          String fileName = p.basename(_image1.path);
          StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
          StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image1);
          StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
          imageUrl = await taskSnapshot.ref.getDownloadURL();
          Map<String, dynamic> updateFoodItem = {
            "name": title,
            "category": category,
            "description": description,
            "price": double.parse(price),
            "discount": discount != null ? double.parse(discount) : 0.0,
            "image": imageUrl.toString()
          };
          final bool response =
          await updateFood(updateFoodItem, widget.food.id);
          if (response) {
            Navigator.of(context).pop(); //this pop to remove the alert dialog
            Navigator.of(context).pop(
                response); // and this to move to the previous page  sending value which =true pop(*)
          } else if (!response) {
            Navigator.of(context).pop();
            SnackBar snackBar = SnackBar(
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
                content: Text("Failed to update Food item"));
            _scaffoldStateKey.currentState.showSnackBar(snackBar);
          }
        }



        //adding item
      } else if (widget.food == null) {
        if (_image1== null) {
          Fluttertoast.showToast(
              msg: "image must be Provided",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else{
          showLoadingIndicator(context, "adding food item....");
          String fileName = p.basename(_image1.path);
          StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
          StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image1);
          StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
          imageUrl = await taskSnapshot.ref.getDownloadURL();
          //i want to add new item
          final Food food = Food(
              name: title,
              category: category,
              description: description,
              price: double.parse(price),
              discounts: double.parse(discount),
              imageUrl: imageUrl.toString());
          bool value = await addFood(food);
          if (value) {
            Navigator.of(context).pop();
            Navigator.of(context).pop(value);
          } else if (!value) {
            Navigator.of(context).pop();
            SnackBar snackBar =
            SnackBar(content: Text("Failed to add food item"));
            _scaffoldStateKey.currentState.showSnackBar(snackBar);
          }
        }
      }
    }
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      initialValue: widget.food != null && hint == "Food Title"
          ? widget.food.name
          : widget.food != null && hint == "Category"
              ? widget.food.category
              : widget.food != null && hint == "Description"
                  ? widget.food.description
                  : widget.food != null && hint == "Price"
                      ? widget.food.price.toString()
                      : widget.food != null && hint == "Discount"
                          ? widget.food.discounts.toString()
                          : "",
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty && hint == "Food Title") {
          return "The Food Title is required ";
        }
        if (value.isEmpty && hint == "Category") {
          return "The Category is required ";
        }
        if (value.isEmpty && hint == "Description") {
          return "The Description is required ";
        }
        if (value.isEmpty && hint == "Price") {
          return "The Price is required ";
        }
      },
      onSaved: (value) {
        if (hint == "Food Title") {
          title = value;
        }
        if (hint == "Category") {
          category = value;
        }
        if (hint == "Food Title") {
          title = value;
        }
        if (hint == "Description") {
          description = value;
        }
        if (hint == "Price") {
          price = value;
        }
        if (hint == "Discount") {
          discount = value;
        }
      },
    );
  }

  void _selectImage( {Future<File> pickImage,String imageUrl }) async {
    File tempImage = await pickImage;
    setState(() {
      _image1 = tempImage;
    });
  }

  Widget displayChild1() {
    if (widget.food!=null&&_image1 == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 4.0),
        child: Container(
          height: 200,
          width: 120.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  widget.food.imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius:
            BorderRadius.circular(5.0),
          ),
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.add,
                size: 45,
                color: Colors.black.withOpacity(.8),
              )),
        ),
      );
    }
    else if (widget.food==null&&_image1 == null) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 50.0, 14.0, 50.0),
          child: Icon(
            Icons.add,
            color: Colors.grey,
          ));
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }
}






