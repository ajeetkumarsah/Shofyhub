import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zcart_vendor/helper/constants.dart';
import 'package:zcart_vendor/views/custom/style_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _niceNameController = TextEditingController();
  final _roleController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _genderController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _fullNameController,
                  decoration: textFieldDecoration(
                      label: "Full Name", hint: "Enter your full name"),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _niceNameController,
                  decoration: textFieldDecoration(
                      label: "Nice Name", hint: "Enter your nice name"),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: textFieldDecoration(
                      label: "Email", hint: "Enter your email"),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _roleController,
                  decoration: textFieldDecoration(
                          label: "Role", hint: "Enter your role")
                      .copyWith(
                    enabled: false,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _dateOfBirthController,
                  decoration: textFieldDecoration(
                      label: "Date of Birth",
                      hint: "Enter your date of birth",
                      prefixIcon: CupertinoIcons.calendar),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _genderController,
                  decoration: textFieldDecoration(
                      label: "Gender", hint: "Choose your gender"),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration:
                      textFieldDecoration(label: "Bio", hint: "Enter bio")
                          .copyWith(
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
