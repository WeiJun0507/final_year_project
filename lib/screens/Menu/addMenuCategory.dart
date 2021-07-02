import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:final_year_project/services/Database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _storage = FirebaseStorage.instance;
  final _dbService = DatabaseService();

  final _formKey = GlobalKey<FormState>();
  String _category;
  String _title;
  String _description;
  String _downloadedPictureUrl;
  final picker = ImagePicker();

  File _imageFile;

  void _submitForm() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      try {
        if (_imageFile != null) {
          _downloadedPictureUrl = await uploadImageToFirebase();
          if( _downloadedPictureUrl != null) {
            _dbService.addMenuCategory(
                _category, _title, _description, _downloadedPictureUrl);
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
    if (_imageFile != null) {
      Reference firebaseStorageRef = _storage.ref().child('menu_category/${path.basename(_imageFile.path)}');
      TaskSnapshot result = await firebaseStorageRef.putFile(_imageFile);
      var downloadUrl = await result.ref.getDownloadURL();
      return downloadUrl;
    } else {
      print('no file is received');
      return null;
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
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                  child: Text(
                    'Add Category',
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
                height: MediaQuery.of(context).size.height * 0.51,
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
                                hintText: 'New Category',
                                hintStyle: TextStyle(
                                    color: Colors.black45, fontSize: 20),
                                prefixIcon: Icon(Icons.category),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _category = value;
                                _title = value;
                              },
                              onSaved: (value) {
                                _category = value;
                                _title = value;
                              },
                              validator: (value) => value.isEmpty
                                  ? 'New menu category cannot be empty'
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
                          SizedBox(height: 10.0),
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
  }
}
