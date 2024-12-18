
class User {
  final int userId;
  final String fullName;
  final String cmpName;
  final String userName;
  final String contactNo;
  final String? cmpLogo;

  User({
    required this.userId,
    required this.fullName,
    required this.cmpName,
    required this.userName,
    required this.contactNo,
    this.cmpLogo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      fullName: json['full_name'],
      cmpName: json['cmpName'],
      userName: json['user_name'],
      contactNo: json['contactNo'].toString(),
      cmpLogo: json['cmp_logo'],
    );
  }
}
