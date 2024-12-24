import 'dart:convert';

class TransactionRequestModel {
  final String? customerName;
  final String? phoneNumber;
  final String? email;
  final int? weight;
  final String? fragrance;
  final String? notes;
  final String? paymentMethod;
  final String? statusPayment;
  final int? totalPrice;
  final String? washingType;
  final DateTime? pickupDate;
  final DateTime? receivedDate;

  TransactionRequestModel({
    this.customerName,
    this.phoneNumber,
    this.email,
    this.weight,
    this.fragrance,
    this.notes,
    this.paymentMethod,
    this.statusPayment,
    this.totalPrice,
    this.washingType,
    this.pickupDate,
    this.receivedDate,
  });

  factory TransactionRequestModel.fromRawJson(String str) =>
      TransactionRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionRequestModel.fromJson(Map<String, dynamic> json) =>
      TransactionRequestModel(
        customerName: json["customer_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        weight: json["weight"],
        fragrance: json["fragrance"],
        notes: json["notes"],
        paymentMethod: json["payment_method"],
        statusPayment: json["status_payment"],
        totalPrice: json["total_price"],
        washingType: json["washing_type"],
        pickupDate: json["pickup_date"] == null
            ? null
            : DateTime.parse(json["pickup_date"]),
        receivedDate: json["received_date"] == null
            ? null
            : DateTime.parse(json["received_date"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "phone_number": phoneNumber,
        "email": email,
        "weight": weight,
        "fragrance": fragrance,
        "notes": notes,
        "payment_method": paymentMethod,
        "status_payment": statusPayment,
        "total_price": totalPrice,
        "washing_type": washingType,
        "pickup_date": pickupDate?.toIso8601String(),
        "received_date": receivedDate?.toIso8601String(),
      };
}
