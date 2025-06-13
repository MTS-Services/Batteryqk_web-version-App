class UserModel {
  final int id;
  final String email;
  final String fname;
  final String lname;
  final String uid;
  final String createdAt;
  final String updatedAt;
  final int totalRewardPoints;
  final String highestRewardCategory;

  UserModel({
    required this.id,
    required this.email,
    required this.fname,
    required this.lname,
    required this.uid,
    required this.createdAt,
    required this.updatedAt,
    required this.totalRewardPoints,
    required this.highestRewardCategory,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fname: json['fname'],
      lname: json['lname'],
      uid: json['uid'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      totalRewardPoints: json['totalRewardPoints'] ?? 0,
      highestRewardCategory: json['highestRewardCategory'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $fname $lname, points: $totalRewardPoints, category: $highestRewardCategory)';
  }
}
