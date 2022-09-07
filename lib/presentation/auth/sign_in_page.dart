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
import 'package:zcart_seller/domain/auth/log_in_body.dart';
import 'package:zcart_seller/domain/auth/user_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/auth/signup_screen.dart';
import 'package:zcart_seller/presentation/app/dashboard/dashboard_page.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_button.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final passwordController = useTextEditingController(text: '123456');
    final emailController = useTextEditingController(text: 'merchant@demo.com');
    final showPassword = useState(false);
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(subscriptionplanProvider.notifier).getPlans();
      });
      return null;
    }, []);

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
          CherryToast.error(
            title: Text(
              next.failure.error,
            ),
            toastPosition: Position.bottom,
          ).show(context);
          // next.failure.showDialogue(context);
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
            children: [
              // Container(
              //   height: 220.h,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       color:  Constants.appbarColor,
              //       borderRadius: const BorderRadius.only(
              //           bottomLeft: Radius.circular(25),
              //           bottomRight: Radius.circular(25))),
              // ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),
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
                      'Signin and manage your orders',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 40.h),
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
                      validator: (text) =>
                          ValidatorLogic.requiredPassword(text),
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
                    SizedBox(height: 40.h),
                    KButton(
                      onPressed: () {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Or, create a new Account?',
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
                          child: Text('Sign Up',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
