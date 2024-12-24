import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/spaces.dart';
import '../bloc/transaction_list_bloc.dart';
import 'transcation_card_item_widget.dart';

class TabReady extends StatefulWidget {
  const TabReady({super.key});

  @override
  State<TabReady> createState() => _TabReadyState();
}

class _TabReadyState extends State<TabReady> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionListBloc>().add(
          LoadTransactionByStatusReady(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SpaceHeight(30),
          BlocBuilder<TransactionListBloc, TransactionListState>(
            builder: (context, state) {
              switch (state.statusReady) {
                case TransactionReadyStatus.loading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case TransactionReadyStatus.failure:
                  final message = state.error?.message ?? "An error occurred";

                  return Center(
                    child: Text(message),
                  );

                case TransactionReadyStatus.success:
                  final data = state.transactionsReady;

                  return data?.isEmpty ?? true
                      ? const Center(
                          child: Text("No data found"),
                        )
                      : ListView.builder(
                          itemCount: data?.length ?? 0,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final item = data![index];

                            return TransactionCardItemWidget(
                              data: item,
                            );
                          },
                        );

                default:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
