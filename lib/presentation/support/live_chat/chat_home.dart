import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/support/live_chat/conversession_provider.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:zcart_seller/presentation/support/live_chat/chat_screen.dart';

class ChatHome extends HookConsumerWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(conversessionProvider.notifier).getAllConversessions();
      });

      return null;
    }, []);

    final conversessions = ref.watch(
        conversessionProvider.select((value) => value.conversessionList));

    final loading =
        ref.watch(conversessionProvider.select((value) => value.loading));

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.message),
        title: Text('messages'.tr()),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(conversessionProvider.notifier).getAllConversessions();
              },
              icon: const Icon(Icons.sync))
        ],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : conversessions.isEmpty
              ? const NoItemFound()
              : RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .refresh(conversessionProvider.notifier)
                        .getAllConversessions();
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    physics: const BouncingScrollPhysics(),
                    itemCount: conversessions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  id: conversessions[index].id,
                                  customerId: conversessions[index].customer.id,
                                  customerName:
                                      conversessions[index].customer.name,
                                  customerAvater:
                                      conversessions[index].customer.avatar,
                                ),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            radius: 15,
                            child: Image(
                              image: NetworkImage(
                                conversessions[index].customer.avatar,
                              ),
                            ),
                          ),
                          title: Text(conversessions[index].customer.name),
                          subtitle: Text(
                            conversessions[index].message,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 3.h,
                    ),
                  ),
                ),
    );
  }
}
