import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:top_talent_agency/features/auth/widgets/custom_screen.dart';
import 'package:top_talent_agency/features/auth/screens/reset_screen.dart';
import 'package:top_talent_agency/common/custom_button.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
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
                  "Check your email",
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
                  "We have sent a 6 digit code to your gmail. \nPlease enter it below to verify your identity",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 30),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: Colors.green,
                    selectedColor: Colors.black,
                    inactiveColor: Colors.grey),
                animationDuration: const Duration(milliseconds: 300),
                // controller: OTPController,
                appContext: context,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Resend OTP",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2),
                    Container(
                      width: 83,
                      height: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              CustomButton(text: "Verify code", onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const ResetScreen()));
              })
            ]
          ),
        ),
     );
   }
}