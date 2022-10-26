class RentalModel {
  late int rentalId;
  late int owner;
  late String image;
  late String itemName;
  late String rentalStatus;

  RentalModel(
      this.rentalId, this.owner, this.image, this.itemName, this.rentalStatus);

  RentalModel.fromJson(Map<String, dynamic> json) {
    rentalId = json['rentalId'];
    owner = json['itemOwner'];
    image = json['imageImage'];
    itemName = json['itemName'];
    rentalStatus = json['rentalStatus'];
  }
}
