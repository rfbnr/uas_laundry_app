import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:uas_laundry_app/src/core/extension/int_currency_ext.dart';
import 'package:uas_laundry_app/src/core/extension/string_currency_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_dropdown_widget.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/datas.dart';
import '../../../data/datasources/transaction_remote_datasource.dart';
import '../../../data/response/request/transaction_request_model.dart';
import '../../home/screens/dashboard_route.dart';
import '../blocs/transaction_bloc/transaction_bloc.dart';

class TransactionCreateScreen extends StatelessWidget {
  const TransactionCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(
        transactionRemoteDatasource: TransactionRemoteDatasource(),
      ),
      child: const TransactionCreateScreenView(),
    );
  }
}

class TransactionCreateScreenView extends StatefulWidget {
  const TransactionCreateScreenView({super.key});

  @override
  State<TransactionCreateScreenView> createState() =>
      _TransactionCreateScreenViewState();
}

class _TransactionCreateScreenViewState
    extends State<TransactionCreateScreenView> {
  final nameController = TextEditingController();
  final tlpController = TextEditingController();
  final emailController = TextEditingController();
  final weightController = TextEditingController();
  final notesController = TextEditingController();
  final totalPriceController = TextEditingController();

  String selectedPayment = "tunai";

  String pickupDateSend = "";
  String receivedDateSend = "";

  String pickupDateView = "";
  String receivedDateView = "";

  String tipePewangi = "";
  String tipeCucian = "";

  @override
  void dispose() {
    nameController.dispose();
    tlpController.dispose();
    emailController.dispose();
    weightController.dispose();
    notesController.dispose();
    totalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Transaksi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                fillColor: Colors.white,
                label: "Nama Customer",
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(
                  Icons.person,
                  size: 20,
                ),
              ),
              SpaceHeight(20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: tlpController,
                      fillColor: Colors.white,
                      label: "Nomor Telepon",
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(
                        Icons.phone,
                        size: 20,
                      ),
                    ),
                  ),
                  SpaceWidth(10),
                  Expanded(
                    child: CustomTextField(
                      controller: emailController,
                      fillColor: Colors.white,
                      label: "Email *optional",
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(
                        Icons.email,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SpaceHeight(20),
              CustomTextField(
                controller: notesController,
                fillColor: Colors.white,
                label: "Notes",
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(
                  Icons.note,
                  size: 20,
                ),
              ),
              SpaceHeight(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tanggal diserahkan",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceHeight(12.0),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      ).then(
                        (value) {
                          String formattedDateSend =
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                  .format(value!);
                          String formattedDateView =
                              DateFormat('dd MMMM yyyy').format(value);

                          setState(() {
                            receivedDateSend = formattedDateSend;
                            receivedDateView = formattedDateView;
                          });
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey[400]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.today,
                            size: 20,
                            color: Colors.black54,
                          ),
                          const SpaceWidth(10),
                          Text(
                            receivedDateView.isEmpty
                                ? 'Tanggal diserahkan'
                                : receivedDateView,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SpaceHeight(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tanggal diambil",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceHeight(12.0),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      ).then(
                        (value) {
                          String formattedDateSend =
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                                  .format(value!);
                          String formattedDateView =
                              DateFormat('dd MMMM yyyy').format(value);

                          setState(() {
                            pickupDateSend = formattedDateSend;
                            pickupDateView = formattedDateView;
                          });
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey[400]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.event,
                            size: 20,
                            color: Colors.black54,
                          ),
                          const SpaceWidth(10),
                          Text(
                            pickupDateView.isEmpty
                                ? 'Tanggal diambil'
                                : pickupDateView,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SpaceHeight(20),
              CustomTextField(
                controller: weightController,
                fillColor: Colors.white,
                label: "Berat Cucian",
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(
                  Icons.shopping_bag,
                  size: 20,
                ),
                onChanged: (value) {
                  final int weightValue = value.toIntegerFromText;

                  weightController.text = "$weightValue kg";
                  weightController.selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: weightValue.toString().length,
                    ),
                  );
                },
              ),
              SpaceHeight(20),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdownWidget<Map<String, dynamic>>(
                      label: "Tipe Pewangi",
                      items: fragranceTypeData.map((e) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: e,
                          child: Text(
                            e['pewangiName'],
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          tipePewangi = v!['pewangiName'];
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tipe Pewangi";
                        }
                        return null;
                      },
                    ),
                  ),
                  SpaceWidth(20),
                  Expanded(
                    child: CustomDropdownWidget<Map<String, dynamic>>(
                      label: "Tipe Cucian",
                      items: washingTypeData.map((e) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: e,
                          child: Text(
                            e['cucianName'],
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          tipeCucian = v!['cucianName'];
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tipe Cucian";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SpaceHeight(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pembayaran",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceHeight(10.0),
                  Center(
                    child: ToggleButtons(
                      isSelected: [
                        selectedPayment == "tunai",
                        selectedPayment == "qris",
                      ],
                      onPressed: (index) {
                        setState(() {
                          selectedPayment = index == 0
                              ? "tunai"
                              : index == 1
                                  ? "qris"
                                  : "tunai";
                        });
                      },
                      borderRadius: BorderRadius.circular(15),
                      selectedColor: Colors.white,
                      fillColor: Colors.blue,
                      color: Colors.grey,
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        minHeight: 50,
                      ),
                      children: [
                        Text(
                          'Tunai',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'QRIS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SpaceHeight(20),
              CustomTextField(
                controller: totalPriceController,
                fillColor: Colors.white,
                label: "Total Pembayaran",
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(
                  Icons.money,
                  size: 20,
                ),
                onChanged: (value) {
                  final int totalPriceValue = value.toIntegerFromText;

                  totalPriceController.text = totalPriceValue.currencyFormatRp;
                  totalPriceController.selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: totalPriceController.text.length,
                    ),
                  );
                },
              ),
              SpaceHeight(40),
              BlocListener<TransactionBloc, TransactionState>(
                listener: (context, state) {
                  if (state.status == TransactionStatus.loading) {
                    EasyLoading.dismiss();
                    EasyLoading.show(
                      status: "loading kirim data...",
                      dismissOnTap: false,
                      maskType: EasyLoadingMaskType.black,
                    );
                  } else if (state.status == TransactionStatus.failure) {
                    final message = state.error?.message ?? "Error";

                    EasyLoading.dismiss();
                    EasyLoading.showError(
                      message,
                      duration: const Duration(seconds: 4),
                    );
                  } else if (state.status == TransactionStatus.success) {
                    final message = state.result?.message ?? "Success";

                    EasyLoading.dismiss();
                    EasyLoading.showSuccess(message);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const DashboardRoute();
                        },
                      ),
                      (route) => false,
                    );
                  }
                },
                child: Button.filled(
                  label: "Buat Transaksi",
                  onPressed: () {
                    final name = nameController.text;
                    final tlp = tlpController.text;
                    final email = emailController.text;
                    final notes = notesController.text;
                    final weight = weightController.text;
                    final totalPrice = totalPriceController.text;

                    if (name.isEmpty ||
                        tlp.isEmpty ||
                        notes.isEmpty ||
                        weight.isEmpty ||
                        totalPrice.isEmpty) {
                      EasyLoading.showError("Data tidak boleh kosong");
                      return;
                    }

                    if (pickupDateSend.isEmpty || receivedDateSend.isEmpty) {
                      EasyLoading.showError(
                          "Tanggal diambil / tanggal diserahkan\ntidak boleh kosong");
                      return;
                    }

                    if (tipePewangi.isEmpty || tipeCucian.isEmpty) {
                      EasyLoading.showError(
                          "Tipe Cucian / Tipe Pewangi\ntidak boleh kosong");
                      return;
                    }

                    final body = TransactionRequestModel(
                      customerName: name,
                      phoneNumber: tlp,
                      email: email,
                      notes: notes,
                      receivedDate: receivedDateSend,
                      pickupDate: pickupDateSend,
                      weight: weight.toIntegerFromText,
                      washingType: tipeCucian,
                      fragrance: tipePewangi,
                      paymentMethod: selectedPayment,
                      statusPayment: "sudah dibayar",
                      totalPrice: totalPrice.toIntegerFromText,
                    );

                    context.read<TransactionBloc>().add(
                          TransactionCreateData(body: body),
                        );
                  },
                ),
              ),
              SpaceHeight(80),
            ],
          ),
        ),
      ),
    );
  }
}
