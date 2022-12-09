class TransactionModel {
  String renter;
  String owner;
  String itemRented;
  String dateRented;
  String dateReturned;
  String paymentStatus;
  String transactionStatus;
  String amountPaid;
  String paymentMethod;
  String timeStamp;
  int itemPrice;

  TransactionModel(
      {required this.renter,
      required this.owner,
      required this.itemRented,
      required this.dateRented,
      required this.dateReturned,
      required this.paymentStatus,
      required this.transactionStatus,
      required this.amountPaid,
      required this.paymentMethod,
      required this.timeStamp,
      required this.itemPrice});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      renter: json['renter'],
      owner: json['owner'],
      itemRented: json['itemRented'],
      dateRented: json['dateRented'],
      dateReturned: json['dateReturned'],
      paymentStatus: json['paymentStatus'],
      transactionStatus: json['transactionStatus'],
      amountPaid: json['amountPaid'],
      paymentMethod: json['paymentMethod'],
      timeStamp: json['TimeStamp'],
      itemPrice: json['itemPrice'],
    );
  }
}
