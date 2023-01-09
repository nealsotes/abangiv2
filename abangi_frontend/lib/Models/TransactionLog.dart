class TransactionModel {
  late String renter;
  late String owner;
  late String itemRented;
  late String dateRented;
  late String dateReturned;
  late String paymentStatus;
  late String transactionStatus;
  late String amountPaid;
  late String paymentMethod;
  late String timeStamp;
  late int itemPrice;

  TransactionModel(
      this.renter,
      this.owner,
      this.itemRented,
      this.dateRented,
      this.dateReturned,
      this.paymentStatus,
      this.transactionStatus,
      this.amountPaid,
      this.paymentMethod,
      this.timeStamp,
      this.itemPrice);

  TransactionModel.fromJson(Map<String, dynamic> json) {
    renter = json['renter'];
    owner = json['owner'];
    itemRented = json['itemRented'];
    dateRented = json['dateRented'];
    dateReturned = json['dateReturned'];
    paymentStatus = json['paymentStatus'];
    transactionStatus = json['transactionStatus'];
    amountPaid = json['amountPaid'];
    paymentMethod = json['paymentMethod'];
    timeStamp = json['TimeStamp'];
    itemPrice = json['itemPrice'];
  }
}
