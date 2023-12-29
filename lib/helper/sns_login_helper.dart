import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SnsLoginHelper {
  
  static void kakaoLogin(Function(String) success) async {
    // 카카오톡 실행 가능 여부 확인
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    var isKakaoLoginSuccess = false;

    if (await isKakaoTalkInstalled()) {
      try {
          await UserApi.instance.loginWithKakaoTalk();
          debugPrint('카카오톡으로 로그인 성공');
          isKakaoLoginSuccess = true;
      } catch (error) {
        debugPrint('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
            await UserApi.instance.loginWithKakaoAccount();
            debugPrint('카카오계정으로 로그인 성공');
            isKakaoLoginSuccess = true;
        } catch (error) {
            debugPrint('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        debugPrint('카카오계정으로 로그인 성공');
        isKakaoLoginSuccess = true;
      } catch (error) {
        debugPrint('카카오계정으로 로그인 실패 $error');
      }
    }

    if(isKakaoLoginSuccess == true) {
      try {
        var user = await UserApi.instance.me();
        var userId = user.id;
        success(userId.toString());
      } catch (error) {
        // print('사용자 정보 요청 실패 $error');
      }
    }
  }

  static void naverLogin(Function(String) success) async {
    try{
      final NaverLoginResult user = await FlutterNaverLogin.logIn();
      NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;

      String email = user.account.email;
      String name = user.account.name;
      String tel = user.account.mobile
          .replaceAll('+82', '0')
          .replaceAll('-', '')
          .replaceAll(' ', '')
          .replaceAll('+', '');
      String sex = user.account.gender;
      String socialNo = '${user.account.birthyear}${user.account.birthday}'.replaceAll('-', '');
      String userId = user.account.id.toString();
      if(userId != "") {
        success(userId.toString());
        debugPrint('$email,$name,$tel,$sex,$socialNo, $userId');
      }
    }catch(error){
      debugPrint('naver login error $error');
    }

  }

  static void googleLogin(Function(String) success) async {

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    if(userCredential.user != null) {
      String userId = userCredential.user!.uid;
      if(userId != "") {
        success(userId.toString());
      }
    }
  }

  static void appleLogin(Function(String) success) async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    try {
      var userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      if(userCredential.user != null) {
        String userId = userCredential.user!.uid;
        if(userId != "") {
          success(userId.toString());
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
   
  }
}