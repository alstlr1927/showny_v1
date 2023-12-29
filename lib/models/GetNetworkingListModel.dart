import 'package:showny/models/user_model.dart';

class GetNetworkingListModel {
  List<UserModel> myStyleupLikeUserList;
  List<UserModel> eachOtherStyleupLikeUserList;
  List<UserModel> myBattlePollUserList;
  List<UserModel> eachOtherBattlePollUserList;
  List<UserModel> nearUserList;
  List<UserModel> sameStyleUserList;
  List<UserModel> newUserList;
  List<UserModel> sameColorUserList;
  List<UserModel> otherGenderUserList;
  List<UserModel> sameGenderUserList;

  GetNetworkingListModel({
    this.myStyleupLikeUserList = const [],
    this.eachOtherStyleupLikeUserList = const [],
    this.myBattlePollUserList = const [],
    this.eachOtherBattlePollUserList = const [],
    this.nearUserList = const [],
    this.sameStyleUserList = const [],
    this.newUserList = const [],
    this.sameColorUserList = const [],
    this.otherGenderUserList = const [],
    this.sameGenderUserList = const [],
  });

  factory GetNetworkingListModel.fromJson(Map<String, dynamic> json) {
    var myStyleupLikeUserList = (json['myStyleupLikeUserList'] as List)
        .map((item) => UserModel.fromJson(item))
        .toList();
    var eachOtherStyleupLikeUserList = (json['eachOtherStyleupLikeUserList'] as List)
    .map((item) => UserModel.fromJson(item))
    .toList();
    var myBattlePollUserList = (json['myBattlePollUserList'] as List)
    .map((item) => UserModel.fromJson(item))
    .toList();
    var eachOtherBattlePollUserList = (json['eachOtherBattlePollUserList'] as List)
    .map((item) => UserModel.fromJson(item))
    .toList();
    var nearUserList = (json['nearUserList'] as List)
    .map((item) => UserModel.fromJson(item))
    .toList();
    var sameStyleUserList = (json['sameStyleUserList'] as List)
    .map((item) => UserModel.fromJson(item))
    .toList();
    var newUserList = (json['newUserList'] as List)
    .map((item) => UserModel.fromJson(item))
    .toList();
    var sameColorUserList = (json['sameColorUserList'] as List)
    .map((item) => UserModel.fromJson(item))
    .toList();
    var otherGenderUserList = (json['otherGenderUserList'] as List)
    .map((item) => UserModel.fromJson(item))
    .toList();
    var sameGenderUserList = (json['sameGenderUserList'] as List)
    .map((item) => UserModel.fromJson(item))
    .toList();
        
    return GetNetworkingListModel(
      myStyleupLikeUserList: myStyleupLikeUserList,
      eachOtherStyleupLikeUserList: eachOtherStyleupLikeUserList,
      myBattlePollUserList: myBattlePollUserList,
      eachOtherBattlePollUserList: eachOtherBattlePollUserList,
      nearUserList: nearUserList,
      sameStyleUserList: sameStyleUserList,
      newUserList: newUserList,
      sameColorUserList: sameColorUserList,
      otherGenderUserList: otherGenderUserList,
      sameGenderUserList: sameGenderUserList,
    );
  }
}