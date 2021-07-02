class FoodMenuDetail {
  String id;
  String name;
  String description;
  String price;
  String category;
  String picture;

  FoodMenuDetail(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.category,
      this.picture});


  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'picture': picture,
      };

  FoodMenuDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        category = json['category'],
        picture = json['picture'];
}
