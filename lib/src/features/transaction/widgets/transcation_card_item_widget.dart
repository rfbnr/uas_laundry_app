import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas_laundry_app/src/core/extension/int_currency_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../data/response/response/transaction_response_model.dart';

class TranscationCardItemWidget extends StatefulWidget {
  const TranscationCardItemWidget({
    super.key,
    required this.data,
    this.onPressed,
  });

  final TransactionResultResponseModel data;
  final Function()? onPressed;

  @override
  State<TranscationCardItemWidget> createState() =>
      _TranscationCardItemWidgetState();
}

class _TranscationCardItemWidgetState extends State<TranscationCardItemWidget> {
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
      widget.data.receivedDate ?? DateTime.now(),
    );

    final formatterDateCompleted = DateFormat("dd MMMM yyyy").format(
      widget.data.completedDate ?? DateTime.now(),
    );

    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          useSafeArea: true,
          isDismissible: true,
          // useRootNavigator: true,
          enableDrag: true,
          isScrollControlled: true,
          builder: (_) {
            return _buildDetailBottomSheet(
              context: context,
              data: widget.data,
            );
            // ModalBottomItemWidget(data: data);
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
                      widget.data.customerName ?? "-",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SpaceHeight(4),
                    Text(
                      "Jenis Layanan: ${widget.data.washingType ?? "-"}",
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
                    if (widget.data.completedDate != null)
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
              getIconStatus(widget.data.status ?? "process"),
              color: getColorIconStatus(widget.data.status ?? "process"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailBottomSheet({
    required BuildContext context,
    required TransactionResultResponseModel data,
  }) {
    final dateReceive = DateFormat("dd MMMM yyyy").format(
      data.receivedDate ?? DateTime.now(),
    );

    String dateComplete = DateFormat("dd MMMM yyyy").format(
      data.completedDate ?? DateTime.now(),
    );

    final datePickup = DateFormat("dd MMMM yyyy").format(
      data.pickupDate ?? DateTime.now(),
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.99,
      minChildSize: 0.7,
      maxChildSize: 0.99,
      expand: true,
      builder: (_, scrrolController) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Detail Transaksi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              SpaceHeight(16),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  controller: scrrolController,
                  children: [
                    _buildDetailTransactionItem(
                      title: "Nama Customer",
                      value: data.customerName ?? "-",
                      icon: Icons.person,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Nomor Telepon",
                      value: data.phoneNumber ?? "-",
                      icon: Icons.phone,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Email",
                      value: data.email ?? "-",
                      icon: Icons.email,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Notes",
                      value: data.notes ?? "-",
                      icon: Icons.notes,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Berat Cucian",
                      value: "${data.weight ?? 0} Kg",
                      icon: Icons.shopping_bag,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tipe Pewangi",
                      value: data.fragrance ?? "-",
                      icon: Icons.emoji_objects,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tipe Cucian",
                      value: data.washingType ?? "-",
                      icon: Icons.wash,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tanggal diambil",
                      value: datePickup,
                      icon: Icons.calendar_today,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tanggal diterima",
                      value: dateReceive,
                      icon: Icons.today,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tanggal selesai",
                      value: data.completedDate == null ? "-" : dateComplete,
                      icon: Icons.event,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Tenggat Waktu",
                      value: data.remainingDayToPickup == null
                          ? "-"
                          : "${data.remainingDayToPickup} Hari",
                      icon: Icons.timer,
                    ),
                    SpaceHeight(16),
                    Divider(
                      color: Colors.grey,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Status Transaksi",
                      value: data.status ?? "-",
                      icon: Icons.sync_outlined,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Pembayaran",
                      value: data.statusPayment ?? "-",
                      icon: Icons.payment,
                    ),
                    SpaceHeight(16),
                    _buildDetailTransactionItem(
                      title: "Total Harga",
                      value: data.totalPrice?.currencyFormatRp ?? "Rp 0",
                      icon: Icons.money,
                    ),
                    SpaceHeight(22),
                    if (data.status != "completed")
                      Button.filled(
                        label:
                            "Ubah Status Menjadi ${data.status == "process" ? "Ready" : "Completed"}",
                        onPressed: widget.onPressed ?? () {},
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailTransactionItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SpaceHeight(8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.grey,
              ),
              SpaceWidth(10),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
