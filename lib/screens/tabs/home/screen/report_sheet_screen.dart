import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/report_type_model.dart';
import 'package:showny/screens/common/components/sv_button.dart';

class ReportSheetScreen extends StatefulWidget {
  const ReportSheetScreen({super.key, required this.onCompleted});

  final Function(int type) onCompleted;

  @override
  State<ReportSheetScreen> createState() => _ReportSheetScreenState();
}

class _ReportSheetScreenState extends State<ReportSheetScreen> {
  List<ReportTypeModel> reportTypeList = [];

  int selectedOption = 0;

  Widget reportOption(
      {required int type, required String title, required String description}) {
    var isSelected = (selectedOption == type);

    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.5),
      pressedOpacity: 1.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isSelected)
            Image.asset(
              'assets/icons/check_circle.png',
              width: 16.0,
              height: 16.0,
            )
          else
            Container(
              width: 16.0,
              height: 16.0,
              decoration: const ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Constants.defaultTextStyle),
              const SizedBox(height: 6.0),
              Text(
                description,
                style: Constants.textFieldErrorStyle.copyWith(fontSize: 10.0),
              ),
            ],
          )
        ],
      ),
      onPressed: () {
        setState(() => selectedOption = type);
      },
    );
  }

  @override
  void initState() {
    ApiHelper.shared.getStyleupReportType(
      (getReportTypeList){
        setState(() => reportTypeList = getReportTypeList);
        debugPrint(
            'DEBUG: get styleup report type succeed, report types: $reportTypeList');
      }, 
      (error){
        debugPrint('DEBUG: get styleup report type failed');
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text('신고하기', style: Constants.appBarTitleStyle),
                CupertinoButton(
                  minSize: 0.0,
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    'assets/icons/x_mark.png',
                    width: 24.0,
                    height: 24.0,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          const SizedBox(height: 13.0),
          Text(
            '신고 사유 선택를 선택해 주세요.',
            textAlign: TextAlign.center,
            style: Constants.textFieldErrorStyle,
          ),
          const SizedBox(height: 17.5),
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reportTypeList.length,
              itemBuilder: (context, index) {
                final type = reportTypeList[index];

                return reportOption(
                  type: index,
                  title: type.title,
                  description: type.description,
                );
              },
            ),
          ),
          const SizedBox(height: 26.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SVButton(
              title: '신고',
              titleColor: Colors.white,
              backgroundColor: Colors.black,
              onPressed: () {
                widget.onCompleted(selectedOption);
                // Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
