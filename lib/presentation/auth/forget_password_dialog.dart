import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/auth/auth_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/presentation/auth/widgets/forget_password_confirmation.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class ForgetPasswordDialog extends HookConsumerWidget {
  const ForgetPasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final emailController = useTextEditingController();
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          showDialog(
              context: context,
              builder: (context) => const ForgetPasswordConfirmation());
          // CherryToast.info(
          //   title: const Text('The password reset link sent!'),
          //   animationType: AnimationType.fromTop,
          // ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
          // CherryToast.error(
          //   title: Text(
          //     next.failure.error,
          //   ),
          //   toastPosition: Position.bottom,
          // ).show(context);
        }
      }
    });
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final loading = ref.watch(authProvider.select((value) => value.loading));
    return AlertDialog(
      title: const Text('Forget Password'),
      insetPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please enter your email'),
              SizedBox(height: 20.h, width: 300.w),
              KTextField(
                controller: emailController,
                lebelText: 'Email *',
                validator: (text) => ValidatorLogic.requiredEmail(text),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              ref
                  .read(authProvider.notifier)
                  .forgetPassword(email: emailController.text);
            }
          },
          child:
              loading ? const CircularProgressIndicator() : const Text('Send'),
        ),
      ],
    );
  }
}
