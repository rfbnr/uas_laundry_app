import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../data/datasources/transaction_remote_datasource.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../transaction/blocs/transaction_list_bloc/transaction_list_bloc.dart';
import '../../transaction/screens/transaction_create_screen.dart';
import '../../transaction/widgets/transcation_card_item_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_dashboard_transaction_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetUserLogin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            transactionRemoteDatasource: TransactionRemoteDatasource(),
          )..add(
              HomeLoadDashboardTransaction(),
            ),
        ),
        BlocProvider(
          create: (context) => TransactionListBloc(
            transactionRemoteDatasource: TransactionRemoteDatasource(),
          )..add(
              LoadTransactionByStatusComplete(),
            ),
        ),
      ],
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width,
                        100,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpaceHeight(30),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                              ),
                              SpaceWidth(16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, state) {
                                        final hour = DateTime.now().hour;
                                        final time = hour == 4 && hour < 10
                                            ? "Pagi"
                                            : hour == 10 && hour < 15
                                                ? "Siang"
                                                : hour == 15 && hour < 18
                                                    ? "Sore"
                                                    : "Malam";

                                        switch (state.dataStatus) {
                                          case DataStatus.failure:
                                            return Text(
                                              "Selamat $time, ERROR",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );

                                          case DataStatus.success:
                                            final data = state.dataUser!;

                                            return Text(
                                              "Selamat $time, ${data.name ?? "-"}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );

                                          default:
                                            return Text(
                                              "Selamat $time, ANONYMOUS",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                        }
                                      },
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Selamat Bekerja",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SpaceHeight(100),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case HomeStatus.loading:
                          return HomeDashboardTransactionWidget(
                            totalTransaction: 0,
                            totalRevenue: 0,
                            totalProcess: 0,
                            totalReady: 0,
                            totalCompleted: 0,
                          );

                        case HomeStatus.failure:
                          return HomeDashboardTransactionWidget(
                            totalTransaction: 0,
                            totalRevenue: 0,
                            totalProcess: 0,
                            totalReady: 0,
                            totalCompleted: 0,
                          );

                        case HomeStatus.success:
                          final data = state.dashboard;

                          return HomeDashboardTransactionWidget(
                            totalTransaction: data?.totalTransactions ?? 0,
                            totalRevenue: data?.revenue ?? 0,
                            totalProcess: data?.totalProcess ?? 0,
                            totalReady: data?.totalReady ?? 0,
                            totalCompleted: data?.totalCompleted ?? 0,
                          );

                        default:
                          return HomeDashboardTransactionWidget(
                            totalTransaction: 0,
                            totalRevenue: 0,
                            totalProcess: 0,
                            totalReady: 0,
                            totalCompleted: 0,
                          );
                      }
                    },
                  ),
                )
              ],
            ),
            SpaceHeight(120),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Button.filled(
                label: "Transaksi Baru",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionCreateScreen(),
                    ),
                  );
                },
              ),
            ),
            SpaceHeight(40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    "Transaksi Selesai",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SpaceHeight(10),
                BlocBuilder<TransactionListBloc, TransactionListState>(
                  builder: (context, state) {
                    switch (state.statusComplete) {
                      case TransactionCompleteStatus.loading:
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      case TransactionCompleteStatus.failure:
                        final message =
                            state.error?.message ?? "An error occurred";

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
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = data![index];

                                  return TranscationCardItemWidget(
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
          ],
        ),
      ),
    );
  }
}
