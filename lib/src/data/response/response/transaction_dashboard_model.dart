import 'dart:convert';

class TransactionDashboardResponseModel {
  final String? status;
  final String? message;
  final TransactionDashboardResultResponseModel? data;

  TransactionDashboardResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory TransactionDashboardResponseModel.fromRawJson(String str) =>
      TransactionDashboardResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionDashboardResponseModel.fromJson(
          Map<String, dynamic> json) =>
      TransactionDashboardResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : TransactionDashboardResultResponseModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class TransactionDashboardResultResponseModel {
  final int? totalTransactions;
  final int? revenue;
  final int? totalProcess;
  final int? totalReady;
  final int? totalCompleted;

  TransactionDashboardResultResponseModel({
    this.totalTransactions,
    this.revenue,
    this.totalProcess,
    this.totalReady,
    this.totalCompleted,
  });

  factory TransactionDashboardResultResponseModel.fromRawJson(String str) =>
      TransactionDashboardResultResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionDashboardResultResponseModel.fromJson(
          Map<String, dynamic> json) =>
      TransactionDashboardResultResponseModel(
        totalTransactions: json["total_transactions"],
        revenue: json["revenue"],
        totalProcess: json["total_process"],
        totalReady: json["total_ready"],
        totalCompleted: json["total_completed"],
      );

  Map<String, dynamic> toJson() => {
        "total_transactions": totalTransactions,
        "revenue": revenue,
        "total_process": totalProcess,
        "total_ready": totalReady,
        "total_completed": totalCompleted,
      };
}
