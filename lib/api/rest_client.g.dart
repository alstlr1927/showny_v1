// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://api.applrdev193.godomall.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SNResponse> verifyPhoneNumberSend(
      VerifyPhoneNumberSendDto verifyPhoneNumberSendDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(verifyPhoneNumberSendDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/VerifyPhoneNumberSend',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> verifyPhoneNumber(
      VerifyPhoneNumberDto verifyPhoneNumberDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(verifyPhoneNumberDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/VerifyPhoneNumber',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> checkDuplicateEmail(
      CheckDuplicateEmailDto checkDuplicateEmailDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(checkDuplicateEmailDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/CheckDuplicateEmail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> checkDuplicateId(
      CheckDuplicateIdDto checkDuplicateIdDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(checkDuplicateIdDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/CheckDuplicateId',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> signupEmail(SignupEmailDto signupEmailDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(signupEmailDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/SignupEmail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EmailLoginResponse> signinEmail(SigninEmailDto signinEmailDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(signinEmailDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EmailLoginResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/SigninEmail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = EmailLoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SnsLoginResponse> signinSns(SigninSnsDto signinSnsDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(signinSnsDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SnsLoginResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/SigninSns',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SnsLoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> profileEdit(ProfileEditDto profileEditDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(profileEditDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/ProfileEdit',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DataResponse> getHeightList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetHeightList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DataResponse> getWeightList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetWeightList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DataResponse> getBodyShapeList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetBodyShapeList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DataResponse> getStyleList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetStyleList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DataResponse> getColorList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DataResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetColorList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProfileResponse> getProfile(GetProfileDto getProfileDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getProfileDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ProfileResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetProfile',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ProfileResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> findPassword(FindPasswordDto findPasswordDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(findPasswordDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/FindPassword',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> userFollow(UserFollowDto userFollowDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(userFollowDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/Follow',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> userUnFollow(UserFollowDto userFollowDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(userFollowDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/Unfollow',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> insertStyleup(InsertStyleupDto insertStyleupDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(insertStyleupDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/InsertStyleup',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<STUResponse> getStyleupList(
      GetStyleupListDto getStyleupListDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getStyleupListDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<STUResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetStyleupList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = STUResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> deleteStyleup(DeleteStyleupDto deleteStyleupDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(deleteStyleupDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/DeleteStyleup',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WearingResponse> getWearingList(
      GetWearingListDto getWearingListDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getWearingListDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<WearingResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetWearingList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = WearingResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReportTypeResponse> getStyleupReportType() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ReportTypeResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetStyleupReportType',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ReportTypeResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> insertStyleupReport(
      InsertStyleupReportDto insertStyleupReportDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(insertStyleupReportDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/InsertStyleupReport',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> insertStyleupComment(
      InsertStyleupCommentDto insertStyleupCommentDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(insertStyleupCommentDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/InsertStyleupComment',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> deleteStyleupComment(
      DeleteStyleupCommentDto deleteStyleupCommentDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(deleteStyleupCommentDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/DeleteStyleupComment',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> styleupCommentHeart(
      StyleupCommentHeartDto styleupCommentHeartDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(styleupCommentHeartDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/StyleupCommentHeart',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommentResponse> getStyleupCommentList(
      GetStyleupCommentListDto getStyleupCommentListDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getStyleupCommentListDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CommentResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetStyleupCommentList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CommentResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> styleupBookmark(
      StyleupBookmarkDto styleupBookmarkDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(styleupBookmarkDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/StyleupBookmark',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> styleupUpDown(StyleupUpDownDto styleupUpDownDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(styleupUpDownDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/StyleupUpDown',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> insertStyleupBattle(
      InsertStyleupBattleDto insertStyleupBattleDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(insertStyleupBattleDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/InsertStyleupBattle',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<STUResponse> getMyStyleupList(
      GetMyStyleupListDto getMyStyleupListDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getMyStyleupListDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<STUResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetMyStyleupList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = STUResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> insertStyleupBattleParticipation(
      InsertStyleupBattleParticipationDto
          insertStyleupBattleParticipationDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(insertStyleupBattleParticipationDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/InsertStyleupBattleParticipation',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BattleResponse> getStyleupBattleList(
      GetStyleupBattleListDto getStyleupBattleListDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getStyleupBattleListDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BattleResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/getStyleupBattleList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BattleResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> insertStyleupCommentReport(
      InsertStyleupCommentReportDto insertStyleupCommentReportDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(insertStyleupCommentReportDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/InsertStyleupCommentReport',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> setDailyStyleupBattle() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/SetDailyStyleupBattle',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StyleupBattleResponse> getStyleupBattleItemList(
      GetStyleupBattleItemListDto getStyleupBattleItemListDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getStyleupBattleItemListDto.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StyleupBattleResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetStyleupBattleItemList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = StyleupBattleResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StyleupPercentResponse> selectStyleupBattleItem(
      SelectStyleupBattleItemDto selectStyleupBattleItemDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(selectStyleupBattleItemDto.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StyleupPercentResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/SelectStyleupBattleItem',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = StyleupPercentResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<STUResponse> getFollowStyleup(
      GetFollowStyleupDto getFollowStyleupDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getFollowStyleupDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<STUResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetFollowStyleup',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = STUResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<STUResponse> getRecommendStyleup(
      GetRecommendStyleupDto getRecommendStyleupDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getRecommendStyleupDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<STUResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetRecommendStyleup',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = STUResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<STURankResponse> getRankingStyleup(
      GetRankingStyleupDto getRankingStyleupDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getRankingStyleupDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<STURankResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetRankingStyleup',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = STURankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserDataResponse> searchUser(SearchUserDto searchUserDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(searchUserDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserDataResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/SearchUser',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UserDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostDataResponse> searchPost(SearchPostDto searchPostDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(searchPostDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PostDataResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/SearchPost',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PostDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchKeywordsResponse> getRecentSearchController(
      GetRecentSearchDto getRecentSearchDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getRecentSearchDto.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchKeywordsResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetRecentSearchController',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SearchKeywordsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SNResponse> insertSearchRanking() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SNResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/InsertSearchRanking',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SNResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BannerResponse> getBannerList(
      GetBannerListDto getBannerListDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getBannerListDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BannerResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetBannerList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BannerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowResponse> getFollowList(
      GetFollowListDto getFollowListDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getFollowListDto.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FollowResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetFollowList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = FollowResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OtherProfileResponse> getOtherProfileController(
      GetOtherProfileControllerDto getOtherProfileControllerDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/x-www-form-urlencoded'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(getOtherProfileControllerDto.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OtherProfileResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/GetOtherProfileController',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = OtherProfileResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
