import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/spaces.dart';
import '../bloc/transaction_list_bloc.dart';
import 'transcation_card_item_widget.dart';

class TabComplete extends StatefulWidget {
  const TabComplete({super.key});

  @override
  State<TabComplete> createState() => _TabCompleteState();
}

class _TabCompleteState extends State<TabComplete> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionListBloc>().add(
          LoadTransactionByStatusComplete(),
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
              switch (state.statusComplete) {
                case TransactionCompleteStatus.loading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case TransactionCompleteStatus.failure:
                  final message = state.error?.message ?? "An error occurred";

                  return Center(
                    child: Text(message),
                  );

                case TransactionCompleteStatus.success:
                  final data = state.transactionsComplete;

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
