class FoodMenu {
  String id;
  String category;
  String title;
  String description;
  String picture;

  FoodMenu(
      {this.id, this.category, this.title, this.description, this.picture});

//passing a list of menu into this page
//List<FoodMenu> menu(int index) {
//if (categoryId = this.index) {
//  return FoodMenu.foodList;
//}
//}

// Map<String,Object> data = {
// 'food': FoodMenuDetail(id, name, description, price);
//collection(category).doc().update(data);

//toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'title': title,
        'description': description,
        'picture': picture,
      };

//fromJson
  FoodMenu.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        category = json['category'],
        title = json['title'],
        description = json['description'],
        picture = json['picture'];


}

///could be use when the user click on the ListTile that is associated to the respective category id;
///
/// [
///   {
///     id : 1,
///     category: Chinese Cuisine,
///     FoodList: []
///   },
///   {
///     id : 2,
///     category: Dessert,
///     FoodList: []
///   },
///   {
///     id : 3,
///     category: Beverage,
///     FoodList: []
///   },
///
/// The ListTile/ ListView Builder should display the food menu in order so that the listview
/// can show the correct Food Menu.
///
