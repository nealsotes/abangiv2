// ignore: file_names

class User {
  int userId;
  String fullName;
  String email;
  String contact;
  String address;

  User({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.contact,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['contact'] = contact;
    data['address'] = address;
    return data;
  }
}
