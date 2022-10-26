// ignore_for_file: non_constant_identifier_names

class ItemModel {
  late int userId;
  late int itemId;
  late String itemName;
  late String description;
  late double price;
  late String category;
  late String owner;
  late String rentalMethod;
  late String location;
  late String image;
  late String startDate;
  late String endDate;
  late bool AbangiVerified;
  late String dateCreated;
  late String userStatus;
  ItemModel(
    this.userId,
    this.itemId,
    this.itemName,
    this.description,
    this.price,
    this.category,
    this.owner,
    this.rentalMethod,
    this.location,
    this.image,
    this.startDate,
    this.endDate,
    this.AbangiVerified,
    this.dateCreated,
    this.userStatus,
  );

  ItemModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    itemId = json['itemId'];
    itemName = json['itemName'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    owner = json['owner'];
    rentalMethod = json['rentalMethod'];
    location = json['location'];
    image = json['image'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    AbangiVerified = json['abangiVerified'];
    dateCreated = json['dateCreated'];
    userStatus = json['status'];
  }
}
