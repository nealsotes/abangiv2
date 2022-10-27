class RentalModel {
  late int rentalId;
  late String owner;
  late String image;
  late String itemName;
  late String rentalStatus;
  late String rentalRemarks;
  late String requestDate;

  RentalModel(this.rentalId, this.owner, this.image, this.itemName,
      this.rentalStatus, this.rentalRemarks, this.requestDate);

  RentalModel.fromJson(Map<String, dynamic> json) {
    rentalId = json['rentalId'];
    owner = json['itemOwner'];
    image = json['itemImage'];
    itemName = json['itemName'];
    rentalStatus = json['rentalStatus'];
    rentalRemarks = json['rentalRemarks'];
    requestDate = json['startDate'];
  }
}
