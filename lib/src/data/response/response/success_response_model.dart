import 'dart:convert';

class SuccessResponseModel {
  final String? status;
  final String? message;

  SuccessResponseModel({
    this.status,
    this.message,
  });

  factory SuccessResponseModel.fromRawJson(String str) =>
      SuccessResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuccessResponseModel.fromJson(Map<String, dynamic> json) =>
      SuccessResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
