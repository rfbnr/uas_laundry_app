import 'dart:convert';

class TransactionResponseModel {
  final String? status;
  final String? message;
  final List<TransactionResultResponseModel>? data;

  TransactionResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory TransactionResponseModel.fromRawJson(String str) =>
      TransactionResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TransactionResultResponseModel>.from(
                json["data"]!.map(
                  (x) => TransactionResultResponseModel.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(
                data!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class TransactionResultResponseModel {
  final int? id;
  final String? customerName;
  final String? phoneNumber;
  final dynamic email;
  final int? weight;
  final String? fragrance;
  final String? notes;
  final String? status;
  final String? paymentMethod;
  final String? statusPayment;
  final int? totalPrice;
  final String? washingType;
  final DateTime? pickupDate;
  final int? remainingDayToPickup;
  final DateTime? receivedDate;
  final DateTime? completedDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionResultResponseModel({
    this.id,
    this.customerName,
    this.phoneNumber,
    this.email,
    this.weight,
    this.fragrance,
    this.notes,
    this.status,
    this.paymentMethod,
    this.statusPayment,
    this.totalPrice,
    this.washingType,
    this.pickupDate,
    this.remainingDayToPickup,
    this.receivedDate,
    this.completedDate,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionResultResponseModel.fromRawJson(String str) =>
      TransactionResultResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionResultResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResultResponseModel(
        id: json["id"],
        customerName: json["customer_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        weight: json["weight"],
        fragrance: json["fragrance"],
        notes: json["notes"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        statusPayment: json["status_payment"],
        totalPrice: json["total_price"],
        washingType: json["washing_type"],
        pickupDate: json["pickup_date"] == null
            ? null
            : DateTime.parse(json["pickup_date"]),
        remainingDayToPickup: json["remaining_day_to_pickup"],
        receivedDate: json["received_date"] == null
            ? null
            : DateTime.parse(json["received_date"]),
        completedDate: json["completed_date"] == null
            ? null
            : DateTime.parse(json["completed_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "phone_number": phoneNumber,
        "email": email,
        "weight": weight,
        "fragrance": fragrance,
        "notes": notes,
        "status": status,
        "payment_method": paymentMethod,
        "status_payment": statusPayment,
        "total_price": totalPrice,
        "washing_type": washingType,
        "pickup_date": pickupDate?.toIso8601String(),
        "remaining_day_to_pickup": remainingDayToPickup,
        "received_date": receivedDate?.toIso8601String(),
        "completed_date": completedDate?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
