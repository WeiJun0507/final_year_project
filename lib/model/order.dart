
class Order {
  String id;
  int selectedTime;
  DateTime selectedDate;
  //Combine selectedDate and selectedTime
  DateTime bookingDate;
  String tableId;
  bool isBooked;
  String customerId;
  String customerName;
  List selectedItem;
  double totalPrice;
  String comment;

  Order(this.selectedTime, this.selectedDate,
      this.tableId, this.isBooked, this.customerId, this.selectedItem, this.totalPrice, this.comment, this.customerName): this.bookingDate = DateTime(selectedDate.year,selectedDate.month,selectedDate.day, selectedTime).add(Duration(hours: -8));

  Order.fromJson(Map<String,dynamic> json) :
        selectedTime = json['selectedTime'],
        selectedDate = json['selectedDate'],
        tableId = json['tableId'],
        isBooked = json['isBooked'],
        customerId = json['customerId'],
        customerName = json['customerName'],
        bookingDate = json['bookingDate'],
        selectedItem = json['selectedItem'],
        totalPrice = json['totalPrice'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
    'selectedTime': selectedTime,
    'selectedDate': selectedDate,
    'tableId' : tableId,
    'isBooked': isBooked,
    'customerId': customerId,
    'customerName' : customerName,
    'bookingDate': bookingDate,
    'selectedItem': selectedItem,
    'totalPrice': totalPrice,
    'comment': comment,
  };



}