class Member {
  String username;
  String email;
  String userId;

  //state for future used
  String loyaltyPoint;
  bool admin;

  Member(
      {this.username,
      this.email,
      this.userId,
      this.admin,
      this.loyaltyPoint = '0.0'});

  //could create accessToken to set the login expire time
  //after sign in, credential returns: the user name and password, phone number, or auth provider information—the user signed in with.

  Member.fromJson(Map<String,dynamic> json) :
      admin = json['admin'],
      username = json['username'],
      email = json['email'],
      loyaltyPoint = json['loyaltyPoint'],
      userId = json['userId'];

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'loyaltyPoint' : loyaltyPoint,
    'admin': admin,
    'userId': userId,
  };
}