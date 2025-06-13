class UpdateModel {
  final String fname;
  final String lname;
  final String email;

  UpdateModel({
    required this.fname,
    required this.lname,
    required this.email,

  });

  factory UpdateModel.fromJson(Map<String, dynamic> json) {
    return UpdateModel(
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
    };
  }
}
