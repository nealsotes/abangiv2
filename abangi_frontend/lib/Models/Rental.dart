class RentalModel {
  late int rentalId;
  late String owner;
  late String image;
  late String itemName;
  late String rentalStatus;
  late String rentalRemarks;
  late String requestDate;
  late String userStatus;
  late double rentalPrice;
  late String location;

  RentalModel(
      this.rentalId,
      this.owner,
      this.image,
      this.itemName,
      this.rentalStatus,
      this.rentalRemarks,
      this.requestDate,
      this.userStatus,
      this.rentalPrice,
      this.location);

  RentalModel.fromJson(Map<String, dynamic> json) {
    rentalId = json['rentalId'];
    owner = json['itemOwner'];
    image = json['itemImage'];
    itemName = json['itemName'];
    rentalStatus = json['rentalStatus'];
    rentalRemarks = json['rentalRemarks'];
    requestDate = json['startDate'];
    userStatus = json['status'];
    rentalPrice = json['itemPrice'];
    location = json['itemlocation'];
  }
}
