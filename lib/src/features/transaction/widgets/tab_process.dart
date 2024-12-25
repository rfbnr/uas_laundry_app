import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_laundry_app/src/features/transaction/blocs/transaction_list_bloc/transaction_list_bloc.dart';

import '../../../core/components/spaces.dart';
import '../blocs/transaction_update_bloc/transaction_update_bloc.dart';
import 'transcation_card_item_widget.dart';

class TabProcess extends StatefulWidget {
  const TabProcess({super.key});

  @override
  State<TabProcess> createState() => _TabProcessState();
}

class _TabProcessState extends State<TabProcess> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionListBloc>().add(
          LoadTransactionByStatusProcess(),
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
              switch (state.statusProcess) {
                case TransactionProcessStatus.loading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                case TransactionProcessStatus.failure:
                  final message = state.error?.message ?? "An error occurred";

                  return Center(
                    child: Text(message),
                  );

                case TransactionProcessStatus.success:
                  final data = state.transactionsProcess;

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

                            return TranscationCardItemWidget(
                              data: item,
                              onPressed: () {
                                Navigator.pop(context);

                                context.read<TransactionUpdateBloc>().add(
                                      TransactionUpdateProcessStatus(
                                        id: item.id ?? 0,
                                        status: "ready",
                                      ),
                                    );
                              },
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
