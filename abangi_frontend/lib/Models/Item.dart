class ItemModel {
  late String itemName;
  late String description;
  late double price;
  late String category;
  late String owner;
  late String rentalMethod;
  late String location;
  late String image;

  ItemModel(this.itemName, this.description, this.price, this.category,
      this.owner, this.rentalMethod, this.location, this.image);

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    owner = json['owner'];
    rentalMethod = json['rentalMethod'];
    location = json['location'];
    image = json['image'];
  }
}
