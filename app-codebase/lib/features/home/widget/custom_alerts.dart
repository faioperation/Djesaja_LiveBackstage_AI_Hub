import 'package:flutter/material.dart';

import '../../../common/custom_color.dart';

class CustomAlerts extends StatelessWidget {
  const CustomAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 266,
      width: 386,
      padding: const EdgeInsets.all(1.5), // gradient border thickness
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient, // ✅ gradient border
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xff101828),
          borderRadius: BorderRadius.circular(10),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Alerts',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '18',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Alert Items
          _buildAlertItem(
            'Manager Lisa Anderson is underperforming - 59% of target',
            '13:31:55',
          ),
          const SizedBox(height: 10),
          _buildAlertItem(
            'Manager Lisa Anderson is underperforming - 59% of target',
            '13:31:55',
          ),
          const SizedBox(height: 10),
          _buildAlertItem(
            'Manager Lisa Anderson is underperforming - 59% of target',
            '13:31:55',
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildAlertItem(String message, String time) {
    return Container(
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Red dot indicator
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          // Message
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Time
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}