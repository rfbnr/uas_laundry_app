import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:dartz/dartz.dart';

import '../../core/constants/variables.dart';
import '../response/request/transaction_request_model.dart';
import '../response/response/error_response_model.dart';
import '../response/response/success_response_model.dart';
import '../response/response/transaction_dashboard_model.dart';
import '../response/response/transaction_response_model.dart';

class TransactionRemoteDatasource {
  HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  Future<Either<ErrorResponseModel, TransactionResponseModel>>
      fetchGetTransactionByStatus({
    required String status,
  }) async {
    final response = await http.get(
      Uri.parse("${Variables.baseUrl}/api/transactions?status=$status"),
    );

    if (response.statusCode == 200) {
      return Right(TransactionResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromRawJson(response.body));
    }
  }

  Future<Either<ErrorResponseModel, TransactionDashboardResponseModel>>
      fetchGetDashboardTransaction() async {
    final response = await http.get(
      Uri.parse("${Variables.baseUrl}/api/transaction/dashboard"),
    );

    if (response.statusCode == 200) {
      return Right(
          TransactionDashboardResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromRawJson(response.body));
    }
  }

  Future<Either<ErrorResponseModel, SuccessResponseModel>>
      fetchRequestTransaction({
    required TransactionRequestModel body,
  }) async {
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/transactions"),
      headers: headers,
      body: body.toRawJson(),
    );

    if (response.statusCode == 201) {
      return Right(SuccessResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromRawJson(response.body));
    }
  }

  Future<Either<ErrorResponseModel, SuccessResponseModel>>
      fetchUpdateStatusTransaction({
    required int id,
    required String status,
  }) async {
    final response = await http.post(
      Uri.parse("${Variables.baseUrl}/api/transaction/$id/status"),
      body: {
        "status": status,
      },
    );

    if (response.statusCode == 201) {
      return Right(SuccessResponseModel.fromRawJson(response.body));
    } else {
      return Left(ErrorResponseModel.fromRawJson(response.body));
    }
  }
}
