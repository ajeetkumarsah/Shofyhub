import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:zcart_seller/domain/app/support/live_chat/conversession_details_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

class FirstMessageBox extends StatelessWidget {
  final ConversessionDetailsModel conversessionDetailsModel;
  const FirstMessageBox({
    Key? key,
    required this.conversessionDetailsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.kGreenColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: conversessionDetailsModel.subject == null,
            child: Text(
              "${conversessionDetailsModel.subject ?? "Hello"}",
              style: Theme.of(context).textTheme.caption!,
            ),
          ),
          HtmlWidget(
            conversessionDetailsModel.message,
            onTapUrl: (url) {
              // launchURL(url);
              return true;
            },
            textStyle: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
