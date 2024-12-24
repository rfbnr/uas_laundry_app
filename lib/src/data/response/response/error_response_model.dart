import 'dart:convert';

class ErrorResponseModel {
  final int? status;
  final String? message;

  ErrorResponseModel({
    this.status,
    this.message,
  });

  factory ErrorResponseModel.fromRawJson(String str) =>
      ErrorResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
