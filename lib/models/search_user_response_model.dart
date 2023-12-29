import 'package:showny/models/user_model.dart';

class SearchUserReseponseModel {
  int totalCount;
  List<UserModel> userList;

  SearchUserReseponseModel({
    this.totalCount = 0,
    this.userList = const []
  });

  factory SearchUserReseponseModel.fromJson(Map<String, dynamic> json) {
    var userModelList = (json['userData'] as List)
        .map((item) => UserModel.fromJson(item))
        .toList();
        
    return SearchUserReseponseModel(
      totalCount: json['totalCount'] as int,
      userList: userModelList
    );
  }
}