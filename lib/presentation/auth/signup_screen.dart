import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_button.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final showPassword = useState(false);
    final passwordController = useTextEditingController();
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final mobileController = useTextEditingController();
    final addressController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 110.h,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff683CB7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 30.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: CircleAvatar(
                  radius: 45.r,
                  backgroundImage: const NetworkImage(
                      "https://www.pngitem.com/pimgs/m/256-2560208_person-icon-black-png-transparent-png.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: KTextField(
                controller: nameController,
                lebelText: "Seller name",
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: KTextField(
                controller: mobileController,
                lebelText: "Mobile no.",
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: KTextField(
                        controller: addressController,
                        lebelText: "Address",
                        prefixIcon: const Icon(Icons.location_city_outlined),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Select Location",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: const Color(0xff683CB7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: KTextField(
                controller: emailController,
                lebelText: "Email Address",
                prefixIcon: const Icon(Icons.mail),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: KTextField(
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
                obscureText: showPassword.value,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
              padding: EdgeInsets.all(10.h),
              child: KButton(
                onPressed: () {},
                child: const Text("Sign up"),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
