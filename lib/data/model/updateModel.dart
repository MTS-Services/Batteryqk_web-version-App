class UpdateModel {
  final String fname;
  final String lname;


  UpdateModel({
    required this.fname,
    required this.lname,


  });

  factory UpdateModel.fromJson(Map<String, dynamic> json) {
    return UpdateModel(
      fname: json['fname'],
      lname: json['lname'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
    };
  }
}
