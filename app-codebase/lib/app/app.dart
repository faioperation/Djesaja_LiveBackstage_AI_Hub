import 'package:flutter/material.dart';
import 'package:top_talent_agency/features/auth/screens/login_screen.dart';

class TopTalentAgency extends StatelessWidget {
  const TopTalentAgency({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "Top Talent Agency",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
