import 'package:flutter/material.dart';
import 'package:top_talent_agency/features/auth/widgets/custom_screen.dart';
import 'package:top_talent_agency/features/auth/widgets/custom_textfield.dart';
import 'package:top_talent_agency/features/auth/screens/verify_screen.dart';
import 'package:top_talent_agency/common/custom_button.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScreen(
        svgPath: 'assets/Group.svg',
        svgHeight: 180,
        svgWidth: 130,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Center(

              child: Text(
                "Forgot password?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 15.0), // adjust as needed
              child: Text(
                "Enter your email and we will send you a \n                  verification code.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 30),

            Text(
              "Email",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            CustomTextfield(hintText: "Enter your email address"),

            SizedBox(height: 30),
            CustomButton(text: "Send code", onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const VerifyScreen()));
            }),
          ],
        ),
      ),
    );
  }
}
