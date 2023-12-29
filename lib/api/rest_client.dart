import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as retro;
import 'package:showny/api/dto.dart';
import 'package:showny/api/entities/banner_response.dart';
import 'package:showny/api/entities/comment.dart';
import 'package:showny/api/entities/follow_response.dart';
import 'package:showny/api/entities/other_profile_response.dart';
import 'package:showny/api/entities/post_data_response.dart';
import 'package:showny/api/entities/profile_response.dart';
import 'package:showny/api/entities/report_type.dart';
import 'package:showny/api/entities/response.dart';
import 'package:showny/api/entities/data_response.dart';
import 'package:showny/api/entities/search_keywords_response.dart';
import 'package:showny/api/entities/style_up_battle.dart';
import 'package:showny/api/entities/style_up_response.dart';
import 'package:showny/api/entities/styleup_battle_response.dart';
import 'package:showny/api/entities/styleup_percent_response.dart';
import 'package:showny/api/entities/styleup_ranking_response.dart';
import 'package:showny/api/entities/user_data_response.dart';
import 'package:showny/api/entities/wearing_response.dart';

import 'entities/email_login_response.dart';
import 'entities/sns_login_response.dart';

part 'rest_client.g.dart';

@retro.RestApi(baseUrl: "http://api.applrdev193.godomall.com")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// 휴대폰 인증번호 전송
  @retro.POST("/VerifyPhoneNumberSend")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> verifyPhoneNumberSend(
      @retro.Body() VerifyPhoneNumberSendDto verifyPhoneNumberSendDto);

  // 휴대폰 인증
  @retro.POST("/VerifyPhoneNumber")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> verifyPhoneNumber(
      @retro.Body() VerifyPhoneNumberDto verifyPhoneNumberDto);

  // 이메일 중복 확인
  @retro.POST("/CheckDuplicateEmail")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> checkDuplicateEmail(
      @retro.Body() CheckDuplicateEmailDto checkDuplicateEmailDto);

  // 아이디 중복 확인
  @retro.POST("/CheckDuplicateId")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> checkDuplicateId(
      @retro.Body() CheckDuplicateIdDto checkDuplicateIdDto);

  // 이메일 회원가입
  @retro.POST("/SignupEmail")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> signupEmail(@retro.Body() SignupEmailDto signupEmailDto);

  // // SNS 회원가입 -> 서버 에러
  // @POST("/SignupSns")
  // Future<SNResponse> signupSns(
  //     @Body() SignupSnsDto signupSnsDto);

  // 이메일 로그인
  @retro.POST("/SigninEmail")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<EmailLoginResponse> signinEmail(
      @retro.Body() SigninEmailDto signinEmailDto);

  // SNS 로그인
  @retro.POST("/SigninSns")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SnsLoginResponse> signinSns(@retro.Body() SigninSnsDto signinSnsDto);

  // 프로필 수정
  @retro.POST("/ProfileEdit")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> profileEdit(@retro.Body() ProfileEditDto profileEditDto);

  // 키 리스트 조회
  @retro.POST("/GetHeightList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<DataResponse> getHeightList();

  // 무게 리스트 조회
  @retro.POST("/GetWeightList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<DataResponse> getWeightList();

  // 체형 리스트 조회
  @retro.POST("/GetBodyShapeList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<DataResponse> getBodyShapeList();

  // 스타일 리스트 조회
  @retro.POST("/GetStyleList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<DataResponse> getStyleList();

  // 색 리스트 조회
  @retro.POST("/GetColorList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<DataResponse> getColorList();

  // 프로필 조회
  @retro.POST("/GetProfile")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<ProfileResponse> getProfile(@retro.Body() GetProfileDto getProfileDto);

  // 비밀번호 찾기
  @retro.POST("/FindPassword")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> findPassword(
      @retro.Body() FindPasswordDto findPasswordDto);

  // 유저 팔로우
  @retro.POST("/Follow")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> userFollow(@retro.Body() UserFollowDto userFollowDto);

  // 유저 언팔로우
  @retro.POST("/Unfollow")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> userUnFollow(@retro.Body() UserFollowDto userFollowDto);

  // 스타일업 등록
  @retro.POST("/InsertStyleup")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> insertStyleup(
      @retro.Body() InsertStyleupDto insertStyleupDto);

  // 스타일업 조회
  @retro.POST("/GetStyleupList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<STUResponse> getStyleupList(
      @retro.Body() GetStyleupListDto getStyleupListDto);

  // 스타일업 삭제
  @retro.POST("/DeleteStyleup")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> deleteStyleup(
      @retro.Body() DeleteStyleupDto deleteStyleupDto);

  // GetWearingList
  @retro.POST("/GetWearingList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<WearingResponse> getWearingList(
      @retro.Body() GetWearingListDto getWearingListDto);

  // 스타일업 레포트 타입 조회
  @retro.POST("/GetStyleupReportType")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<ReportTypeResponse> getStyleupReportType();

  // 스타일업 레포트 업로드
  @retro.POST("/InsertStyleupReport")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> insertStyleupReport(
      @retro.Body() InsertStyleupReportDto insertStyleupReportDto);

  // 스타일업 레포트 댓글 업로드
  @retro.POST("/InsertStyleupComment")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> insertStyleupComment(
      @retro.Body() InsertStyleupCommentDto insertStyleupCommentDto);

  // 스타일업 레포트 댓글 삭제
  @retro.POST("/DeleteStyleupComment")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> deleteStyleupComment(
      @retro.Body() DeleteStyleupCommentDto deleteStyleupCommentDto);

  // 스타일업 레포트 댓글 좋아요
  @retro.POST("/StyleupCommentHeart")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> styleupCommentHeart(
      @retro.Body() StyleupCommentHeartDto styleupCommentHeartDto);

  // 스타일업 레포트 댓글 조회
  @retro.POST("/GetStyleupCommentList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<CommentResponse> getStyleupCommentList(
      @retro.Body() GetStyleupCommentListDto getStyleupCommentListDto);

  // 스타일업 북마크
  @retro.POST("/StyleupBookmark")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> styleupBookmark(
      @retro.Body() StyleupBookmarkDto styleupBookmarkDto);

  // 스타일업 업다운
  @retro.POST("/StyleupUpDown")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> styleupUpDown(
      @retro.Body() StyleupUpDownDto styleupUpDownDto);

  // 스타일업 배틀 업로드
  @retro.POST("/InsertStyleupBattle")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> insertStyleupBattle(
      @retro.Body() InsertStyleupBattleDto insertStyleupBattleDto);

  // 내 스타일업 조회
  @retro.POST("/GetMyStyleupList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<STUResponse> getMyStyleupList(
      @retro.Body() GetMyStyleupListDto getMyStyleupListDto);

  // 스타일업 배틀 참가 업로드
  @retro.POST("/InsertStyleupBattleParticipation")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> insertStyleupBattleParticipation(
      @retro.Body()
      InsertStyleupBattleParticipationDto insertStyleupBattleParticipationDto);

  // 스타일업 배틀 조회
  @retro.POST("/getStyleupBattleList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<BattleResponse> getStyleupBattleList(
      @retro.Body() GetStyleupBattleListDto getStyleupBattleListDto);

  // InsertStyleupCommentReport
  @retro.POST("/InsertStyleupCommentReport")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> insertStyleupCommentReport(
      @retro.Body()
      InsertStyleupCommentReportDto insertStyleupCommentReportDto);

  // SetDailyStyleupBattle
  @retro.POST("/SetDailyStyleupBattle")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> setDailyStyleupBattle();

  // GetStyleupBattleItemList
  @retro.POST("/GetStyleupBattleItemList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<StyleupBattleResponse> getStyleupBattleItemList(
      @retro.Body() GetStyleupBattleItemListDto getStyleupBattleItemListDto);

  // SelectStyleupBattleItem
  @retro.POST("/SelectStyleupBattleItem")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<StyleupPercentResponse> selectStyleupBattleItem(
      @retro.Body() SelectStyleupBattleItemDto selectStyleupBattleItemDto);

  // GetFollowStyleup
  @retro.POST("/GetFollowStyleup")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<STUResponse> getFollowStyleup(
      @retro.Body() GetFollowStyleupDto getFollowStyleupDto);

  // GetRecommendStyleup
  @retro.POST("/GetRecommendStyleup")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<STUResponse> getRecommendStyleup(
      @retro.Body() GetRecommendStyleupDto getRecommendStyleupDto);

  // GetRankingStyleup
  @retro.POST("/GetRankingStyleup")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<STURankResponse> getRankingStyleup(
      @retro.Body() GetRankingStyleupDto getRankingStyleupDto);

  // SearchUser
  @retro.POST("/SearchUser")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<UserDataResponse> searchUser(
      @retro.Body() SearchUserDto searchUserDto);

  // SearchPost
  @retro.POST("/SearchPost")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<PostDataResponse> searchPost(
      @retro.Body() SearchPostDto searchPostDto);

  // GetRecentSearchController
  @retro.POST("/GetRecentSearchController")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SearchKeywordsResponse> getRecentSearchController(
      @retro.Body() GetRecentSearchDto getRecentSearchDto);

  // InsertSearchRanking
  @retro.POST("/InsertSearchRanking")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<SNResponse> insertSearchRanking();

  // GetBannerList
  @retro.POST("/GetBannerList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<BannerResponse> getBannerList(
      @retro.Body() GetBannerListDto getBannerListDto);

  // GetFollowList
  @retro.POST("/GetFollowList")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<FollowResponse> getFollowList(
      @retro.Body() GetFollowListDto getFollowListDto);

  // GetOtherProfileController
  @retro.POST("/GetOtherProfileController")
  @retro.Headers(<String, dynamic>{
    "Content-Type": "application/x-www-form-urlencoded",
  })
  Future<OtherProfileResponse> getOtherProfileController(
      @retro.Body() GetOtherProfileControllerDto getOtherProfileControllerDto);
}
