import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/components/spaces.dart';
import '../../../data/response/response/transaction_response_model.dart';

class TransactionCardItemWidget extends StatelessWidget {
  const TransactionCardItemWidget({
    super.key,
    required this.data,
  });

  final TransactionResultResponseModel data;

  IconData getIconStatus(String status) {
    switch (status) {
      case "process":
        return Icons.sync_outlined;
      case "ready":
        return Icons.done;
      case "completed":
        return Icons.done_all;
      default:
        return Icons.sync_outlined;
    }
  }

  Color getColorIconStatus(String status) {
    switch (status) {
      case "process":
        return Colors.blue;
      case "ready":
        return Colors.orange;
      case "completed":
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatterDateReveiced = DateFormat("dd MMMM yyyy").format(
      data.receivedDate ?? DateTime.now(),
    );

    final formatterDateCompleted = DateFormat("dd MMMM yyyy").format(
      data.completedDate ?? DateTime.now(),
    );

    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ModalBottomItemWidget(data: data);
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                SpaceWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.customerName ?? "-",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SpaceHeight(4),
                    Text(
                      "Jenis Layanan: ${data.washingType ?? "-"}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Diterima: $formatterDateReveiced",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (data.completedDate != null)
                      Text(
                        "Selesai: $formatterDateCompleted",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Icon(
              getIconStatus(data.status ?? "process"),
              color: getColorIconStatus(data.status ?? "process"),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalBottomItemWidget extends StatelessWidget {
  const ModalBottomItemWidget({
    super.key,
    required this.data,
  });

  final TransactionResultResponseModel data;

  @override
  Widget build(BuildContext context) {
    final formatterDateReveiced = DateFormat("dd MMMM yyyy").format(
      data.receivedDate ?? DateTime.now(),
    );

    final formatterDateCompleted = DateFormat("dd MMMM yyyy").format(
      data.completedDate ?? DateTime.now(),
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Transaksi",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SpaceHeight(16),
          Text(
            "Nama Pelanggan: ${data.customerName ?? "-"}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SpaceHeight(8),
          Text(
            "Jenis Layanan: ${data.washingType ?? "-"}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SpaceHeight(8),
          Text(
            "Diterima: $formatterDateReveiced",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SpaceHeight(8),
          Text(
            "Selesai: $formatterDateCompleted",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SpaceHeight(8),
          Text(
            "Status: ${data.status ?? "-"}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
