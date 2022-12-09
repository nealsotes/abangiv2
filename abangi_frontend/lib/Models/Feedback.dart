// ignore_for_file: non_constant_identifier_names

class FeedbackModel {
  late String name;
  late String ratings;
  late String comments;
  late String userImage;

  FeedbackModel(this.name, this.ratings, this.comments, this.userImage);

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    name = json['fullName'];
    ratings = json['ratings'];
    comments = json['comments'];
    userImage = json['userImage'];
  }
}
