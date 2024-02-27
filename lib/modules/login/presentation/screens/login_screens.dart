import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/modules/bottomBar/presentation/screens/bottom_bar_screen.dart';
import 'package:flutter_app/modules/login/data/bloc/login_bloc.dart';
import 'package:flutter_app/modules/login/presentation/widgets/text_widgets.dart';
import 'package:flutter_app/utils/app_colors.dart';
import 'package:flutter_app/utils/sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  LoginScreensState createState() => LoginScreensState();
}

class LoginScreensState extends State<LoginScreens> {
  final _appColor = AppColors();
  final _textWidget = TextWidgets();
  final _size = Sizes();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const BottomBarScreen()),
                (Route<dynamic> route) => false);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: _appColor.purple,
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: SingleChildScrollView(
                  reverse: false,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.14,
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: _appColor.white,
                            borderRadius: BorderRadius.circular(30),
                            // We can add image if we need
                          ),
                        ),
                        _textWidget.headingText("App"),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.05),

                        // Welcome Text Heading
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _textWidget.headingText("Welcome!"),
                        ),

                        // USERNAME FOR FIELD
                        TextFormField(
                          style: TextStyle(
                              color: _appColor.white, fontSize: Sizes().t18),
                          decoration: inputdecoration("User name"),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter your username";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 18),
                        //PASSWORD FORM FIELD
                        TextFormField(
                          style: TextStyle(
                              color: _appColor.white, fontSize: Sizes().t18),
                          decoration: inputdecoration("Password"),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 30),

                        buildCustomButton(
                            context, "Login", _formKey), // Customized  button
                        buildForgotPasswordButton(), // Customized forgot password Text button
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.1),

                        Text(
                          "Don't have an account? create a new one",
                          style: TextStyle(color: _appColor.white),
                        ),
                        buildCustomButton(context, "Create", _formKey),
                      ],
                    ),
                  ),
                ),
              )),
            );
          },
        ),
      ),
    );
  }

  InputDecoration inputdecoration(title) {
    return InputDecoration(
      focusColor: _appColor.white,
      hintText: title,
      hintStyle: TextStyle(
        color: _appColor.white,
        fontSize: _size.t18,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _appColor.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _appColor.white),
      ),
    );
  }

  GestureDetector buildForgotPasswordButton() {
    return GestureDetector(
      onTap: () {},
      child: Text.rich(
        TextSpan(
          text: "forgot",
          style: TextStyle(color: _appColor.white),
          children: [
            TextSpan(
              text: " password?",
              style: TextStyle(
                color: _appColor.white,
                fontSize: _size.t16,
                fontWeight: FontWeight.w400,
                decorationColor: _appColor.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomButton(
      BuildContext context, String title, GlobalKey<FormState> formkey) {
    return GestureDetector(
      onTap: () {
        // Need to naigate to dashbord if ites comleted

        if (formkey.currentState!.validate()) {
          context.read<LoginBloc>().add(UserLoginEvent());
        }
      },
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.06,
        width: title == "Login"
            ? double.infinity
            : MediaQuery.sizeOf(context).width * 0.5,
        margin: title == "Login"
            ? const EdgeInsets.only(top: 30)
            : const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: _appColor.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: _appColor.purple,
              fontSize: _size.t18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
