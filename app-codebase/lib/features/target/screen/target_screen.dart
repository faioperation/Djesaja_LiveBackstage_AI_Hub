import 'package:flutter/material.dart';
import 'package:top_talent_agency/features/target/widget/custom_targets.dart';

import '../../../core/roles.dart';

class TargetsScreen extends StatelessWidget {
  final UiUserRole role;
  const TargetsScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text(
            role == UiUserRole.creator
                ? "Targets for you"
                : "Total targets for Agency",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
             CustomTargets(),

             SizedBox(height: 20),
             CustomTargets(
               year: 'January 2026',
               progressBarColor: Colors.red,
               containerColor: Color(0xff3F002B),
             ),

             SizedBox(height: 20),
             CustomTargets(),

             SizedBox(height: 20),
             CustomTargets(
               year: 'November 2025',
               progressBarColor: Color(0xff00A63E),
               containerColor: Color(0xff003612),
             ),
            ]
          ),
        ),
      ),
    );
  }
}

