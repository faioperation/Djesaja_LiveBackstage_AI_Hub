import 'package:flutter/material.dart';

import '../../../common/custom_color.dart';

class CustomSummary extends StatelessWidget {
  const CustomSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: 420,
        minHeight: size.height * 0.45,
      ),
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xff101828), // inside color
            borderRadius: BorderRadius.circular(10),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: Color(0xffAD46FF),
                size: 25,
              ),
              const SizedBox(width: 10),
              Text(
                'AI Daily Summary for Your Team',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // High Priority Section
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity, // full available width
            decoration: BoxDecoration(
              color: const Color(0xff1D0014),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xff620041),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'High Priority',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  'Nadia Islam-',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Nadia is significantly underperforming across all metrics. Coins are 37% below target, hours are inconsistent, and follower growth has stalled.',
                  textAlign: TextAlign.start,
                  style:const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 15),
                _buildBulletPoint('Schedule one-on-one coaching session to identify blockers'),
                const SizedBox(height: 6),
                _buildBulletPoint('Review content strategy and posting schedule'),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Team Insight Section
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF001206),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xff00551D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Team Insight',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(text: 'Your team is averaging '),
                      TextSpan(
                        text: '4.2 hours',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: '1,092 coins',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' per creator today.'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: '4',
                        style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' out of ',style: TextStyle(color:Colors.white,)),
                      TextSpan(
                        text: '8',
                        style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' creators are performing well.',style: TextStyle(color:Colors.white,)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: Color(0xffAD46FF),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}