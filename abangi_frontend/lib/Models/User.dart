class AuthUserDetails {
  User? userDetails;
}

class User {
  late int userid;
  late String name;
  late String email;
  late String role;
  late String phone;
  late String location;
  String? profileImage;
  late String isAbangiVerified;
  late String userStatus;

  User(
    this.userid,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.location,
    this.profileImage,
    this.isAbangiVerified,
    this.userStatus,
  );

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    name = json['fullName'];
    email = json['email'];
    phone = json['contact'];
    location = json['address'];
    role = json['role'];
    isAbangiVerified = json["isAbangiVerified"];
    userStatus = json["Status"];
    profileImage = json['userImage'];
  }

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'fullName': name,
        'email': email,
        'contact': phone,
        'address': location,
        'role': role,
        'userImage': profileImage,
        'isAbangiVerified': isAbangiVerified,
        'Status': userStatus,
      };
}
