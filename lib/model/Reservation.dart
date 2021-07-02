import 'package:final_year_project/model/availableTime.dart';

class Reservation {
  String capacity;
  AvailableTime availableTime;
  bool booked;
  String customerId;

  Reservation(
      {this.capacity,
      this.availableTime,
      this.booked,
      this.customerId});


}

