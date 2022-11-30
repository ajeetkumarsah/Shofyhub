import 'dart:developer';

import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/subcroption_plan_provider.dart';
import 'package:zcart_seller/application/app/plugin/plugin_provider.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/auth/auth_state.dart';
import 'package:zcart_seller/application/auth/country_code_provider.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/auth/log_in_body.dart';
import 'package:zcart_seller/domain/auth/user_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/app/dashboard/dashboard_home.dart';
import 'package:zcart_seller/presentation/auth/forget_password_dialog.dart';
import 'package:zcart_seller/presentation/auth/otp_verification_screen.dart';
import 'package:zcart_seller/presentation/auth/signup_screen.dart';
import 'package:zcart_seller/presentation/auth/widgets/country_widget.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_button.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController(text: '123456');
    final emailController = useTextEditingController(text: 'merchant@demo.com');

    final isPhoneLogin = useState(false);

    final showPassword = useState(false);
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(subscriptionplanProvider.notifier).getPlans();
      });
      return null;
    }, []);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next && !next.loading) {
        // if phone login redirect to otpverificatobn screen
        if (next.failure == CleanFailure.none()) {
          if (isPhoneLogin.value) {
            String phone = ref.read(countryCodeProvider).getSelectedCountry() +
                phoneController.text;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OTPVerificationScreen(
                  phone: phone,
                ),
              ),
            );
          } else {
            // if email login redirect to dashboard page
            if (next.user != UserModel.init()) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const DashboardHome()),
                  (Route<dynamic> route) => false);
            } else if (next.failure != CleanFailure.none()) {
              NotificationHelper.error(message: next.failure.error);
            }
          }
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });

    final loading = ref.watch(authProvider.select((value) => value.loading));

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final formKey2 = useMemoized(() => GlobalKey<FormState>());
    final formKey3 = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.r),
          ),
        ),
        centerTitle: true,
        title: Container(
            height: 100,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(10)),
            child: Image.asset(
              'assets/zcart_logo/zcart_logo.png',
              fit: BoxFit.cover,
            )),
      ),
      body: DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  'wellcome'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'signin_and_mange_order'.tr(),
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 30.h),
                //check if plugin is activated
                Consumer(builder: (context, watch, child) {
                  final otpLoginPluginCheck =
                      ref.watch(checkOtpLoginPluginProvider);

                  return otpLoginPluginCheck.when(
                      data: (data) {
                        return data == true
                            ? TabBar(
                                tabs: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      'email_login'.tr(),
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      'phone_login'.tr(),
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox();
                      },
                      loading: () => const SizedBox(),
                      error: (_, __) => const SizedBox());
                }),
                SizedBox(height: 20.h),
                Consumer(builder: (context, watch, child) {
                  var otpLoginPluginCheck =
                      ref.watch(checkOtpLoginPluginProvider);

                  return otpLoginPluginCheck.when(
                      data: (data) {
                        return data == true
                            ? //check if plugin is activated
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: TabBarView(
                                  children: [
                                    // EMAIL LOGIN
                                    _buildEmailLoginForm(
                                      formKey,
                                      emailController,
                                      passwordController,
                                      showPassword,
                                      isPhoneLogin,
                                      loading,
                                      ref,
                                    ),

                                    // PHONE LOGIN
                                    PhoneLoginForm(
                                      formKey: formKey2,
                                      phoneController: phoneController,
                                      loading: loading,
                                      isPhoneLogin: isPhoneLogin,
                                    ),
                                  ],
                                ),
                              )
                            : _buildEmailLoginForm(
                                formKey,
                                emailController,
                                passwordController,
                                showPassword,
                                isPhoneLogin,
                                loading,
                                ref,
                              );
                      },
                      loading: () => const SizedBox(),
                      error: (_, __) => const SizedBox());
                }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'or_create_a_new_account'.tr(),
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const SignupScreen()));
                          },
                          child: Text('sign_up'.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'or_forgot_password'.tr(),
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    const ForgetPasswordDialog());
                          },
                          child: Text('Forget password',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _buildEmailLoginForm(
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController,
      ValueNotifier<bool> showPassword,
      ValueNotifier<bool> isPhoneLogin,
      bool loading,
      WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 10.h),
          KTextField(
            validator: (text) {
              final d = ValidatorLogic.requiredEmail(text);
              Logger.i('checking');
              Logger.i('email: $d');
              return d;
            },
            controller: emailController,
            prefixIcon: const Icon(Icons.mail),
            lebelText: 'Email address',
          ),
          SizedBox(height: 15.h),
          KTextField(
            validator: (text) => ValidatorLogic.requiredPassword(text),
            controller: passwordController,
            lebelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: InkWell(
              onTap: () {
                showPassword.value = !showPassword.value;
              },
              child: showPassword.value
                  ? const Icon(
                      Icons.visibility_off,
                    )
                  : const Icon(Icons.remove_red_eye),
            ),
            obscureText: !showPassword.value,
          ),
          SizedBox(height: 20.h),
          KButton(
            onPressed: loading
                ? null
                : () {
                    isPhoneLogin.value = false;
                    Logger.i(formKey.currentState?.validate() ?? false);
                    if (formKey.currentState?.validate() ?? false) {
                      final body = LogInBody(
                          email: emailController.text,
                          password: passwordController.text);
                      Logger.i(body);
                      ref.read(authProvider.notifier).login(body: body);
                    }
                  },
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }

  Form _buildEmailLoginFormInside(
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController,
      ValueNotifier<bool> showPassword,
      ValueNotifier<bool> isPhoneLogin,
      bool loading,
      WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 10.h),
          KTextField(
            validator: (text) {
              final d = ValidatorLogic.requiredEmail(text);
              Logger.i('checking');
              Logger.i('email: $d');
              return d;
            },
            controller: emailController,
            prefixIcon: const Icon(Icons.mail),
            lebelText: 'Email address',
          ),
          SizedBox(height: 15.h),
          KTextField(
            validator: (text) => ValidatorLogic.requiredPassword(text),
            controller: passwordController,
            lebelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: InkWell(
              onTap: () {
                showPassword.value = !showPassword.value;
              },
              child: showPassword.value
                  ? const Icon(
                      Icons.visibility_off,
                    )
                  : const Icon(Icons.remove_red_eye),
            ),
            obscureText: !showPassword.value,
          ),
          SizedBox(height: 20.h),
          KButton(
            onPressed: loading
                ? null
                : () {
                    isPhoneLogin.value = false;
                    Logger.i(formKey.currentState?.validate() ?? false);
                    if (formKey.currentState?.validate() ?? false) {
                      final body = LogInBody(
                          email: emailController.text,
                          password: passwordController.text);
                      Logger.i(body);
                      ref.read(authProvider.notifier).login(body: body);
                    }
                  },
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}

class PhoneLoginForm extends ConsumerWidget {
  const PhoneLoginForm({
    Key? key,
    required this.formKey,
    required this.phoneController,
    required this.loading,
    required this.isPhoneLogin,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final bool loading;
  final ValueNotifier<bool> isPhoneLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: KTextField(
              validator: (text) => ValidatorLogic.requiredField(text),
              controller: phoneController,
              lebelText: "phone".tr(),
              keyboardType: TextInputType.phone,
              prefixIcon: const CountryWidget(),
            ),
          ),
          SizedBox(height: 20.h),
          KButton(
            onPressed: loading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      isPhoneLogin.value = true;
                      String phone =
                          ref.read(countryCodeProvider).getSelectedCountry() +
                              phoneController.text;
                      ref.read(authProvider.notifier).otpLogin(phone: phone);
                      log('IsPhoen: $isPhoneLogin');
                    }
                  },
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
