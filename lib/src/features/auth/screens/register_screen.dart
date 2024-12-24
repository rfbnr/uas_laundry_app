import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/response/request/register_request_model.dart';
import '../bloc/auth_bloc.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          "Registrasi Akun",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const SpaceHeight(20.0),
          const Text(
            "Silahkan registrasi untuk membuat akun baru anda.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: nameController,
            label: "Nama Lengkap",
            fillColor: AppColors.white,
          ),
          const SpaceHeight(20.0),
          CustomTextField(
            fillColor: AppColors.white,
            controller: emailController,
            label: "Email",
            keyboardType: TextInputType.emailAddress,
          ),
          const SpaceHeight(20.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final showPassword = state.showRegisterPassword;

              return CustomTextField(
                fillColor: AppColors.white,
                controller: passwordController,
                label: "Kata Sandi",
                obscureText: showPassword!,
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          VisibilityRegisterPassword(showPassword),
                        );
                  },
                ),
              );
            },
          ),
          const SpaceHeight(20.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final showPassword = state.showConfirmPassword;

              return CustomTextField(
                fillColor: AppColors.white,
                controller: confirmController,
                label: "Konfirmasi Kata Sandi",
                obscureText: showPassword!,
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          VisibilityConfirmPassword(showPassword),
                        );
                  },
                ),
              );
            },
          ),
          const SpaceHeight(54.0),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.registerStatus == RegisterStatus.loading) {
                EasyLoading.dismiss();
                EasyLoading.show(
                  status: "loading...",
                  dismissOnTap: false,
                  maskType: EasyLoadingMaskType.black,
                );
              } else if (state.registerStatus == RegisterStatus.success) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Berhasil Registrasi");

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }),
                  (route) => false,
                );
              } else if (state.registerStatus == RegisterStatus.failure) {
                final error = state.error!;
                EasyLoading.dismiss();
                EasyLoading.showError(error.message!);
              }
            },
            builder: (context, state) {
              return Button.filled(
                label: "Buat Akun",
                width: double.infinity,
                onPressed: () {
                  if (passwordController.text != confirmController.text) {
                    EasyLoading.showError("Password tidak sama");
                    return;
                  }

                  final body = RegisterRequestModel(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text,
                  );

                  context.read<AuthBloc>().add(
                        UserRegister(
                          body: body,
                        ),
                      );
                },
              );
            },
          ),
          const SpaceHeight(20.0),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }),
              );
            },
            child: const Text(
              "Sudah mempunyai akun? Login disini.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
