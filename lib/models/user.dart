class Username {
  String uid;
  bool admin;
  String name;
  String profilePic;

  Username({this.uid, this.name, this.profilePic});
}

class UserData {
  final String uid;
  final String household;
  final String name;
  final String members;

  UserData({this.uid, this.household, this.name, this.members});
}

class UserModel {
  String uid;
  bool admin;
  String name;
  String profilePic;

  UserModel(this.uid, {this.name, this.profilePic});
}
