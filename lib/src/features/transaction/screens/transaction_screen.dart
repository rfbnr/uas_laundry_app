import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../data/datasources/transaction_remote_datasource.dart';
import '../blocs/transaction_list_bloc/transaction_list_bloc.dart';
import '../blocs/transaction_update_bloc/transaction_update_bloc.dart';
import '../widgets/tab_complete.dart';
import '../widgets/tab_process.dart';
import '../widgets/tab_ready.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionListBloc(
            transactionRemoteDatasource: TransactionRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => TransactionUpdateBloc(
            transactionRemoteDatasource: TransactionRemoteDatasource(),
          ),
        ),
      ],
      child: const TransactionScreenView(),
    );
  }
}

class TransactionScreenView extends StatelessWidget {
  const TransactionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionUpdateBloc, TransactionUpdateState>(
      listener: (context, state) {
        if (state.updateReadyStatus == UpdateReadyStatus.loading) {
          EasyLoading.dismiss();
          EasyLoading.show(
            status: "loading kirim data...",
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
        } else if (state.updateReadyStatus == UpdateReadyStatus.failure) {
          final message = state.error?.message ?? "Error";

          EasyLoading.dismiss();
          EasyLoading.showError(
            message,
            duration: const Duration(seconds: 4),
          );
        } else if (state.updateReadyStatus == UpdateReadyStatus.success) {
          context.read<TransactionListBloc>().add(
                LoadTransactionByStatusReady(),
              );

          final message = state.result?.message ?? "Success";

          EasyLoading.dismiss();
          EasyLoading.showSuccess(message);
        }

        if (state.updateProcessStatus == UpdateProcessStatus.loading) {
          EasyLoading.dismiss();
          EasyLoading.show(
            status: "loading kirim data...",
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
        } else if (state.updateProcessStatus == UpdateProcessStatus.failure) {
          final message = state.error?.message ?? "Error";

          EasyLoading.dismiss();
          EasyLoading.showError(
            message,
            duration: const Duration(seconds: 4),
          );
        } else if (state.updateProcessStatus == UpdateProcessStatus.success) {
          context.read<TransactionListBloc>().add(
                LoadTransactionByStatusProcess(),
              );

          final message = state.result?.message ?? "Success";

          EasyLoading.dismiss();
          EasyLoading.showSuccess(message);
        }
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Transactions'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Process'),
                Tab(text: 'Ready'),
                Tab(text: 'Complete'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TabProcess(),
              TabReady(),
              TabComplete(),
            ],
          ),
        ),
      ),
    );
  }
}
