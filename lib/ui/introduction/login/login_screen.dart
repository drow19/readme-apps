import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/ui/introduction/login/login_screen_provider.dart';
import 'package:book_store_apps/widgets/appbar/m_appbar.dart';
import 'package:book_store_apps/widgets/button/m_button.dart';
import 'package:book_store_apps/widgets/button/m_large_button.dart';
import 'package:book_store_apps/widgets/button/m_small_button.dart';
import 'package:book_store_apps/widgets/icon/m_app_icon.dart';
import 'package:book_store_apps/widgets/input_field/m_password_field.dart';
import 'package:book_store_apps/widgets/input_field/m_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginScreenProvider provider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    provider = context.watch<LoginScreenProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MColors.n4,
        appBar: const MAppBar(
          title: 'Login',
          backgroundColor: MColors.p1,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * .25,
                width: double.infinity,
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MAppIcon(
                      image: 'assets/images/splash_icon.png',
                    ),
                  ],
                ),
              ),
              MTextField(
                controller: provider.userNameCtrl,
                labelText: 'Username',
                placeHolderText: 'input username',
                errorText:
                    (!provider.isValidation && provider.userNameCtrl.text.isEmpty)
                        ? 'Username cannot be empty'
                        : null,
              ),
              const SizedBox(height: 20),
              MPasswordField(
                controller: provider.passwordCtrl,
                labelText: 'Password',
                placeHolderText: '******',
                errorText:
                    (!provider.isValidation && provider.passwordCtrl.text.isEmpty)
                        ? 'Password cannot be empty'
                        : null,
              ),
              const SizedBox(height: 40),
              FractionallySizedBox(
                widthFactor: 1,
                child: MLargeButton(
                  onPressed: () => provider.submit(context),
                  title: 'Sign In',
                  typeButton: MTypeButton.filled,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ?",
                    style: MTypography.body3.copyWith(color: MColors.p1),
                  ),
                  const SizedBox(width: 20),
                  MSmallButton(
                    onPressed: () => provider.goToRegister(context),
                    title: 'Sign Up',
                    typeButton: MTypeButton.outline,
                    buttonColor: MColors.n6,
                    outlineColor: MColors.n1,
                    textColor: MColors.p1,
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
