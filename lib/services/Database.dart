import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/model/FoodMenu.dart';
import 'package:final_year_project/model/FoodMenuDetail.dart';
import 'package:final_year_project/model/LoyaltyRewards.dart';
import 'package:final_year_project/model/Table.dart';
import 'package:final_year_project/model/availableTime.dart';
import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/model/newUserVoucher.dart';
import 'package:final_year_project/model/order.dart';
import 'package:final_year_project/model/voucher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  String _currentUserId;

  final FirebaseFirestore _cloud = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Target: Member
  //========================Member Authenticate and Profile========================================//

  Future<void> createMember(String email, String username, String uid) async {
    Map<String, dynamic> data =
        Member(username: username, email: email, userId: uid, admin: false)
            .toJson();
    await _cloud.collection('Member').doc(uid).set(data);

    QuerySnapshot vouchers = await _cloud.collection('New User Voucher').get();
    vouchers.docs.forEach((item) {
      Map<String, dynamic> voucherDetail = item.data();
      _cloud.collection('Member').doc(uid).collection('Voucher').doc(voucherDetail['voucherName']).set(voucherDetail);
    });
  }

  //get user id
  String _getUserId() {
    return _auth.currentUser != null ? _auth.currentUser.uid : null;
  }

  //get userId from _auth and store it somewhere;
  void _getId() {
    _currentUserId = _getUserId();
  }

  Member curUser;

  Future<Member> getCurrentUserInfo() async {
    _getId();
    try {
      if (_currentUserId != null) {
        CollectionReference _collection = _cloud.collection('Member');
        DocumentSnapshot snapshot = await _collection.doc(_currentUserId).get();
        if (snapshot.exists) {
          curUser = Member.fromJson(snapshot.data());
          notifyListeners();
          return Member.fromJson(snapshot.data());
        }
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //to use stream to listen changes of admin
  Stream getUserInfo() {
    _getId();
    return _cloud.collection('Member').doc(_currentUserId).snapshots();
  }

  //Update properties in database
  void updateMemberPropertiesinDatabase(String property, String value) async {
    _getId();
    Map<String, Object> data = {property: value};
    try {
      if (_currentUserId != null) {
        CollectionReference _collection = _cloud.collection('Member');
        await _collection.doc(_currentUserId).update(data);
      }
    } on FirebaseException catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //Target: MenuCategory
  //-------------------FoodMenu Query --------------------------
  //a firebase query to get the data and return FoodMenu(body['id'], body['category'], body['foodList']

  Future<void> addMenuCategory(
      String category, String title, String description, String image) async {
    Map<String, dynamic> data = FoodMenu(
            category: category,
            title: title,
            description: description,
            picture: image)
        .toJson();
    try {
      await _cloud.collection('Menu').doc(category).set(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> getMenuCategory() async {
    try {
      final _collection = _cloud.collection('Menu');
      //result is snapshot, to get the document data, using
      //result.then((value) => value.docs)
      QuerySnapshot snapshot = await _collection.get();

      return snapshot.docs;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Object> getOneMenuCategory(String category) async {
    try {
      DocumentSnapshot result =
          await _cloud.collection('Menu').doc(category).get();

      //result is snapshot, to get the document data, using
      //result.then((value) => value.docs)
      return result.data();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> deleteMenuCategory(String category) async {
    try {
      String _downloadedPictureUrl;
      DocumentReference deleteTarget = _cloud.collection('Menu').doc(category);
      await deleteTarget
          .get()
          .then((document) => _downloadedPictureUrl = document["picture"]);
      if (_downloadedPictureUrl != null) {
        await _storage.refFromURL(_downloadedPictureUrl).delete();
      }
      await deleteTarget.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //Target: FoodDetail
  //========================Get Food Menu Detail========================================//

  Future<void> addFoodDetail(String category, String name, String description,
      String price, String picture) async {
    Map<String, dynamic> data = {
      'foodList': FoodMenuDetail(
              name: name,
              description: description,
              price: price,
              category: category,
              picture: picture)
          .toJson(),
    };
    await _cloud
        .collection('Menu')
        .doc(category)
        .collection(category)
        .doc(name)
        .set(data);
  }

  Future<List> getFoodDetails(String category) async {
    try {
      QuerySnapshot result = await _cloud
          .collection('Menu')
          .doc(category)
          .collection(category)
          .get();
      return result.docs;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Object> getOneFoodMenu(String category, String name) async {
    try {
      DocumentSnapshot result = await _cloud
          .collection('Menu')
          .doc(category)
          .collection(category)
          .doc(name)
          .get();

      //result is snapshot, to get the document data, using
      //result.then((value) => value.docs)
      return result.data();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> deleteFoodMenu(String category, String name) async {
    try {
      String _downloadedPictureUrl;
      DocumentReference deleteTarget = _cloud
          .collection('Menu')
          .doc(category)
          .collection(category)
          .doc(name);
      await deleteTarget.get().then((document) =>
          _downloadedPictureUrl = document['foodList']["picture"]);
      if (_downloadedPictureUrl != null) {
        await _storage.refFromURL(_downloadedPictureUrl).delete();
      }
      await deleteTarget.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //Target: LoyaltyProgram
  //========================LOYALTY PROGRAM BUSINESS LOGIC========================================//

  //Add Loyalty Program Promotion
  Future<bool> loyaltyVoucherForNewUser(String title, String description,
      DateTime expiredDate, double discountPercentage) async {
    try {
      for (int i = 0; i < 2; i++) {
        await _cloud.collection('New User Voucher').doc('Discount Voucher$i').set({
          'title': title,
          'description': description,
          'expiredDate': expiredDate,
          'discountPercentage': discountPercentage,
          'voucherName': 'Discount Voucher$i',
        });
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //Add Loyalty Program Promotion
  void addLoyaltyProgramPromotion(String title, String description,
      DateTime expiredDate, double discountPercentage, double loyaltyPoint) {
    Map<String, dynamic> data = LoyaltyRewards(
            title, description, expiredDate, discountPercentage, loyaltyPoint)
        .toJson();
    try {
      _cloud.collection('Loyalty').doc(title).set(data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Edit Loyalty Program Promotion
  void editLoyaltyProgramPromotion(
      String title,
      String description,
      DateTime expiredDate,
      double discountPercentage,
      double loyaltyPoint) async {
    Map<String, dynamic> data = LoyaltyRewards(
            title, description, expiredDate, discountPercentage, loyaltyPoint)
        .toJson();

    try {
      await _cloud.collection('Loyalty').doc(title).update(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Stream getLoyaltyProgramPromotion() {
    try {
      var result = _cloud.collection('Loyalty').where('expiredDate', isGreaterThanOrEqualTo: DateTime.now()).snapshots();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream getUserLoyaltyPoint() {
    try {
      final result = _cloud
          .collection('Member')
          .where('userId', isEqualTo: _auth.currentUser.uid)
          .snapshots();
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  ///When getting loyalty program promotion item:
  /// Please implement the check condition of time
  /// If (result.data.expiredDate < DateTime.currentDate.now()) skip;
  /// or 倒翻
  ///
  /// Another check condition:
  /// If the user redeemed the voucher: check if the voucher is already expired or not
  /// if it is expired, notify the user error or directly not show the voucher to the user.

  Future<Object> getOneLoyaltyProgramPromotion(String title) async {
    try {
      DocumentSnapshot result =
          await _cloud.collection('Loyalty').doc(title).get();
      return result.data();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Object> getNewUserVoucher(String title) async {
    try {
      DocumentSnapshot result =
      await _cloud.collection('New User Voucher').doc(title).get();
      return result.data();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> deleteLoyaltyProgramPromotion(String title) async {
    try {
      DocumentReference deleteTarget = _cloud.collection('Loyalty').doc(title);
      await deleteTarget.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //Target: User Redemption
  //==============================Loyalty Promotion Redemption=======================

  // User Redeem the voucher
  Future<bool> redemptionVoucher(String title) async {
    //check if the user has enough loyalty Point
    //get the promotion detail
    try {
      bool hasRedeemed = false;
      final result = await getOneLoyaltyProgramPromotion(title);
      Map<String, dynamic> data = result;
      Member userInfo = await getCurrentUserInfo();
      final redeemedVoucher = await getVoucher();
      redeemedVoucher.forEach((doc) {
        if (doc['voucherName'] == title) {
          hasRedeemed = true;
          return;
        }
      });
      if (double.parse(userInfo.loyaltyPoint) >= data['loyaltyPoint'] &&
          !hasRedeemed) {
        var newLoyaltyPoint;
        Map<String, dynamic> voucher = Voucher(data['title']).toJson();
        await _cloud
            .collection('Member')
            .doc(_auth.currentUser.uid)
            .collection('Voucher')
            .doc(title)
            .set(voucher);
        newLoyaltyPoint =
            double.parse(userInfo.loyaltyPoint) - data['loyaltyPoint'];
        updateMemberPropertiesinDatabase(
            'loyaltyPoint', newLoyaltyPoint.toString());
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Stream getRedeemedVoucher() {
    _getId();
    try {
      if (_currentUserId != null) {
        CollectionReference _collection = _cloud.collection('Member');
        final snapshot =
            _collection.doc(_currentUserId).collection('Voucher').snapshots();
        return snapshot;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getVoucher() async {
    _getId();
    try {
      if (_currentUserId != null) {
        CollectionReference _collection = _cloud.collection('Member');
        final snapshot =
            await _collection.doc(_currentUserId).collection('Voucher').get();
        return snapshot.docs;
      }
    } catch (e) {}
  }

  Future<bool> useVoucher(String title) async {
    final userRedeemedVoucher = await getVoucher();
    userRedeemedVoucher.forEach((item) {
      if (item['voucherName'].contains(title)) {
        try {
          _cloud
              .collection('Member')
              .doc(_currentUserId)
              .collection('Voucher')
              .doc(title)
              .delete();
          return true;
        } catch (e) {
          return false;
        }
      }
    });
    return false;
  }

//Target: Table Reservation
//==============================Table Reservation============================

  final availableTime = [09, 11, 13, 15, 17, 19];

  void sevenDaysTableCreate(int index) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    int different = 0;

    if (_cloud.collection('TableDate') != null) {
      try {
        Query data = _cloud
            .collection('TableDate')
            .orderBy("docId", descending: true)
            .limit(1);
        QuerySnapshot data1 = await data.get();
        DateTime lastDate = DateTime.parse(data1.docs[0]['docId']);
        Duration dateDifferent = lastDate.difference(today);
        different = dateDifferent.inDays;
      } catch (e) {
        print(e.toString());
      }
    }

    for (int i = 0 + different; i < 7; i++) {
      _createTableAvailableTime(
          index,
          DateTime(now.year, now.month, now.day)
              .toLocal()
              .add(Duration(days: i)));
    }
  }

  //init createTableAvailableTime
  void _createTableAvailableTime(int index, DateTime date) async {
    //index = table number
    //date will be the selected date
    for (int i = 1; i <= index; i++) {
      //each table for loop
      DocumentReference dateReference =
          _cloud.collection('TableDate').doc(date.toString());
      await dateReference.set({
        "docId": dateReference.id,
      });

      DocumentReference tableReference =
          dateReference.collection('Table').doc('Table ${i < 10 ? "0$i" : i}');
      await tableReference.set({
        'table': TableSet(id: tableReference.id).toJson(),
      });

      CollectionReference timeReference =
          tableReference.collection('AvailableTime');

      for (int j = 0; j < availableTime.length; j++) {
        //each table available time list for loop
        Map<String, dynamic> data = AvailableTime(
                DateTime(date.year, date.month, date.day, availableTime[j])
                    .add(Duration(hours: -8)))
            .toJson();
        timeReference
            .doc(availableTime[j] == 09
                ? "0${availableTime[j].toString()}"
                : availableTime[j].toString())
            .set(data);
      }
    }
  }

  Future getTableAmount(DateTime date) async {
    QuerySnapshot result = await _cloud
        .collection('TableDate')
        .doc(date.toString())
        .collection('Table')
        .get();
    return result.docs;
  }

  //get booking status from firestore cloud
  Future getTableBookingStatus(
      DateTime date, int availableTime, tableId) async {
    final result = await _cloud
        .collection('TableDate')
        .doc(date.toString())
        .collection('Table')
        .doc(tableId)
        .collection('AvailableTime')
        .doc(availableTime == 9 ? '09' : availableTime.toString())
        .get();
    return result;
  }

  //delete Reservation booking (Cancel)
  Future<bool> deleteBooking(String customerId, String tableId, DateTime date,
      int bookingTime, bool isBooked) async {
    try {
      final data = _cloud
          .collection('Order Detail')
          .doc(customerId)
          .collection('Booking')
          .doc(
              '$tableId ${DateTime(date.year, date.month, date.day, bookingTime).toString()}')
          .get();
      if (data != null) {
        await _cloud
            .collection('Order Detail')
            .doc(customerId)
            .collection('Booking')
            .doc(
                '$tableId ${DateTime(date.year, date.month, date.day, bookingTime).toString()}')
            .delete();
        await _cloud
            .collection('Reservation Detail')
            .doc(
                '$tableId ${DateTime(date.year, date.month, date.day, bookingTime).toString()}')
            .delete();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  //Method to change reservation information
  void unCheckedBookingStatus(DateTime date, String tableId, int bookingTime) {
    _cloud
        .collection('TableDate')
        .doc(DateTime(date.year, date.month, date.day).toString())
        .collection('Table')
        .doc(tableId)
        .collection('AvailableTime')
        .doc(bookingTime == 9 ? '0$bookingTime' : bookingTime.toString())
        .update({
      'isBooked': false,
      'customerId': null,
      'name': null,
    });
  }

  // Edit booking status
  void setBookingStatus(DateTime date, String tableId, int bookingTime,
      bool isBooked, String customerId, String customerName) {
    Map<String, dynamic> data = {
      'isBooked': isBooked,
      'customerId': customerId,
      'name': customerName,
    };
    try {
      _cloud
          .collection('TableDate')
          .doc(DateTime(date.year, date.month, date.day).toString())
          .collection('Table')
          .doc(tableId)
          .collection('AvailableTime')
          .doc(bookingTime == 9 ? '0$bookingTime' : bookingTime.toString())
          .update(data);
    } catch (e) {
      print(e.toString());
    }
  }

  //Add orderDetail
  Future<bool> addOrderDetail(
      DateTime date,
      String tableId,
      int bookingTime,
      bool isBooked,
      String customerId,
      String customerName,
      List selectedItem,
      double totalPrice,
      String comment) async {
    //change TableStatus (get customerName)
    try {
      //date is the booking date, take the year/month/day is enough
      //use bookingTime to identify the reservation time

      Map<String, dynamic> data = Order(bookingTime, date, tableId, isBooked,
              customerId, selectedItem, totalPrice, comment, customerName)
          .toJson();

      _cloud
          .collection('Order Detail')
          .doc(customerId)
          .collection('Booking')
          .doc(
              '$tableId ${DateTime(date.year, date.month, date.day, bookingTime).toString()}')
          .set(data);
      setBookingStatus(date, tableId, bookingTime, isBooked, customerId,
          _auth.currentUser.displayName);
      _cloud
          .collection('Reservation Detail')
          .doc(
              '$tableId ${DateTime(date.year, date.month, date.day, bookingTime).toString()}')
          .set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future getCurrentOrderDetail(String customerId) async {
    try {
      QuerySnapshot result = await _cloud
          .collection('Order Detail')
          .doc(customerId)
          .collection('Booking')
          .where('bookingDate', isGreaterThanOrEqualTo: new DateTime.now())
          .get();
      return result.docs;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getPastOrderDetail(String customerId) async {
    try {
      QuerySnapshot result = await _cloud
          .collection('Order Detail')
          .doc(customerId)
          .collection('Booking')
          .where('bookingDate', isLessThanOrEqualTo: new DateTime.now())
          .get();
      return result.docs;
    } catch (e) {
      print(e.toString());
    }
  }

  Future getReservationDetailForAdmin() async {
    try {
      QuerySnapshot result = await _cloud
          .collection('Reservation Detail')
          .where('bookingDate', isGreaterThanOrEqualTo: new DateTime.now())
          .get();
      return result.docs;
    } catch (e) {
      print(e.toString());
    }
  }
}
