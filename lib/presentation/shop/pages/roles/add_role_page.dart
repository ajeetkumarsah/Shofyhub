import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/roles/permission_provider.dart';
import 'package:zcart_seller/application/app/shop/roles/role_provider.dart';
import 'package:zcart_seller/application/app/shop/roles/roles_state.dart';
import 'package:zcart_seller/domain/app/shop/roles/create_update_role_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class AddRolePage extends HookConsumerWidget {
  const AddRolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final nameController = useTextEditingController();
    final levelController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final formkey = useMemoized(() => GlobalKey<FormState>());

    final permissionList =
        ref.watch(roleProvider.select((value) => value.permissionList));
    final permissionNotifier = ref.watch(permissionProvider);

    final loading = ref.watch(roleProvider.select((value) => value.loading));
    final buttonPressed = useState(false);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        permissionNotifier.selectedPermissionIds.clear();
      });
      return null;
    }, []);

    ref.listen<RolesState>(roleProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          CherryToast.info(
            title: Text('role_added'.tr()),
            animationType: AnimationType.fromTop,
          ).show(context);
          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none() && buttonPressed.value) {
          CherryToast.error(
            title: Text(
              next.failure.error,
            ),
            toastPosition: Position.bottom,
          ).show(context);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Add Role'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                KTextField(
                  controller: nameController,
                  lebelText: '${'name'.tr()} *',
                  validator: (text) => ValidatorLogic.requiredField(text,
                      fieldName: 'name'.tr()),
                ),
                SizedBox(height: 10.h),
                KTextField(
                  controller: levelController,
                  lebelText: 'level'.tr(),
                  numberFormatters: true,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 10.h,
                ),
                KMultiLineTextField(
                  controller: descriptionController,
                  lebelText: 'description'.tr(),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 10.h,
                ),
                RefreshIndicator(
                  onRefresh: () {
                    return ref.read(roleProvider.notifier).getPermissions();
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    itemCount: permissionList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            permissionList[index].name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: permissionList[index]
                                .permissions
                                .map((e) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e.name),
                                        Checkbox(
                                            value: permissionNotifier
                                                .selectedPermissionIds
                                                .contains(e.id),
                                            onChanged: (value) {
                                              permissionNotifier
                                                      .selectedPermissionIds
                                                      .contains(e.id)
                                                  ? permissionNotifier
                                                      .removeId(e.id)
                                                  : permissionNotifier
                                                      .addId(e.id);
                                            }),
                                      ],
                                    ))
                                .toList(),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 3.h,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Constants.buttonColor),
                  onPressed: loading
                      ? null
                      : () {
                          if (formkey.currentState?.validate() ?? false) {
                            final roleModel = CreateUpdateRoleModel(
                              name: nameController.text,
                              description: descriptionController.text,
                              level: int.tryParse(levelController.text)!,
                              permissions:
                                  permissionNotifier.selectedPermissionIds,
                            );
                            ref
                                .read(roleProvider.notifier)
                                .createNewRole(roleModel: roleModel);
                            buttonPressed.value = true;
                          }
                        },
                  child: loading
                      ? const Center(
                          child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                        )
                      : SizedBox(
                          height: 50.h,
                          width: ScreenUtil().screenWidth,
                          child: Center(child: Text('add'.tr())),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
