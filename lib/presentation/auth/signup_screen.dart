import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/subcroption_plan_provider.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/auth/auth_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/domain/auth/registration_body.dart';
import 'package:zcart_seller/domain/auth/user_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/app/dashboard/dashboard_page.dart';
import 'package:zcart_seller/presentation/auth/sign_in_page.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_button.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final planList =
        ref.watch(subscriptionplanProvider.select((value) => value.dataList));
    final showPassword = useState(true);
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final emailController = useTextEditingController();
    final shopNameController = useTextEditingController();
    final ValueNotifier<KeyValueData> selectedPlan = useState(planList[0]);
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.user != UserModel.init()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => const DashBoardScreen(),
              builder: (context) => const DashboardPage(),
            ),
          );
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
    final loading = ref.watch(authProvider.select((value) => value.loading));
    final formKey = useMemoized(() => GlobalKey<FormState>());
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
            height: 150,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(10)),
            child: Image.asset(
              'assets/zcart_logo/zcart_logo.png',
              fit: BoxFit.cover,
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.w, left: 10.w),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 5, bottom: 10),
              //     child: CircleAvatar(
              //       radius: 45.r,
              //       backgroundImage: const NetworkImage(
              //           "https://www.pngitem.com/pimgs/m/256-2560208_person-icon-black-png-transparent-png.png"),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: KTextField(
                  validator: (text) => ValidatorLogic.requiredField(text,
                      fieldName: 'Shop name'),
                  controller: shopNameController,
                  lebelText: "Shop name",
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: KTextField(
                  validator: (text) => ValidatorLogic.requiredEmail(text),
                  controller: emailController,
                  lebelText: "Email Address",
                  prefixIcon: const Icon(Icons.mail),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: SizedBox(
                  height: 50.h,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.w),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      style: TextStyle(color: Colors.grey.shade800),
                      isExpanded: true,
                      value: selectedPlan.value,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: planList.map<DropdownMenuItem<KeyValueData>>(
                          (KeyValueData value) {
                        return DropdownMenuItem<KeyValueData>(
                          value: value,
                          child: Text(
                            value.key,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (KeyValueData? newValue) {
                        selectedPlan.value = newValue!;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: KTextField(
                  validator: (text) => ValidatorLogic.requiredPassword(text),
                  controller: passwordController,
                  lebelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: InkWell(
                    onTap: () {
                      showPassword.value = !showPassword.value;
                    },
                    child: !showPassword.value
                        ? const Icon(
                            Icons.visibility_off,
                          )
                        : const Icon(Icons.remove_red_eye),
                  ),
                  obscureText: showPassword.value,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: KTextField(
                  validator: (text) => ValidatorLogic.requiredPassword(text),
                  controller: confirmPasswordController,
                  lebelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: InkWell(
                    onTap: () {
                      showPassword.value = !showPassword.value;
                    },
                    child: !showPassword.value
                        ? const Icon(
                            Icons.visibility_off,
                          )
                        : const Icon(Icons.remove_red_eye),
                  ),
                  obscureText: showPassword.value,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By signing up you're accepting the ",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Terms and Condition ",
                        style: TextStyle(
                          color: const Color(0xff683CB7),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                          text: "of becoming a seller on this platform.")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: KButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        final body = RegistrationBody(
                          shopName: shopNameController.text,
                          email: emailController.text,
                          planId: selectedPlan.value.value,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                          agree: true,
                        );

                        ref
                            .read(authProvider.notifier)
                            .registration(body: body);
                      } else {
                        NotificationHelper.error(message: 'password_didnt_matched'.tr());
                        // CherryToast.error(
                        //   title: const Text(
                        //     "Password didn't matched",
                        //   ),
                        //   toastPosition: Position.bottom,
                        // ).show(context);
                      }
                    }
                  },
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text("Sign up"),
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Or, Already have an Account?',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SignInPage()));
                    },
                    child: Text('Sign In',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
