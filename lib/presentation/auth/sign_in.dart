import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/auth/auth_provider.dart';
import 'package:zcart_vendor/application/auth/auth_state.dart';
import 'package:zcart_vendor/domain/auth/log_in_body.dart';
import 'package:zcart_vendor/domain/auth/user_model.dart';
import 'package:zcart_vendor/presentation/auth/signup_screen.dart';
import 'package:zcart_vendor/presentation/new_dashboard/dashboard_page.dart';
import 'package:zcart_vendor/presentation/widget_for_all/color.dart';
import 'package:zcart_vendor/presentation/widget_for_all/k_button.dart';
import 'package:zcart_vendor/presentation/widget_for_all/k_text_field.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final passwordController = useTextEditingController(text: '123456');
    final emailController = useTextEditingController(text: 'merchant@demo.com');
    final showPassword = useState(false);
    // useEffect(() {
    //   Future.delayed(const Duration(milliseconds: 100), () async {
    //     final body = LogInBody(
    //         email: emailController.text, password: passwordController.text);
    //     Logger.i(body);
    //     ref.read(authProvider.notifier).login(body: body);
    //   });
    //   return null;
    // }, []);

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
          next.failure.showDialogue(context);
        }
      }
    });

    final loading = ref.watch(authProvider.select((value) => value.loading));
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        toolbarHeight: 200.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 220.h,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //       color: MyColor.appbarColor,
            //       borderRadius: const BorderRadius.only(
            //           bottomLeft: Radius.circular(25),
            //           bottomRight: Radius.circular(25))),
            // ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Wellcome',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Sign in and start delivering orders!',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  KTextField(
                    controller: emailController,
                    prefixIcon: const Icon(Icons.mail),
                    lebelText: 'Email address',
                  ),
                  SizedBox(height: 15.h),
                  KTextField(
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
                    onPressed: () {
                      final body = LogInBody(
                          email: emailController.text,
                          password: passwordController.text);
                      Logger.i(body);
                      ref.read(authProvider.notifier).login(body: body);
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
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Or, create a new Account? ',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 15.sp,
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
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
