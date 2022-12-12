import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart' as nbUtils;
import 'package:overlay_support/overlay_support.dart';
import 'package:zcart_seller/application/app/support/live_chat/conversession_provider.dart';
import 'package:zcart_seller/application/app/support/live_chat/conversession_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/support/live_chat/conversession_details_model.dart';
import 'package:zcart_seller/domain/app/support/live_chat/reply_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/support/live_chat/widgets/first_message_box.dart';

class ChatScreen extends HookConsumerWidget {
  final int id;
  final int customerId;
  final String customerName;
  final String customerAvater;

  const ChatScreen({
    Key? key,
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerAvater,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final TextEditingController messageController = useTextEditingController();

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(conversessionProvider.notifier)
            .getConversessionDetails(customerId: id);
      });

      return null;
    }, []);

    final conversession = ref.watch(
        conversessionProvider.select((value) => value.conversessionDetails));

    final loading =
        ref.watch(conversessionProvider.select((value) => value.loading));

    ref.listen<ConversessionState>(conversessionProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none()) {
          // NotificationHelper.success(message: 'tax_added'.tr());
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(customerName),
          actions: [
            IconButton(
              onPressed: () async {
                await ref
                    .read(conversessionProvider.notifier)
                    .getConversessionDetails(customerId: id);
              },
              icon: const Icon(
                Icons.sync,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              nbUtils.hideKeyboard(context);
            },
            child: Column(
              children: [
                Expanded(
                  child: _chatLoadedBody(
                    context,
                    conversession,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Column(
                    children: [
                      CupertinoTextField(
                        controller: messageController,
                        keyboardType: TextInputType.text,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: Constants.primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        placeholder: 'type_a_message'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.bold),
                        prefixMode: OverlayVisibilityMode.always,
                        textAlignVertical: TextAlignVertical.center,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        suffix: CupertinoButton(
                          borderRadius: BorderRadius.circular(2),
                          padding: EdgeInsets.zero,
                          onPressed: loading
                              ? null
                              : () {
                                  if (messageController.text.isNotEmpty) {
                                    String message =
                                        messageController.text.trim();
                                    messageController.clear();
                                    ref
                                        .read(conversessionProvider.notifier)
                                        .replyConversession(
                                          customerId: id,
                                          message: message,
                                        );
                                  } else {
                                    toast('empty_message'.tr());
                                  }
                                },
                          color: Constants.primaryColor,
                          child: loading
                              ? const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const Icon(Icons.send),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chatLoadedBody(BuildContext context,
      ConversessionDetailsModel conversessionDetailsModel) {
    List<ReplyModel> messageList = conversessionDetailsModel.replies;
    List<ReplyModel> reversedMessageList = messageList.reversed.toList();
    return Container(
      child: conversessionDetailsModel.replies.isEmpty
          ? Column(
              children: [
                FirstMessageBox(
                  conversessionDetailsModel: conversessionDetailsModel,
                ),
                const Expanded(child: SizedBox()),
              ],
            )
          : ListView(
              shrinkWrap: true,
              reverse: true,
              children: reversedMessageList.map((message) {
                return Column(
                  children: [
                    Visibility(
                      visible: messageList.indexOf(message) == 0,
                      child: FirstMessageBox(
                        conversessionDetailsModel: conversessionDetailsModel,
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, bottom: 5),
                      child: Align(
                        alignment: (message.customer == null
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          constraints: BoxConstraints(
                              maxWidth: ScreenUtil().screenWidth * 0.75),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (message.customer == null
                                ? Constants.kDarkCardBgColor
                                : Constants.primaryColor),
                          ),
                          child: Column(
                            crossAxisAlignment: message.customer == null
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              HtmlWidget(
                                message.reply,
                                textStyle: const TextStyle(color: Colors.white),
                                onTapUrl: (url) {
                                  return true;
                                },
                              ),
                              const SizedBox(height: 5),
                              message.customer != null
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(message.updatedAt,
                                            style:
                                                const TextStyle(fontSize: 10)),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          message.read == null
                                              ? Icons.watch_later_outlined
                                              : Icons.check,
                                          size: 14,
                                        )
                                      ],
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          message.read == null
                                              ? Icons.watch_later_outlined
                                              : Icons.check,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          message.updatedAt,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
    );
  }
}
