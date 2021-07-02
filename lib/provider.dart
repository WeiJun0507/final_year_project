import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';

class AddPreOrderMenu extends ChangeNotifier {
  List selectedMenu = [];
  double totalAmount = 0;
  double amountAfterDiscount = 0;
  final _dbService = DatabaseService();

  void addItem(String name, String price) {
    this.selectedMenu.add({'name': name,'price': price});
    totalAmount += double.parse(price);
    amountAfterDiscount += double.parse(price);

    notifyListeners();
  }

  void removeItem(String name, String price) {
    for(int i = 0; i < this.selectedMenu.length; i++) {
      if (selectedMenu[i]['name'] == name) {
        selectedMenu.removeAt(i);
        break;
      }
    }
    if (totalAmount > 0) {
      totalAmount -= double.parse(price);
      amountAfterDiscount -= double.parse(price);
    }

    notifyListeners();
  }

  void useVoucher(String title) async {
    if (title == 'Select Voucher') {
      amountAfterDiscount = totalAmount;
    } else if (title == 'Discount Voucher0' || title == 'Discount Voucher1') {
      Map<String, dynamic> voucherPicked = await _dbService.getNewUserVoucher(title);
      double discountPercentage = voucherPicked['discountPercentage'];
      amountAfterDiscount = totalAmount * (100 - discountPercentage) / 100;
    }  else {
      Map<String,dynamic> voucherPicked = await _dbService.getOneLoyaltyProgramPromotion(title);
      double discountPercentage = voucherPicked['discountPercentage'];
      amountAfterDiscount = totalAmount * (100 - discountPercentage) / 100;
    }

    notifyListeners();
  }

  void onSubmit() {
    amountAfterDiscount = 0.0;
    totalAmount = 0.0;
    selectedMenu = [];
  }

  void clearItem() {
    selectedMenu = [];
    totalAmount = 0.0;

    notifyListeners();
  }
}

class ReservationInformation extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  String selectedTable = 'Table 01';
  int selectedTime = 9;
  bool isBooked = false;
  String customerId = '';

  void saveReservationInformation(DateTime currentDate, String selectedTable, int selectedTime, bool isBooked, String customerId) {
    this.currentDate = currentDate;
    this.selectedTable = selectedTable;
    this.selectedTime = selectedTime;
    this.isBooked = isBooked;
    this.customerId = customerId;

    notifyListeners();
  }
}