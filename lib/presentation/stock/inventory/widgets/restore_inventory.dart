 
// import 'package:clean_api/clean_api.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:zcart_seller/application/app/stocks/inventories/inventories_provider.dart';
// import 'package:zcart_seller/application/app/stocks/inventories/inventories_state.dart';
// import 'package:zcart_seller/application/core/notification_helper.dart';

// class RestoreInventory extends HookConsumerWidget {
//   final int inventoryId;
//   const RestoreInventory({Key? key, required this.inventoryId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context, ref) {
//     ref.listen<InventoriesState>(stockeInventoryProvider, (previous, next) {
//       if (previous != next && !next.loading) {
//         Navigator.of(context).pop();
//         if (next.failure == CleanFailure.none()) {
//           NotificationHelper.success(message: 'item_restored'.tr());
          
//         } else if (next.failure != CleanFailure.none()) {
//           NotificationHelper.error(message: next.failure.error);

         
//         }
//       }
//     });
//     final loading =
//         ref.watch(stockeInventoryProvider.select((value) => value.loading));
//     return AlertDialog(
//       titlePadding: EdgeInsets.zero,
//       title: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Restore Inventory',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   padding: EdgeInsets.zero,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.close,
//                     size: 30.h,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Divider(
//             height: 1,
//             thickness: 1,
//           ),
//         ],
//       ),
//       contentPadding: EdgeInsets.zero,
//       content: const Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Text('Are you sure you want to restore this Inventory?'),
//       ),
//       actions: [
//         const Divider(
//           height: 1,
//           thickness: 1,
//         ),
//         SizedBox(
//           height: 15.h,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(),
//             Padding(
//               padding: EdgeInsets.only(right: 25.w),
//               child: Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       height: 40.h,
//                       width: 85.w,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5.sp),
//                         border: Border.all(
//                           color: Theme.of(context).shadowColor.withOpacity(.5),
//                         ),
//                       ),
//                       child: const Center(
//                         child: Text('Cancel'),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15.w,
//                   ),
//                   SizedBox(
//                     height: 40.h,
//                     width: 85.w,
//                     child: ElevatedButton(
//                       style: OutlinedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.r),
//                         ),
//                       ),
//                       onPressed: () {
//                         ref
//                             .read(stockeInventoryProvider.notifier)
//                             .restoreInventory(inventoryId);
//                       },
//                       child: loading
//                           ? const Center(
//                               child: SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                   )),
//                             )
//                           : Text(
//                               "Restore",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Theme.of(context).canvasColor,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 10.h,
//         )
//       ],
//     );
//   }
// }
