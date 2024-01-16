class UserInfo {
  String email;
  String firstName;
  String eyes;
  List interests;
  String date;
  String sex;
  bool confirm;
  String userID;

  UserInfo({
    required this.email,
    required this.firstName,
    required this.eyes,
    required this.interests,
    required this.date,
    required this.sex,
    required this.confirm,
    required this.userID
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'eyes': eyes,
        'interests': interests,
        'date': date,
        'sex': sex,
        'confirm': confirm,
        'userID': userID,
      };

  factory UserInfo.fromMap(Map<String, Object?> userMap) {
    return UserInfo(
      email: userMap['email'] as String,
      firstName: userMap['firstName'] as String,
      eyes: userMap['eyes'] as String,
      interests: userMap['interests'] as List,
      date: userMap['date'] as String,
      sex: userMap['sex'] as String,
      confirm: userMap['confirm'] as bool,
      userID: userMap['userID'] as String,
    );
  }
}
