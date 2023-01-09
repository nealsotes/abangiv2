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
  late int itemId;
  late String endDate;
  late String renterName;
  late String itemCategory;

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
      this.location,
      this.itemId,
      this.endDate,
      this.renterName,
      this.itemCategory);

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
    itemId = json['itemId'];
    endDate = json['endDate'];
    renterName = json['renterName'];
    itemCategory = json['itemCategory'];
  }
}
