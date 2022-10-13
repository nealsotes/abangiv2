class User {
  late String name;
  late String email;
  late String role;
  late String phone;
  late String location;
  late String image;
  late String isAbangiVerified;

  User(
    this.name,
    this.email,
    this.role,
    this.phone,
    this.location,
    this.image,
    this.isAbangiVerified,
  );

  User.fromJson(Map<String, dynamic> json) {
    name = json['fullname'];
    email = json['email'];
    role = json['role'];
    phone = json['contact'];
    location = json['address'];
    image = json['image'];
    isAbangiVerified = json['isAbangiVerified'];
  }
}
