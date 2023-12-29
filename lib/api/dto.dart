import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class VerifyPhoneNumberSendDto {
  VerifyPhoneNumberSendDto({
    required this.email,
    required this.phoneNumber,
  });

  String email;
  String phoneNumber;

  factory VerifyPhoneNumberSendDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyPhoneNumberSendDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPhoneNumberSendDtoToJson(this);
}

@JsonSerializable()
class VerifyPhoneNumberDto {
  VerifyPhoneNumberDto({
    required this.email,
    required this.phoneNumber,
    required this.verifyCode,
  });

  String email;
  String phoneNumber;
  String verifyCode;

  factory VerifyPhoneNumberDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyPhoneNumberDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPhoneNumberDtoToJson(this);
}

@JsonSerializable()
class CheckDuplicateEmailDto {
  CheckDuplicateEmailDto({
    required this.email,
  });

  String email;

  factory CheckDuplicateEmailDto.fromJson(Map<String, dynamic> json) =>
      _$CheckDuplicateEmailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckDuplicateEmailDtoToJson(this);
}

@JsonSerializable()
class CheckDuplicateIdDto {
  CheckDuplicateIdDto({
    required this.memId,
  });

  String memId;

  factory CheckDuplicateIdDto.fromJson(Map<String, dynamic> json) =>
      _$CheckDuplicateIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckDuplicateIdDtoToJson(this);
}

@JsonSerializable()
class SignupEmailDto {
  SignupEmailDto({
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.marketingAgree,
  });

  String email;
  String password;
  String name;
  String phoneNumber;
  String marketingAgree;

  factory SignupEmailDto.fromJson(Map<String, dynamic> json) =>
      _$SignupEmailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignupEmailDtoToJson(this);
}

@JsonSerializable()
class SignupSnsDto {
  SignupSnsDto({
    required this.snsType,
    required this.snsId,
    required this.name,
    required this.phoneNumber,
    required this.marketingAgree,
  });

  String snsType;
  String snsId;
  String name;
  String phoneNumber;
  String marketingAgree;

  factory SignupSnsDto.fromJson(Map<String, dynamic> json) =>
      _$SignupSnsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignupSnsDtoToJson(this);
}

@JsonSerializable()
class SigninEmailDto {
  SigninEmailDto({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory SigninEmailDto.fromJson(Map<String, dynamic> json) =>
      _$SigninEmailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SigninEmailDtoToJson(this);
}

@JsonSerializable()
class SigninSnsDto {
  SigninSnsDto({
    required this.snsType,
    required this.snsId,
  });

  String snsType;
  String snsId;

  factory SigninSnsDto.fromJson(Map<String, dynamic> json) =>
      _$SigninSnsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SigninSnsDtoToJson(this);
}

@JsonSerializable()
class ProfileEditDto {
  ProfileEditDto({
    required this.memNo,
    this.gender,
    this.newMemId,
    this.birthday,
    this.heightId,
    this.weightId,
    this.bodyShapeId,
    this.styleIdList,
    this.colorIdList,
    this.password,
    this.newPassword,
    this.introduce,
    this.phoneNumber,
  });

  String memNo;
  int? gender;
  String? newMemId;
  String? birthday;
  String? heightId;
  String? weightId;
  String? bodyShapeId;
  String? styleIdList;
  String? colorIdList;
  String? password;
  String? newPassword;
  String? introduce;
  String? phoneNumber;

  factory ProfileEditDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileEditDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEditDtoToJson(this);
}

@JsonSerializable()
class GetProfileDto {
  GetProfileDto({
    required this.memNo,
  });

  String memNo;

  factory GetProfileDto.fromJson(Map<String, dynamic> json) =>
      _$GetProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileDtoToJson(this);
}

@JsonSerializable()
class FindPasswordDto {
  FindPasswordDto({
    required this.email,
  });

  String email;

  factory FindPasswordDto.fromJson(Map<String, dynamic> json) =>
      _$FindPasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FindPasswordDtoToJson(this);
}

@JsonSerializable()
class UserFollowDto {
  UserFollowDto({
    required this.memNo,
    required this.followMemNo,
  });

  String memNo;
  String followMemNo;

  factory UserFollowDto.fromJson(Map<String, dynamic> json) =>
      _$UserFollowDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserFollowDtoToJson(this);
}

@JsonSerializable()
class InsertStyleupDto {
  String memNo;
  String type;
  List<String>? imgUrlList;
  String? videoUrl;
  String? thumbnailUrl;
  String description;
  List<String> styles;
  List<String> colors;
  String season;
  List<Map<String, dynamic>>? itemOuter;
  List<Map<String, dynamic>>? itemTop;
  List<Map<String, dynamic>>? itemPants;
  List<Map<String, dynamic>>? itemShoes;
  List<Map<String, dynamic>>? itemBag;
  List<Map<String, dynamic>>? itemAccessory;

  InsertStyleupDto({
    required this.memNo,
    required this.type,
    required this.description,
    required this.styles,
    required this.colors,
    required this.season,
    this.itemOuter,
    this.itemTop,
    this.itemPants,
    this.itemShoes,
    this.itemBag,
    this.itemAccessory,
    this.imgUrlList,
    this.videoUrl,
    this.thumbnailUrl,
  });

  factory InsertStyleupDto.fromJson(Map<String, dynamic> json) =>
      _$InsertStyleupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InsertStyleupDtoToJson(this);
}

@JsonSerializable()
class GetStyleupListDto {
  String memNo;
  String page;
  String connectTime;

  GetStyleupListDto({
    required this.memNo,
    required this.page,
    required this.connectTime,
  });

  factory GetStyleupListDto.fromJson(Map<String, dynamic> json) =>
      _$GetStyleupListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetStyleupListDtoToJson(this);
}

@JsonSerializable()
class DeleteStyleupDto {
  String styleupNo;

  DeleteStyleupDto({
    required this.styleupNo,
  });

  factory DeleteStyleupDto.fromJson(Map<String, dynamic> json) =>
      _$DeleteStyleupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteStyleupDtoToJson(this);
}

@JsonSerializable()
class GetWearingListDto {
  String styleupNo;
  String arrayNo;

  GetWearingListDto({
    required this.styleupNo,
    required this.arrayNo,
  });

  factory GetWearingListDto.fromJson(Map<String, dynamic> json) =>
      _$GetWearingListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetWearingListDtoToJson(this);
}

@JsonSerializable()
class InsertStyleupReportDto {
  String styleupNo;
  String memNo;
  int reportTypeNo;

  InsertStyleupReportDto({
    required this.styleupNo,
    required this.memNo,
    required this.reportTypeNo,
  });

  factory InsertStyleupReportDto.fromJson(Map<String, dynamic> json) =>
      _$InsertStyleupReportDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InsertStyleupReportDtoToJson(this);
}

@JsonSerializable()
class InsertStyleupCommentDto {
  String styleupNo;
  String memNo;
  String? parentStyleupCommentNo; // 대댓글인 경우 필요한 필드
  String detail;

  InsertStyleupCommentDto({
    required this.styleupNo,
    required this.memNo,
    this.parentStyleupCommentNo, // 대댓글인 경우 필요한 필드
    required this.detail,
  });

  factory InsertStyleupCommentDto.fromJson(Map<String, dynamic> json) =>
      _$InsertStyleupCommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InsertStyleupCommentDtoToJson(this);
}

@JsonSerializable()
class DeleteStyleupCommentDto {
  String memNo;
  String styleupCommentNo;

  DeleteStyleupCommentDto({
    required this.memNo,
    required this.styleupCommentNo,
  });

  factory DeleteStyleupCommentDto.fromJson(Map<String, dynamic> json) =>
      _$DeleteStyleupCommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteStyleupCommentDtoToJson(this);
}

@JsonSerializable()
class StyleupCommentHeartDto {
  String styleupCommentNo;
  String memNo;

  StyleupCommentHeartDto({
    required this.styleupCommentNo,
    required this.memNo,
  });

  factory StyleupCommentHeartDto.fromJson(Map<String, dynamic> json) =>
      _$StyleupCommentHeartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StyleupCommentHeartDtoToJson(this);
}

@JsonSerializable()
class GetStyleupCommentListDto {
  String styleupNo;
  String memNo;
  String page;
  String connectTime;

  GetStyleupCommentListDto({
    required this.styleupNo,
    required this.memNo,
    required this.page,
    required this.connectTime,
  });

  factory GetStyleupCommentListDto.fromJson(Map<String, dynamic> json) =>
      _$GetStyleupCommentListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetStyleupCommentListDtoToJson(this);
}

@JsonSerializable()
class StyleupBookmarkDto {
  String styleupNo;
  String memNo;

  StyleupBookmarkDto({
    required this.styleupNo,
    required this.memNo,
  });

  factory StyleupBookmarkDto.fromJson(Map<String, dynamic> json) =>
      _$StyleupBookmarkDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StyleupBookmarkDtoToJson(this);
}

@JsonSerializable()
class StyleupUpDownDto {
  String styleupNo;
  String memNo;
  int upDownType;

  StyleupUpDownDto({
    required this.styleupNo,
    required this.memNo,
    required this.upDownType,
  });

  factory StyleupUpDownDto.fromJson(Map<String, dynamic> json) =>
      _$StyleupUpDownDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StyleupUpDownDtoToJson(this);
}

@JsonSerializable()
class InsertStyleupBattleDto {
  String title;
  String thumbnailUrl;
  String recruitmentStart;
  String recruitmentEnd;
  String participationStart;
  String participationEnd;
  String round;

  InsertStyleupBattleDto({
    required this.title,
    required this.thumbnailUrl,
    required this.recruitmentStart,
    required this.recruitmentEnd,
    required this.participationStart,
    required this.participationEnd,
    required this.round,
  });

  factory InsertStyleupBattleDto.fromJson(Map<String, dynamic> json) =>
      _$InsertStyleupBattleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InsertStyleupBattleDtoToJson(this);
}

@JsonSerializable()
class GetMyStyleupListDto {
  String memNo;
  String page;
  String connectTime;

  GetMyStyleupListDto({
    required this.memNo,
    required this.page,
    required this.connectTime,
  });

  factory GetMyStyleupListDto.fromJson(Map<String, dynamic> json) =>
      _$GetMyStyleupListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetMyStyleupListDtoToJson(this);
}

@JsonSerializable()
class InsertStyleupBattleParticipationDto {
  String styleupBattleNo;
  String styleupNo;
  String memNo;

  InsertStyleupBattleParticipationDto({
    required this.styleupBattleNo,
    required this.styleupNo,
    required this.memNo,
  });

  factory InsertStyleupBattleParticipationDto.fromJson(
          Map<String, dynamic> json) =>
      _$InsertStyleupBattleParticipationDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InsertStyleupBattleParticipationDtoToJson(this);
}

@JsonSerializable()
class InsertStyleupCommentReportDto {
  int styleupCommentNo;
  int memNo;
  int reportTypeNo;

  InsertStyleupCommentReportDto({
    required this.styleupCommentNo,
    required this.memNo,
    required this.reportTypeNo,
  });

  factory InsertStyleupCommentReportDto.fromJson(Map<String, dynamic> json) =>
      _$InsertStyleupCommentReportDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InsertStyleupCommentReportDtoToJson(this);
}

@JsonSerializable()
class GetStyleupBattleItemListDto {
  String? styleupBattleNo;
  String memNo;

  GetStyleupBattleItemListDto({
    this.styleupBattleNo,
    required this.memNo,
  });

  factory GetStyleupBattleItemListDto.fromJson(Map<String, dynamic> json) =>
      _$GetStyleupBattleItemListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetStyleupBattleItemListDtoToJson(this);
}

@JsonSerializable()
class SelectStyleupBattleItemDto {
  String battleRoundNo;
  String selectedStyleupNo;
  String otherStyleupNo;
  String memNo;

  SelectStyleupBattleItemDto({
    required this.battleRoundNo,
    required this.selectedStyleupNo,
    required this.otherStyleupNo,
    required this.memNo,
  });

  factory SelectStyleupBattleItemDto.fromJson(Map<String, dynamic> json) =>
      _$SelectStyleupBattleItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SelectStyleupBattleItemDtoToJson(this);
}

@JsonSerializable()
class GetFollowStyleupDto {
  String memNo;
  String? gender;
  List<String>? height;
  List<String>? weight;
  List<String>? bodyShapeId;
  List<String>? seasonIdList;
  List<String>? styleIdList;
  String sort;
  String page;
  String connectTime;

  GetFollowStyleupDto({
    required this.memNo,
    required this.sort,
    required this.page,
    required this.connectTime,
    this.gender,
    this.height,
    this.weight,
    this.bodyShapeId,
    this.seasonIdList,
    this.styleIdList,
  });

  factory GetFollowStyleupDto.fromJson(Map<String, dynamic> json) =>
      _$GetFollowStyleupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetFollowStyleupDtoToJson(this);
}

@JsonSerializable()
class GetRecommendStyleupDto {
  String memNo;
  String? gender;
  String? height;
  String? weight;
  String? bodyShapeId;
  String? seasonIdList;
  String? styleIdList;
  String sort;
  String page;
  String connectTime;

  GetRecommendStyleupDto({
    required this.memNo,
    this.gender,
    this.height,
    this.weight,
    this.bodyShapeId,
    this.seasonIdList,
    this.styleIdList,
    required this.sort,
    required this.page,
    required this.connectTime,
  });

  factory GetRecommendStyleupDto.fromJson(Map<String, dynamic> json) =>
      _$GetRecommendStyleupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetRecommendStyleupDtoToJson(this);
}

@JsonSerializable()
class GetRankingStyleupDto {
  String memNo;

  GetRankingStyleupDto({
    required this.memNo,
  });

  factory GetRankingStyleupDto.fromJson(Map<String, dynamic> json) =>
      _$GetRankingStyleupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetRankingStyleupDtoToJson(this);
}

@JsonSerializable()
class SearchUserDto {
  String memNo;
  String keyword;
  String page;
  String connectTime;

  SearchUserDto({
    required this.memNo,
    required this.keyword,
    required this.page,
    required this.connectTime,
  });

  factory SearchUserDto.fromJson(Map<String, dynamic> json) =>
      _$SearchUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserDtoToJson(this);
}

@JsonSerializable()
class SearchPostDto {
  String memNo;
  String keyword;
  String page;
  String connectTime;

  SearchPostDto({
    required this.memNo,
    required this.keyword,
    required this.page,
    required this.connectTime,
  });

  factory SearchPostDto.fromJson(Map<String, dynamic> json) =>
      _$SearchPostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPostDtoToJson(this);
}

@JsonSerializable()
class GetRecentSearchDto {
  String memNo;

  GetRecentSearchDto({
    required this.memNo,
  });

  factory GetRecentSearchDto.fromJson(Map<String, dynamic> json) =>
      _$GetRecentSearchDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetRecentSearchDtoToJson(this);
}

@JsonSerializable()
class GetBannerListDto {
  final String memNo;

  GetBannerListDto({
    required this.memNo,
  });

  factory GetBannerListDto.fromJson(Map<String, dynamic> json) =>
      _$GetBannerListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetBannerListDtoToJson(this);
}

@JsonSerializable()
class GetFollowListDto {
  final String memNo;
  final String profileMemNo;

  GetFollowListDto({
    required this.memNo,
    required this.profileMemNo,
  });

  factory GetFollowListDto.fromJson(Map<String, dynamic> json) =>
      _$GetFollowListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetFollowListDtoToJson(this);
}

@JsonSerializable()
class GetOtherProfileControllerDto {
  final String memNo;
  final String profileMemNo;

  GetOtherProfileControllerDto({
    required this.memNo,
    required this.profileMemNo,
  });

  factory GetOtherProfileControllerDto.fromJson(Map<String, dynamic> json) =>
      _$GetOtherProfileControllerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetOtherProfileControllerDtoToJson(this);
}

@JsonSerializable()
class GetStyleupBattleListDto {
  final String memNo;
  final String? keyword;

  GetStyleupBattleListDto({
    required this.memNo,
    this.keyword,
  });

  factory GetStyleupBattleListDto.fromJson(Map<String, dynamic> json) =>
      _$GetStyleupBattleListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetStyleupBattleListDtoToJson(this);
}
