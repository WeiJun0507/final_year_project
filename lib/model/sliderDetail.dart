import 'package:final_year_project/services/Database.dart';

class SliderDetail {
  String id;
  String title;
  String description;
  String image;

  SliderDetail({this.id, this.title, this.description, this.image});

  //fromJson
  SliderDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        image = json['image'];

  //toJson
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'image': image,
  };

}

/// Faked Data
///
/// {
///   id: '1',
///   title: 'Promotion',
///   description: 'Voucher to discount 30%',
///   image: 'assets/image/undraw_Hamburger_8ge6.png',
/// }
/// {
///   id: '2',
///   title: 'New Menu',
///   description: 'Roti Canai',
///   image: 'assets/image/undraw_ice_cream_s2rh.png',
/// }
/// {
///   id: '3',
///   title: 'Discount',
///   description: 'Voucher for Buy 1 Free 1',
///   image: 'assets/image/undraw_special_event_4aj8.png',
/// }
///
