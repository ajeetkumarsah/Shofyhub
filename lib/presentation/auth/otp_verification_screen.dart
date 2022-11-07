import 'package:argon_buttons_flutter_fix/argon_buttons_flutter.dart';
import 'package:clean_api/models/clean_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/auth/auth_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/auth/user_model.dart';
import 'package:zcart_seller/presentation/app/dashboard/dashboard_home.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_button.dart';

class OTPVerificationScreen extends HookConsumerWidget {
  const OTPVerificationScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  final String phone;

  @override
  Widget build(BuildContext context, ref) {
    final loading = ref.watch(authProvider.select((value) => value.loading));

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.user != UserModel.init()) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const DashboardHome(),
            ),
            (Route<dynamic> route) => false,
          );
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'verify_your_phone'.tr(),
      )),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'verify_your_phone'.tr(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color.fromRGBO(13, 13, 30, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'sent_you_a_code'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromRGBO(13, 13, 30, 1),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    phone,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromRGBO(13, 13, 30, 1),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: PinCodeTextField(
                      // autoDisposeControllers: false,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      length: 6,
                      animationType: AnimationType.fade,
                      hintStyle: const TextStyle(color: Colors.red),
                      scrollPadding: const EdgeInsets.all(0),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 56,
                        fieldWidth: 55,
                        activeColor: Colors.white,
                        inactiveColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        selectedColor: Colors.black12,
                        activeFillColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      // errorAnimationController: authNotifier.errorController,
                      // controller: _pinController,
                      onCompleted: (pin) async {
                        ref
                            .read(authProvider.notifier)
                            .otpVerify(phone: phone, code: pin);
                      },
                      onChanged: (value) {},
                      beforeTextPaste: (text) {
                        return true;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  KButton(
                    onPressed: () async {},
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Sign up"),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    child: ArgonTimerButton(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      initialTimer: 60,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      minWidth: MediaQuery.of(context).size.width,
                      elevation: 0,
                      borderRadius: 30.0,
                      child: Text(
                        'resend_code'.tr(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      loader: (timeLeft) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'didnt_get_a_code'.tr(),
                            ),
                            const SizedBox(width: 5),
                            Text("RESEND IN  $timeLeft s"),
                          ],
                        );
                      },
                      onTap: (startTimer, btnState) async {
                        if (btnState == ButtonState.Idle) {
                          ref
                              .read(authProvider.notifier)
                              .otpLogin(phone: phone);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
