import 'package:flutter/material.dart';
import 'package:top_talent_agency/features/auth/widgets/custom_screen.dart';
import 'package:top_talent_agency/features/auth/widgets/custom_textfield.dart';
import 'package:top_talent_agency/features/auth/screens/forgot_screen.dart';
import 'package:top_talent_agency/common/app_shell.dart';
import 'package:top_talent_agency/common/custom_button.dart';
import 'package:top_talent_agency/core/roles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UiUserRole selectedRole = UiUserRole.admin;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: CustomScreen(
        svgPath: 'assets/Group.svg',
        svgHeight: 180,
        svgWidth: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                "Welcome to Top Talent Agency",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() => selectedRole = UiUserRole.admin);
                  },
                  child: Row(
                    children: [
                      Radio<UiUserRole>(
                        value: UiUserRole.admin,
                        groupValue: selectedRole,
                        onChanged: (v) {
                          setState(() => selectedRole = v!);
                        },
                      ),
                      const Text("Admin"),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                InkWell(
                  onTap: () {
                    setState(() => selectedRole = UiUserRole.manager);
                  },
                  child: Row(
                    children: [
                      Radio<UiUserRole>(
                        value: UiUserRole.manager,
                        groupValue: selectedRole,
                        onChanged: (v) {
                          setState(() => selectedRole = v!);
                        },
                      ),
                      const Text("Manager"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() => selectedRole = UiUserRole.creator);
                  },
                  child: Row(
                    children: [
                      Radio<UiUserRole>(
                        value: UiUserRole.creator,
                        groupValue: selectedRole,
                        onChanged: (v) {
                          setState(() => selectedRole = v!);
                        },
                      ),
                      const Text("Creator"),
                    ],
                  ),
                ),
              ],
            ),


            const SizedBox(height: 16),
            const Text("Email"),

            const SizedBox(height: 6),
            const CustomTextfield(hintText: "Enter your email address"),

            const SizedBox(height: 12),

            const Text("Password"),
            const SizedBox(height: 6),

            const CustomTextfield(hintText: "Password",isPassword: true),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text("Remember Me", style: TextStyle(fontSize: 14)),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ForgotScreen()),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 14, color: Color(0xff333333)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Sign in",
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AppShell(
                      role: selectedRole,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
