import 'dart:io';

import 'package:final_year_project/services/Database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditFoodMenu extends StatefulWidget {
  final String name;
  final String category;
  const EditFoodMenu({Key key, this.name,this.category}) : super(key: key);

  @override
  _EditFoodMenuState createState() => _EditFoodMenuState();
}

class _EditFoodMenuState extends State<EditFoodMenu> {
  final _storage = FirebaseStorage.instance;
  final _dbService = DatabaseService();

  TextEditingController _foodName;
  TextEditingController _foodDescription;
  TextEditingController _foodPrice;

  final _formKey = GlobalKey<FormState>();
  String _category;
  String _name;
  String _description;
  String _downloadedPictureUrl;
  String _oldName;
  String _price;
  final picker = ImagePicker();

  File _imageFile;

  @override
  void initState() {
    getCategoryDetail(widget.name);
    super.initState();
  }


  @override
  void dispose() {
    _foodName.dispose();
    _foodDescription.dispose();
    _foodPrice.dispose();
    super.dispose();
  }

  void getCategoryDetail(String name) async {
    try {
      Map<String, dynamic> food = await _dbService.getOneFoodMenu(widget.category,widget.name);

      if (food != null) {
        setState(() {
          //textController initialization
          _foodName = new TextEditingController(text: food['foodList']['name']);
          _foodDescription = new TextEditingController(text: food['foodList']['description']);
          _foodPrice = new TextEditingController(text: food['foodList']['price']);

          //state initialization
          _category = food['foodList']['category'];
          _oldName = food['foodList']['name'];
          _name = food['foodList']['name'];
          _price = food['foodList']['price'];
          _description = food['foodList']['description'];
          _imageFile = File(food['foodList']['picture']);
        });
      }

    } catch(e) {
      print(e);
    }
  }

  void _submitForm() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      try {
        if (_imageFile != null) {
          uploadImageToFirebase().then((_) async {
            bool delSuccess = await _dbService.deleteFoodMenu(_oldName, _category);

            if (delSuccess) {
              _dbService.addFoodDetail(
                  _category, _name, _description, _downloadedPictureUrl, _price);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Updated Successfully',
                  style: TextStyle(color: Colors.black),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.greenAccent[100],
              ));
              Navigator.pop(context);
            }

          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  _selectImage() async {
    //check permission first
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {

        //dart.io File, not dart.html
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('Photos permission is denied.');
    }
  }

  Future uploadImageToFirebase() async {
    //Todo: Solve update without choosing image error
    if (_imageFile != null) {
      Reference firebaseStorageRef = _storage.ref().child('menu_category');
      TaskSnapshot result = await firebaseStorageRef.putFile(_imageFile);
      _downloadedPictureUrl = await result.ref.getDownloadURL();
    } else {
      print('no file is received');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.green,
              size: 16.0,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                  child: Text(
                    'Edit Category',
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.greenAccent[700],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.58,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Card(
                    elevation: 6.0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 10.0),
                            TextFormField(
                                controller: _foodName,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  hintText:  'Name',
                                  hintStyle: TextStyle(
                                      color: Colors.black45, fontSize: 20),
                                  prefixIcon: Icon(Icons.category),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  _name = value;
                                },
                                onSaved: (value) {
                                  _name = value;
                                },
                                validator: (value) => value.isEmpty
                                    ? 'Food Name cannot be empty'
                                    : null),
                            SizedBox(height: 20.0),
                            TextFormField(
                                controller: _foodDescription,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  hintText: 'Description',
                                  hintStyle: TextStyle(
                                      color: Colors.black45, fontSize: 20),
                                  prefixIcon: Icon(Icons.description_outlined),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  _description = value;
                                },
                                onSaved: (value) {
                                  _description = value;
                                },
                                validator: (value) => value.isEmpty
                                    ? 'Description cannot be empty'
                                    : null),
                            SizedBox(height: 20.0),
                            TextFormField(
                                controller: _foodPrice,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  hintText: 'Price',
                                  hintStyle: TextStyle(
                                      color: Colors.black45, fontSize: 20),
                                  prefixIcon: Icon(Icons.money_outlined),
                                  border: InputBorder.none,
                                  prefixText: '\$',
                                ),
                                onChanged: (value) {
                                  _price = value;
                                },
                                onSaved: (value) {
                                  _price = value;
                                },
                                validator: (value) => value.isEmpty
                                    ? 'Price cannot be empty'
                                    : null),
                            SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Select Image:',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      )),
                                  ElevatedButton(
                                      onPressed: () {
                                        _selectImage();
                                      },
                                      child: Text('Choose Image'))
                                ],
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.greenAccent[400]),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
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
