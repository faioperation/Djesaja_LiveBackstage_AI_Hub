import 'package:flutter/material.dart';
import 'package:top_talent_agency/features/auth/widgets/custom_screen.dart';
import 'package:top_talent_agency/features/auth/widgets/custom_textfield.dart';
import 'package:top_talent_agency/common/custom_button.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
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
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Set a new password",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Create a new password. Ensure it differs \n        from previous ones for security",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                CustomTextfield(hintText: "New Password"),

                SizedBox(height: 15),
                CustomTextfield(hintText: "Retype New Password"),

                SizedBox(height: 30),
                CustomButton(text: "Reset password", onTap: (){})
              ]
          )),
    );
  }
}