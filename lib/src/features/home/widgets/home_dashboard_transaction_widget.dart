import 'package:flutter/material.dart';
import 'package:uas_laundry_app/src/core/extension/int_currency_ext.dart';

import '../../../core/components/spaces.dart';

class HomeDashboardTransactionWidget extends StatelessWidget {
  const HomeDashboardTransactionWidget({
    super.key,
    required this.totalTransaction,
    required this.totalRevenue,
    required this.totalProcess,
    required this.totalReady,
    required this.totalCompleted,
  });

  final int totalTransaction;
  final int totalRevenue;
  final int totalProcess;
  final int totalReady;
  final int totalCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Pendapatan",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                totalRevenue.currencyFormatRp,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SpaceHeight(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Transaksi",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$totalTransaction",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SpaceHeight(4),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          SpaceHeight(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "$totalProcess",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SpaceHeight(14),
                  Text(
                    "Process",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "$totalReady",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SpaceHeight(14),
                  Text(
                    "Ready",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "$totalCompleted",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SpaceHeight(14),
                  Text(
                    "Completed",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
