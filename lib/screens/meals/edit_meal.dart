import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/models/ingredients_model.dart';
import 'package:pantry/models/meals_model.dart';
import 'package:pantry/models/meals_storage.dart';
import 'package:pantry/screens/ingredients/ingredient_list_selection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class EditMeal extends StatefulWidget {
  final Meal meal;
  const EditMeal({required this.meal});

  @override
  State<EditMeal> createState() => _EditMealState();
}

class _EditMealState extends State<EditMeal> {

  final ImagePicker _picker = ImagePicker();
  File? _mealImage;
  final TextEditingController _mealNameC = TextEditingController();
  final TextEditingController _htcC = TextEditingController();
  final TextEditingController _ttcC =  TextEditingController();
  List<TextEditingController> quantityControllers = [];
  List<MealIngredient> selectedIngredientList = [];
  
  @override
  void initState() {
    super.initState();
    
    _mealNameC.text = widget.meal.mealName;
    _htcC.text = widget.meal.howToCook!;
    _ttcC.text = widget.meal.timeToCook!;
    if (widget.meal.image != null) {
      _mealImage = File(widget.meal.image!);
    }
    selectedIngredientList = List.from(widget.meal.mealIngredients);
    for (var mealIngredient in selectedIngredientList) {
      quantityControllers.add(TextEditingController(text: mealIngredient.quantity.toString()));
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  Future<void> _getImageFromCamera() async {
    if (await _requestPermission(Permission.camera)) {
      try {
        final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          setState(() {
            _mealImage = File(pickedFile.path);
          });
        } else {
          Get.snackbar('No Image Selected', 'Please select an Image');
        }
      } catch (e) {
        Get.snackbar('Error picking Image', '$e');
      }
    } else {
      Get.snackbar('Permission Denied', 'Camera Permission is required');
    }
  }

  Future<void> _getImageFromGallery() async {
    if (await _requestPermission(Permission.storage)) {
      try {
        final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          print('Image Path: ${pickedFile.path}');
          setState(() {
            _mealImage = File(pickedFile.path);
          });
          if (_mealImage != null) {
            print('Can read file: ${await _mealImage!.exists()}');
            print('File Object: $_mealImage');
          }
        } else {
          Get.snackbar('No Image Selected', 'Please select an Image');
        }
      } catch (e) {
        Get.snackbar('Error picking Image', '$e');
      }
    } else {
      Get.snackbar('Permission Denied', 'Storage Permission is required');
    }
  }

  void _removeSelectedIngredient(int index) {
    setState(() {
      selectedIngredientList.removeAt(index);
      quantityControllers.removeAt(index);
    });
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      double quantity = double.parse(quantityControllers[index].text) ?? 1;
      quantity += delta;
      if (quantity < 1) quantity = 1;
      quantityControllers[index].text = quantity.toString();
      selectedIngredientList[index].quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mealStorage = Provider.of<MealsStorage>(context, listen: false);
    final meal = mealStorage.getMealById(widget.meal.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
          ),
          iconSize: 24,
          color: AppColors.deepGreen,
        ),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 90,
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Meal',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 48,
              ),
              TextField(
                controller: _mealNameC,
                decoration: InputDecoration(
                  label: Text(
                    'Meal Name',
                    style: TextStyle(
                      color: AppColors.deepGreen,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.deepGreen,
                      )
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _mealNameC.clear();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.deepGreen,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              _mealImage != null
                  ? Slidable(
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          _mealImage = null;
                        });
                      },
                      backgroundColor: AppColors.deepRed,
                      foregroundColor: AppColors.lightRed,
                      icon: Icons.delete_outline_rounded,
                    ),
                  ],
                  extentRatio: 0.25,
                ),
                child: Image.file(
                  _mealImage!,
                  height: 100,
                  width: 320,
                  fit: BoxFit.cover,
                ),
              )
                  : Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _getImageFromCamera();
                    },
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.deepGreen,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 48,
                        color: AppColors.deepGreen,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _getImageFromGallery();
                    },
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.deepGreen,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 48,
                        color: AppColors.deepGreen,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingredients',
                            style: TextStyle(
                              color: AppColors.faintGrey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Quantity required for One (1) Serving',
                            style: TextStyle(
                              color: AppColors.faintGrey,
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(
                                () => IngredientListSelection(
                                onIngredientSelected: (selectedIngredient) {
                                  setState(() {
                                    selectedIngredientList.add(MealIngredient(ingredient: selectedIngredient, quantity: 1));
                                    quantityControllers
                                        .add(TextEditingController(text: '1'));
                                  });
                                  Get.back();
                                }),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          size: 24,
                          color: AppColors.deepGreen,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    itemCount: selectedIngredientList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final _mealIngredient = selectedIngredientList[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 320,
                        decoration: BoxDecoration(
                          color: AppColors.deepGray,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_mealIngredient.ingredient.ingredientName),
                            SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _updateQuantity(index, -1);
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline_outlined,
                                      size: 24,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 15,
                                    child: TextField(
                                      controller: quantityControllers[index],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _updateQuantity(index, 1);
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline_outlined,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              _mealIngredient.ingredient.unitOfMeasurement,
                            ),
                            IconButton(
                              onPressed: () {
                                _removeSelectedIngredient(index);
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: AppColors.lightRed,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 100,
                child: TextField(
                  controller: _htcC,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    label: Text(
                      'How to cook',
                      style: TextStyle(
                        color: AppColors.deepGreen,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.deepGreen,
                        )
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _htcC.clear();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.deepGreen,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How Long does it take to cook?',
                    style: TextStyle(
                      color: AppColors.faintGrey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: 150,
                    child: TextField(
                      controller: _ttcC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          'Time in Minutes',
                          style: TextStyle(
                            color: AppColors.deepGreen,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.deepGreen,
                            )
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _ttcC.clear();
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.deepGreen,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  if (_mealNameC.text.isEmpty) {
                    Get.snackbar(
                      "Invalid Input",
                      "Please fill in all the required fields.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  final updatedMeal = Meal(
                    id: meal.id,
                    mealName: _mealNameC.text,
                    mealIngredients: selectedIngredientList,
                    image: _mealImage?.path,
                    howToCook: _htcC.text,
                    timeToCook: _ttcC.text,
                  );
                  mealStorage.updateMeal(updatedMeal);

                  _mealNameC.clear();
                  _htcC.clear();
                  _ttcC.clear();

                  Get.back();
                },
                child: Text(
                  'Edit Meal',
                  style: TextStyle(
                    color: AppColors.baseWhite,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                  fixedSize: WidgetStatePropertyAll(
                    Size(320, 40),
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
