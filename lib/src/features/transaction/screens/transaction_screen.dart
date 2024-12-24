import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/transaction_remote_datasource.dart';
import '../bloc/transaction_list_bloc.dart';
import '../widgets/tab_complete.dart';
import '../widgets/tab_process.dart';
import '../widgets/tab_ready.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionListBloc(
        transactionRemoteDatasource: TransactionRemoteDatasource(),
      ),
      child: const TransactionScreenView(),
    );
  }
}

class TransactionScreenView extends StatelessWidget {
  const TransactionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
    );
  }
}
