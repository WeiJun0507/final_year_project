class LoyaltyRewards {
  String title;
  String description;
  DateTime expiredDate;
  double discountPercentage;
  double loyaltyPoint;

  LoyaltyRewards(this.title, this.description, this.expiredDate,
      this.discountPercentage, this.loyaltyPoint);

  ///redeemLoyaltyRewards () {
///Firebase.update(
///{loyaltyPoint: referenceCurrentUser.point - loyaltyPoint},
///{user.voucher = { ..., loyaltyRewardsReference.id } }
///).(merge: true);
///
///}

Map<String,dynamic> toJson() => {
  'title' : title,
  'description': description,
  'expiredDate' : expiredDate,
  'discountPercentage' : discountPercentage,
  'loyaltyPoint' : loyaltyPoint,
};

  LoyaltyRewards.fromJson(Map<String,dynamic> json) :
      title = json['title'],
        description = json['description'],
        discountPercentage = json['discountPercentage'],
        expiredDate = json['expiredDate'].toDate(),
        loyaltyPoint = json['loyaltyPoint'];

}