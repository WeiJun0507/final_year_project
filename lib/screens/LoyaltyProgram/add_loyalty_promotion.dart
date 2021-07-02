import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';

class AddLoyaltyPromotion extends StatefulWidget {
  const AddLoyaltyPromotion({Key key}) : super(key: key);

  @override
  _AddLoyaltyPromotionState createState() => _AddLoyaltyPromotionState();
}

class _AddLoyaltyPromotionState extends State<AddLoyaltyPromotion> {
  DateTime _currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  double _discountValue = 5.0;
  String _title;
  String _description;
  String _loyaltyPoint;

  final DatabaseService _dbService = DatabaseService();

  List<double> discountValueList = [
    5.0,
    10.0,
    15.0,
    20.0,
    25.0,
    30.0,
    35.0,
    40.0,
    45.0,
    50.0,
    55.0,
    60.0,
    65.0,
    70.0,
    75.0,
    80.0,
    85.0,
    90.0,
    95.0,
    100.0
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != _currentDate)
      setState(() {
        _currentDate = pickedDate;
      });
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      try {
        _dbService.addLoyaltyProgramPromotion(_title, _description, _currentDate, _discountValue, double.parse(_loyaltyPoint));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Added Successfully.',
            style: TextStyle(color: Colors.black),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.greenAccent[100],
        ));
        Navigator.pop(context);
      } catch (e) {
        print(e.toString());
      }
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
              color: Colors.redAccent[400],
              size: 16.0,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Add new promotion item',
          style: TextStyle(
            color: Colors.redAccent[400],
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    elevation: 6.0,
                    child: Row(children: [
                      Expanded(
                        child: Center(
                            child: Text(
                          "TITLE:",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        )),
                        flex: 2,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter the promotion title',
                              hintStyle: TextStyle(
                                fontSize: 18.0,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              labelStyle: TextStyle(
                                fontSize: 18.0,
                              )),
                          validator: (value) => value.isEmpty ? 'Title Cannot be empty' : null,
                          onChanged: (value) {
                            _title = value;
                          },
                          onSaved: (value) {
                            _title = value;
                          },
                        ),
                        flex: 6,
                      )
                    ]),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    elevation: 6.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText:
                                      'Enter the promotion description...',
                                  hintStyle: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  labelStyle: TextStyle(
                                    fontSize: 18.0,
                                  )),
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              validator: (value) => value.isEmpty ? 'Description Cannot be empty' : null,
                              onChanged: (value) {
                                _description = value;
                              },
                              onSaved: (value) {
                                _description = value;
                              },
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Card(
                      elevation: 6.0,
                      child: Row(children: [
                        Expanded(
                          child: Center(
                              child: Text(
                            "Expired Date:",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          )),
                          flex: 3,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Text(
                              '${_currentDate.year}-${_currentDate.month}.${_currentDate.day}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  letterSpacing: 2),
                            ),
                          ),
                          flex: 4,
                        )
                      ]),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    elevation: 6.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discount Percentage:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            DropdownButtonFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _discountValue = value;
                                  });
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _discountValue = value;
                                  });
                                },
                                value: _discountValue,
                                items: discountValueList.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      value.toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    value: value,
                                  );
                                }).toList()),
                          ]),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    elevation: 6.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loyalty Point Required:",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Enter the point',
                                  hintStyle: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  labelStyle: TextStyle(
                                    fontSize: 18.0,
                                  )),
                              keyboardType: TextInputType.number,
                              validator: (value) => value.isEmpty ? 'Point\'s required cannot be empty' : null,
                              onChanged: (value) {
                                _loyaltyPoint = value;
                              },
                              onSaved: (value) {
                                _loyaltyPoint = value;
                              },
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)))),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
