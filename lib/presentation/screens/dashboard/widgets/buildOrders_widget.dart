import 'dart:ui';
import 'package:eato_delivery_partner/presentation/cubit/orders/fetchOrders/fetchOrders_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/orders/fetchOrders/fetchOrders_state.dart';
import 'package:eato_delivery_partner/presentation/screens/dashboard/widgets/dashboard_widgets.dart';
import 'package:eato_delivery_partner/presentation/screens/dashboard/widgets/orderCard_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eato_delivery_partner/presentation/cubit/orders/updateOrderStatus/updateOrderStatus_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/orders/updateOrderStatus/updateOrderStatus_state.dart';

class BuildOrders extends StatefulWidget {
  final String status;
  final String partnerId;

  const BuildOrders(this.status, this.partnerId, {super.key});

  @override
  State<BuildOrders> createState() => _BuildOrdersState();
}

class _BuildOrdersState extends State<BuildOrders> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 0;
  final int pageSize = 10;
  bool isLoadingMore = false;
  bool allPagesLoaded = false;
  List<dynamic> allOrders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !isLoadingMore &&
          !allPagesLoaded) {
        currentPage++;
        _fetchOrders(isPaginating: true);
      }
    });
  }

  void _fetchOrders({bool isPaginating = false}) {
    final params = {
      "partnerId": widget.partnerId,
      "page": currentPage,
      "size": pageSize,
    };

    if (isPaginating) setState(() => isLoadingMore = true);

    context.read<FetchOrdersCubit>().fetchOrders(params).then((_) {
      if (mounted) setState(() => isLoadingMore = false);
    });
  }

  List<dynamic> _filterOrders(List<dynamic> orders) {
    final status = widget.status.toUpperCase();
    return orders.where((order) {
      final orderStatus = (order.orderStatus ?? "").toUpperCase();
      if (status == "ACCEPTED") {
        return [
          "CONFIRMED",
          "PENDING",
          "PICKED_UP",
          "PREPARING",
          "READY_FOR_PICKUP",
          "OUT_FOR_DELIVERY"
        ].contains(orderStatus);
      } else if (status == "DELIVERED") {
        return orderStatus == "DELIVERED";
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateOrderStatusCubit, UpdateOrderStatusState>(
      listener: (context, state) {
        if (state is UpdateOrderStatusLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Updating order status...")),
          );
        } else if (state is UpdateOrderStatusSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Order status updated.")),
          );
          currentPage = 0;
          allOrders.clear();
          _fetchOrders();
        } else if (state is UpdateOrderStatusFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed")),
          );
        }
      },
      child: BlocConsumer<FetchOrdersCubit, FetchOrdersState>(
        listener: (context, state) {
          if (state is FetchOrdersSuccess) {
            final newOrders = _filterOrders(state.orders.data?.content ?? []);
            setState(() {
              if (currentPage == 0) {
                allOrders = newOrders;
              } else {
                allOrders.addAll(newOrders);
              }
              allPagesLoaded = state.orders.data?.last ?? true;
            });
          }
        },
        builder: (context, state) {
          if (state is FetchOrdersLoading && currentPage == 0) {
            return _buildLoading();
          }

          if (state is FetchOrdersFailure) {
            return _buildError("Failed to Fetch Orders");
          }

          if (allOrders.isEmpty) {
            return _buildEmpty();
          }

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: allOrders.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < allOrders.length) {
                return buildOrderCard(context, allOrders[index]);
              } else {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CupertinoActivityIndicator()),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CupertinoActivityIndicator());

  Widget _buildError(String message) =>
      Center(child: Text(message, style: GoogleFonts.poppins()));

  Widget _buildEmpty() => const Center(
        child: Text("No accepted or delivered orders found."),
      );

  Widget buildOrderCard(BuildContext context, dynamic order) {
    final status = (order.orderStatus ?? "").toUpperCase();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order #${getLast4Digits(order.orderNumber)}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            )),
                        const SizedBox(height: 4),
                        statusChip(formattedStatus(status)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.phone, color: Colors.green),
                        onPressed: () => showCallConfirmation(
                            context, order.mobileNumber ?? "0000000000"),
                      ),
                      Text("₹${order.totalAmount?.toStringAsFixed(2) ?? '--'}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: infoRow(
                      icon: Icons.restaurant,
                      color: Colors.orange,
                      title: "Pickup",
                      subtitle: order.businessAddress?.addressLine1 ?? "N/A",
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigation, color: Colors.orange),
                    onPressed: () => launchGoogleMaps(
                        order.businessAddress?.addressLine1 ?? ""),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: infoRow(
                      icon: Icons.delivery_dining,
                      color: Colors.teal,
                      title: "Delivery",
                      subtitle: order.userAddress?.addressLine1 ?? "N/A",
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigation, color: Colors.teal),
                    onPressed: () =>
                        launchGoogleMaps(order.userAddress?.addressLine1 ?? ""),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Spacer(),
                  if (["CONFIRMED", "PENDING", "OUT_FOR_DELIVERY"]
                      .contains(status))
                    actionButton("Pick Up", Colors.green, () {
                      context.read<UpdateOrderStatusCubit>().updateOrderStatus(
                            order.orderNumber.toString(),
                            "PICKED_UP",
                          );
                    }),
                  if (["PICKED_UP"].contains(status))
                    actionButton("Deliver", Colors.orange, () {
                      context.read<UpdateOrderStatusCubit>().updateOrderStatus(
                            order.orderNumber.toString(),
                            "DELIVERED",
                          );
                    }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

String formattedStatus(String status) {
  return status.replaceAll('_', ' ');
}

String getLast4Digits(String? orderNumber) {
  if (orderNumber == null || orderNumber.length <= 4) {
    return orderNumber ?? "----";
  }
  return orderNumber.substring(orderNumber.length - 4);
}
