class NewUserVoucher {
  String title;
  String description;
  DateTime expiredDate;
  double discountPercentage;

  NewUserVoucher(this.title, this.description, this.expiredDate,
      this.discountPercentage);

  Map<String,dynamic> toJson() => {
    'title' : title,
    'description': description,
    'expiredDate' : expiredDate,
    'discountPercentage' : discountPercentage,
  };

  NewUserVoucher.fromJson(Map<String,dynamic> json) :
        title = json['title'],
        description = json['description'],
        discountPercentage = json['discountPercentage'],
        expiredDate = json['expiredDate'].toDate();

}