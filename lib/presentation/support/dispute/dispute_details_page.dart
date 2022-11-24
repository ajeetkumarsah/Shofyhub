import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/dispute/dispute_provider.dart';
import 'package:zcart_seller/domain/app/shop/delivery%20boy/delivary_boy_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/core/widgets/info_tile.dart';
import 'package:zcart_seller/presentation/core/widgets/loading_widget.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/widgets/add_update_delivary_boy_page.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/widgets/delete_delivery_boy_dialog.dart';
import 'package:zcart_seller/presentation/support/dispute/dispute_response_dialog.dart';

class DisputeDetailsPage extends HookConsumerWidget {
  final int disputeId;
  const DisputeDetailsPage({Key? key, required this.disputeId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref
            .read(disputeProvider.notifier)
            .getDisputeDetails(dispiteId: disputeId);
      });
      return null;
    }, []);

    final loading = ref.watch(disputeProvider.select((value) => value.loading));
    final disputeDetails =
        ref.watch(disputeProvider.select((value) => value.disputeDetails));

    return Scaffold(
      appBar: AppBar(
        title: Text(loading ? '....' : disputeDetails.reason),
      ),
      body: loading
          ? const LoadingWidget()
          : ListView(
              children: [
                SizedBox(height: 10.h),
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(disputeDetails.customer.avatar)),
                  title: Text(disputeDetails.customer.name),
                ),
                const Divider(),
                SizedBox(height: 10.h),
                InfoTile(title: 'status'.tr(), value: disputeDetails.status),
                SizedBox(height: 10.h),
                InfoTile(title: 'reason'.tr(), value: disputeDetails.reason),
                SizedBox(height: 10.h),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: HtmlWidget(disputeDetails.description),
                  ),
                ),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'refund_amount'.tr(),
                    value: disputeDetails.refundAmount),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.buttonColor),
                    onPressed: loading
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => DisputeResponseDialog(
                                disputeId: disputeId,
                              ),
                            );
                          },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50.h,
                      child: Center(
                        child: loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : Text(
                                'response'.tr(),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
