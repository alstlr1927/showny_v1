import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/main/root_screen.dart';
import 'package:showny/screens/upload/battle/battle_upload_screen.dart';
import 'package:showny/screens/upload/battle/models/battle_upload_model.dart';

import '../../../intro/components/showny_dialog.dart';

class BattleUploadProvider with ChangeNotifier {
  State<BattleUploadScreen> state;

  late BattleUploadModel uploadModel;

  void setUploadModel(BattleUploadModel model) {
    uploadModel = model;
    notifyListeners();
  }

  void handleBattleUpload() {
    if (uploadModel.battle == null ||
        uploadModel.styleup == null ||
        uploadModel.thumbNailFile == null) {
      return;
    }

    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    ApiHelper.shared.insertStyleupBattleParticipation(
        uploadModel.thumbNailFile?.path ?? '',
        uploadModel.battle?.styleupBattleNo,
        uploadModel.styleup?.styleupNo,
        user.memNo, (success) {
      showDialog(
        context: state.context,
        builder: (BuildContext context) {
          return const ShownyDialog(
            message: '배틀 신청이 완료되었습니다.',
            primaryLabel: '확인',
          );
        },
      ).then((value) {
        ShownyRouter().replaceMain(state.context);
      });
    }, (error) {
      debugPrint(error);
    });
  }

  Future showExitDialog(BuildContext ctx) async {
    showDialog(
      context: ctx,
      builder: (context) => ShownyDialog(
        message: '메인화면으로 나가시겠습니까?',
        primaryLabel: '확인',
        primaryAction: () {
          return true;
        },
      ),
    ).then((value) {
      if (value ?? false) {
        ShownyRouter().replaceMain(ctx);
      }
    });
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  BattleUploadProvider(this.state) {
    uploadModel = state.widget.uploadSample.copyWith();
  }
}
