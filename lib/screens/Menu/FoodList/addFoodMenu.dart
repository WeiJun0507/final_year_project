import 'dart:io';

import 'package:final_year_project/services/Database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddFoodMenu extends StatefulWidget {
  final category;

  const AddFoodMenu({Key key, this.category}) : super(key: key);

  @override
  _AddFoodMenuState createState() => _AddFoodMenuState();
}

class _AddFoodMenuState extends State<AddFoodMenu> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  final _storage = FirebaseStorage.instance;
  final _dbService = DatabaseService();

  String _name;
  String _description;
  String _price;
  String _downloadedPictureUrl;

  File _imageFile;

  void _submitForm() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      try {
        if (_imageFile != null) {
          _downloadedPictureUrl = await uploadImageToFirebase();
          if (_downloadedPictureUrl != null) {
            _dbService.addFoodDetail(widget.category, _name, _description,
                _price, _downloadedPictureUrl);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Added Successfully',
                style: TextStyle(color: Colors.black),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.greenAccent[100],
            ));
            Navigator.pop(context);
          }
        }
      } catch (e) {
        print(e.toString());
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
    if (_imageFile != null) {
      Reference firebaseStorageRef =
          _storage.ref().child('menu_category/${_imageFile.path}');
      TaskSnapshot result = await firebaseStorageRef.putFile(_imageFile);
      var path = await result.ref.getDownloadURL();
      return path;
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
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                  child: Text(
                    'Add Food Menu',
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
                height: MediaQuery.of(context).size.height * 0.62,
                child: Card(
                  elevation: 6.0,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10.0),
                          TextFormField(
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 16.0,
                                ),
                                hintText: 'Food Name',
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
                                  ? 'Menu name cannot be empty'
                                  : null),
                          SizedBox(height: 20.0),
                          TextFormField(
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 16.0,
                                ),
                                hintText: 'Description for new category',
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
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 16.0,
                              ),
                              hintText: 'Price',
                              hintStyle: TextStyle(
                                  color: Colors.black45, fontSize: 20),
                              prefixIcon: Icon(Icons.money_outlined),
                              border: InputBorder.none,
                              prefix: Text('\$'),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                value.isEmpty ? 'Price cannot be empty' : null,
                            onChanged: (value) => _price = value,
                            onSaved: (value) => _price = value,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
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
                          SizedBox(height: 20.0),
                        ],
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
    ;
  }
}
