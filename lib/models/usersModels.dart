class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? profilePic;

  UserModel(this.uid, this.fullName, this.email, this.profilePic);

  UserModel.fromMap(Map<String, dynamic> map)
  {
    uid = map["UID"];
    fullName = map["FUllNAME"];
    email = map["EMAIL"];
    profilePic = map["PROFILEPIC"];
  }

  Map<String, dynamic> toMap() {
    return {
      "UID": uid,
      "FUllNAME": fullName,
      "EMAIL": email,
      "PROFILEPIC": profilePic,
    };
  }
}