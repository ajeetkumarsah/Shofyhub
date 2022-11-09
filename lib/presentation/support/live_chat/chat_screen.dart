import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/support/live_chat/conversession_provider.dart';
import 'package:zcart_seller/domain/app/support/live_chat/conversation_model.dart';
import 'package:zcart_seller/domain/app/support/live_chat/reply_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

class ChatScreen extends HookConsumerWidget {
  final int? shopId;
  final String? shopImage;
  final String? shopName;
  final String? shopVerifiedText;

  const ChatScreen({
    Key? key,
    required this.shopId,
    required this.shopImage,
    required this.shopName,
    required this.shopVerifiedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final TextEditingController messageController = useTextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  const BackButton(),

                  const SizedBox(width: 20),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Image(
                      image: NetworkImage(shopImage!),
                    ),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          shopName!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          shopVerifiedText!,
                          style: Theme.of(context).textTheme.caption!,
                        ),
                      ],
                    ),
                  ),
                  //Icon(Icons.settings, color: kDarkColor54),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await ref
                      .read(conversessionProvider.notifier)
                      .getAllConversessions();
                },
                icon: const Icon(
                  Icons.sync,
                )),
          ],
        ),
        body: SafeArea(child: _chatBody(context, ref)),
      ),
    );
  }

  Widget _chatBody(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // hideKeyboard(context);
      },
      child: Column(
        children: [
          Expanded(
            child: _chatLoadedBody(
              context, ref.read(conversessionProvider).conversessionDetails,

              // Consumer(builder: (context, watch, _) {
              //   final _productChatState = watch(productChatProvider);
              //   return _productChatState is ProductChatInitialLoadedState
              //       ? Center(
              //           child: Text(
              //             _productChatState.productChatModel.message!,
              //             textAlign: TextAlign.center,
              //           ),
              //         )
              //       : _productChatState is ProductChatLoadedState
              //           ? _chatLoadedBody(context, _productChatState)
              //           : const LoadingWidget();
              // }),
            ),
          ),
          _chatTextBox(context),
        ],
      ),
    );
  }

  Padding _chatTextBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          // _attachment.isNotEmpty
          //     ? _attachmentsWidget(context)
          //     : const SizedBox(),
          CupertinoTextField(
            // controller: messageController,
            keyboardType: TextInputType.text,
            decoration: BoxDecoration(
              // border: Border.all(width: 2, color: kAccentColor),
              borderRadius: BorderRadius.circular(10),
              // color: getColorBasedOnTheme(context, kLightColor, kDarkBgColor),
            ),
            placeholder: 'type_a_message'.tr(),
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.bold),
            prefixMode: OverlayVisibilityMode.always,
            textAlignVertical: TextAlignVertical.center,
            padding: const EdgeInsets.only(right: 16),
            prefix: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                // final _file = await pickImageToBase64();

                // if (_file != null) {
                //   _attachment = _file;

                //   setState(() {});
                // }
              },
              child: const Icon(Icons.add_photo_alternate),
            ),
            suffix: CupertinoButton(
              borderRadius: BorderRadius.circular(2),
              padding: EdgeInsets.zero,
              onPressed: () {
                // if (_messageController.text.isNotEmpty) {
                //   String message = _messageController.text.trim();
                //   _messageController.clear();
                //   context
                //       .read(productChatSendProvider.notifier)
                //       .sendMessage(
                //         widget.shopId,
                //         message,
                //         photo: _attachment.isNotEmpty ? _attachment : null,
                //       )
                //       .then(
                //     (value) {
                //       _messageController.clear();
                //       _attachment = "";
                //       setState(() {});
                //       context
                //           .read(productChatProvider.notifier)
                //           .productConversation(widget.shopId, update: true);
                //     },
                //   );
                // } else {
                //   toast(LocaleKeys.empty_message.tr());
                // }
              },
              color: Constants.primaryColor,
              child: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatLoadedBody(
      BuildContext context, ConversessionModel conversessionModel) {
    List<ReplyModel> _messageList = conversessionModel.replies;
    List<ReplyModel> _reversedMessageList = _messageList.reversed.toList();
    return Container(
      child: conversessionModel.replies.isEmpty
          ? Column(
              children: [
                FirstMessageBox(
                  conversessionModel: conversessionModel,
                ),
                const Expanded(child: SizedBox()),
              ],
            )
          : ListView(
              shrinkWrap: true,
              reverse: true,
              children: _reversedMessageList.map((message) {
                return Column(
                  children: [
                    Visibility(
                      visible: _messageList.indexOf(message) == 0,
                      child: FirstMessageBox(
                        conversessionModel: conversessionModel,
                      ),
                    ),
                    // Container(
                    //   padding:
                    //       const EdgeInsets.only(left: 16, right: 16, bottom: 5),
                    //   child: Align(
                    //     alignment: (message.customer == null
                    //         ? Alignment.topLeft
                    //         : Alignment.topRight),
                    //     child: Container(
                    //       constraints: BoxConstraints(
                    //           maxWidth: context.screenWidth * 0.75),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: (message.customer == null
                    //             ? getColorBasedOnTheme(context,
                    //                 Colors.grey.shade200, kDarkCardBgColor)
                    //             : kPrimaryColor.withOpacity(0.1)),
                    //       ),
                    //       padding: const EdgeInsets.all(16),
                    //       child: Column(
                    //         crossAxisAlignment: message.customer == null
                    //             ? CrossAxisAlignment.start
                    //             : CrossAxisAlignment.end,
                    //         children: [
                    //           message.attachments!.isEmpty
                    //               ? const SizedBox()
                    //               : GestureDetector(
                    //                   onTap: () {
                    //                     Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                         builder: (context) =>
                    //                             ImageViewerPage(
                    //                           imageUrl: API.appUrl +
                    //                               "/image/" +
                    //                               message.attachments![0]
                    //                                   ["path"],
                    //                           title: "Image Viewer",
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                   child: Container(
                    //                     height: 120,
                    //                     padding: const EdgeInsets.all(2),
                    //                     margin:
                    //                         const EdgeInsets.only(bottom: 5),
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(10),
                    //                     ),
                    //                     child: ClipRRect(
                    //                       borderRadius:
                    //                           BorderRadius.circular(10),
                    //                       child: CachedNetworkImage(
                    //                         imageUrl: API.appUrl +
                    //                             "/image/" +
                    //                             message.attachments![0]["path"],
                    //                         fit: BoxFit.cover,
                    //                         errorWidget:
                    //                             (context, url, error) =>
                    //                                 const SizedBox(),
                    //                         placeholder: (context, url) =>
                    //                             const SizedBox(
                    //                           height: 50,
                    //                           width: 50,
                    //                           child: Center(
                    //                             child:
                    //                                 CircularProgressIndicator(),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //           // HtmlWidget(
                    //           //   message.reply!,
                    //           //   onTapUrl: (url) {
                    //           //     launchURL(url);
                    //           //     return true;
                    //           //   },
                    //           // ),
                    //           const SizedBox(height: 5),
                    //           message.customer != null
                    //               ? Row(
                    //                   mainAxisSize: MainAxisSize.min,
                    //                   children: [
                    //                     Text(message.updatedAt!,
                    //                         style:
                    //                             const TextStyle(fontSize: 10)),
                    //                     const SizedBox(
                    //                       width: 5,
                    //                     ),
                    //                     Icon(
                    //                       message.read == null
                    //                           ? Icons.watch_later_outlined
                    //                           : Icons.check,
                    //                       size: 14,
                    //                     )
                    //                   ],
                    //                 )
                    //               : Row(
                    //                   mainAxisSize: MainAxisSize.min,
                    //                   children: [
                    //                     Icon(
                    //                       message.read == null
                    //                           ? Icons.watch_later_outlined
                    //                           : Icons.check,
                    //                       size: 14,
                    //                     ),
                    //                     const SizedBox(width: 5),
                    //                     Text(
                    //                       message.updatedAt!,
                    //                       style: const TextStyle(fontSize: 10),
                    //                     ),
                    //                   ],
                    //                 ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              }).toList(),
            ),
    );
  }
}

class FirstMessageBox extends StatelessWidget {
  final ConversessionModel conversessionModel;
  const FirstMessageBox({
    Key? key,
    required this.conversessionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: conversessionModel.subject != null,
              child: Text(
                "${conversessionModel.subject ?? "Hello"}",
                style: Theme.of(context).textTheme.caption!,
              )),
          // HtmlWidget(
          //   productChatModel.data!.message!,
          //   onTapUrl: (url) {
          //     launchURL(url);
          //     return true;
          //   },
          //   textStyle: const TextStyle(color: kPrimaryLightTextColor),
          // ).paddingBottom(5),
          // Visibility(
          //   visible: productChatModel.data!.attachments!.isNotEmpty,
          //   child: productChatModel.data!.attachments!.isEmpty
          //       ? const SizedBox()
          //       : GestureDetector(
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => ImageViewerPage(
          //                   imageUrl: API.appUrl +
          //                       "/image/" +
          //                       productChatModel.data!.attachments![0]["path"],
          //                   title: productChatModel.data!.subject ?? "Hello",
          //                 ),
          //               ),
          //             );
          //           },
          //           child: Container(
          //             height: 120,
          //             padding: const EdgeInsets.all(2),
          //             margin: const EdgeInsets.only(bottom: 5),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             child: ClipRRect(
          //               borderRadius: BorderRadius.circular(10),
          //               child: CachedNetworkImage(
          //                 imageUrl: API.appUrl +
          //                     "/image/" +
          //                     productChatModel.data!.attachments![0]["path"],
          //                 fit: BoxFit.cover,
          //                 errorWidget: (context, url, error) =>
          //                     const SizedBox(),
          //                 placeholder: (context, url) => const SizedBox(
          //                   height: 50,
          //                   width: 50,
          //                   child: Center(
          //                     child: CircularProgressIndicator(),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          // ),
        ],
      ),
    );
  }
}
