class AvailableTime {
  DateTime startTime;
  DateTime endTime;
  bool isBooked;
  String customerId;

  AvailableTime(this.startTime): this.endTime = startTime.add(const Duration(hours: 2)), isBooked = false;

  Map<String, dynamic> toJson() => {
    'startTime': startTime,
    'endTime': endTime,
    'isBooked': isBooked,
    'customerId': customerId,
  };

  AvailableTime.fromJson(Map<String, dynamic> json) :
    startTime = json['startTime'],
    endTime = json['endTime'],
    isBooked = json['isBooked'],
    customerId = json['customerId'];
}