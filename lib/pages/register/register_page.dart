// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/helper/functions.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/pages/register/register_cubit/register_cubit.dart';
import 'package:kau_carpool/pages/verification/verification_page.dart';
import 'package:kau_carpool/widgets/custom_button.dart';
import 'package:kau_carpool/widgets/custom_text_filed.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  String gender = '';
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterCreateUserSuccess) {
            RegisterCubit.get(context).emailVerified(state.uId);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => VerificationPage(),
                ), (route) {
              return false;
            });
            }},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.backgroundColor,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    child: const Image(
                      image: AssetImage("assets/images/left_arrow_ic.png"),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 1,
                      horizontal: 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "in less than a minute",
                              style: TextStyle(
                                fontSize: 15,
                                color: ColorManager.blueWithOpacity,
                              ),
                            ),
                          ],
                        ),
                        const Image(
                          image: AssetImage("assets/images/splash_logo.png"),
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 100 / 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset.zero,
                            blurRadius: 20,
                            color: ColorManager.white,
                          ),
                        ]),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          CustomFormTextField(
                            controller: nameController,
                            type: TextInputType.name,
                            labelText: "Full Name",
                            hintText: "Enter full name",
                            validator: (String? s) {
                              if (s!.length < 3) {
                                return 'name must be more than 2 character';
                              }
                              return null;
                            },
                          ),
                          CustomFormTextField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            labelText: "KUA Email",
                            hintText: "Enter email here",
                            validator: (input) =>
                            input!.isValidEmail()
                                ? null :
                            "check your email (@Kau.edu.sa or @stu.Kau.edu.sa)",
                          ),
                          CustomFormTextField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            labelText: "Phone Number",
                            hintText: "Enter phone number",
                            validator: (input) => input!.isValidPhone()
                                ? null
                                : "enter Valid Phone Number (05********)",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 40,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Gender",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                DropdownButtonFormField(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 35,
                                    color: ColorManager.black,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 0),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: ColorManager.grey,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: ColorManager.black,
                                      ),
                                    ),
                                  ),
                                  hint: Text(
                                    "Choose gender",
                                    style: TextStyle(
                                      color: ColorManager.darkGrey,
                                    ),
                                  ),
                                  // value: gender,
                                  items: <String>['male', 'female']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) =>
                                      setState(() => gender = value!),
                                  validator: (value) =>
                                      value == null ? 'field required' : null,
                                ),
                              ],
                            ),
                          ),
                          CustomFormTextField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            obscureText: RegisterCubit.get(context).isPassShown,
                            suffix: RegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              RegisterCubit.get(context).passVisibility();
                            },
                            labelText: "Password",
                            hintText: "Enter password",
                            validator: (input) => input!.isValidPassword()
                                ? null
                                : "8 characters, at least one letter and one number",
                          ),
                          CustomFormTextField(
                            controller: confirmPasswordController,
                            type: TextInputType.visiblePassword,
                            obscureText: RegisterCubit.get(context).isPassShown,
                            suffix: RegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              RegisterCubit.get(context).passVisibility();
                            },
                            labelText: "Confirm Password",
                            hintText: "Confirm password",
                            validator: (String? s) {
                              if (s! != passwordController.text) {
                                return 'not match';
                              }
                              return null;
                            },
                          ),
                          Center(
                            child: Text(
                              "We will send a verification code",
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorManager.blueWithOpacity,
                              ),
                            ),
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoading,
                            builder: (context) => CustomButton(
                              width: 100,
                              text: "Continue",
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                    gender: gender,
                                  );
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
