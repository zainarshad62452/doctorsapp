import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  Timestamp? registeredOn;
  String? profileImageUrl;
  String? contactNo;
  String? bio;
  String? address;
  String? userType;
  String? token;

  UserModel(
      {this.name,
        this.email,
        this.registeredOn,
        this.profileImageUrl,
        this.contactNo,
        this.bio,
        this.uid,
        this.address,
        this.userType,
        this.token
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    registeredOn = json['registeredOn'];
    profileImageUrl = json['profileImageUrl'];
    contactNo = json['contactNo'];
    userType = json['userType'];
    uid = json['uid'];
    address =json['address'];
    userType =json['userType'];
    bio = json['bio'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['registeredOn'] = this.registeredOn;
    data['profileImageUrl'] = this.profileImageUrl;
    data['contactNo'] = this.contactNo;
    data['userType'] = this.userType;
    data['uid'] = this.uid;
    data['address'] = this.address;
    data['bio'] = this.bio;
    data['token'] = this.token;
    return data;
  }
}
