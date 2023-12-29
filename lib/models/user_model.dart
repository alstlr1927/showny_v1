class UserModel {
  String memNo;
  String memId;
  String memNm;
  String nickNm;
  int gender;
  String birthday;
  String email;
  String phone;
  String profileImage;
  String introduce;
  int heightId;
  int weightId;
  int bodyShapeId;
  List<int> styleIdList;
  List<int> colorIdList;
  int postCount;
  int followerCount;
  int followCount;
  bool isFollow;

  UserModel({
    this.memNo = "",
    this.memId = "",
    this.memNm = "",
    this.nickNm = "",
    this.gender = 0,
    this.birthday = "",
    this.email = "",
    this.phone = "",
    this.profileImage = "",
    this.introduce = "",
    this.heightId = 0,
    this.weightId = 0,
    this.bodyShapeId = 0,
    this.styleIdList = const [],
    this.colorIdList = const [],
    this.postCount = 0,
    this.followerCount = 0,
    this.followCount = 0,
    this.isFollow = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      memNo: json['memNo'] as String,
      memId: json['memId'] as String,
      memNm: json['memNm'] as String,
      nickNm: json['nickNm'] as String,
      gender: json['gender'] as int,
      birthday: json['birthday'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profileImage: json['profileImage'] as String,
      introduce: json['introduce'] as String,
      heightId: json['heightId'] as int,
      weightId: json['weightId'] as int,
      bodyShapeId: json['bodyShapeId'] as int,
      styleIdList: List<int>.from(json['styleIdList'] ?? []),
      colorIdList: List<int>.from(json['colorIdList'] ?? []),
      postCount: json['postCount'] as int,
      followerCount: json['followerCount'] as int,
      followCount: json['followCount'] as int,
      isFollow: json['isFollow'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memNo': memNo,
      'memId': memId,
      'memNm': memNm,
      'nickNm': nickNm,
      'gender': gender,
      'birthday': birthday,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'introduce': introduce,
      'heightId': heightId,
      'weightId': weightId,
      'bodyShapeId': bodyShapeId,
      'styleIdList': styleIdList,
      'colorIdList': colorIdList,
      'postCount': postCount,
      'followerCount': followerCount,
      'followCount': followCount,
      'isFollow': isFollow,
    };
  }
}