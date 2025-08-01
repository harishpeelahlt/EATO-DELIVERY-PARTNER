import 'dart:ui';
import 'package:eato_delivery_partner/presentation/cubit/orders/deliverOtpVerification/deliverOtpVerification_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/orders/deliverOtpVerification/deliverOtpVerification_state.dart';
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
            const SnackBar(content: Text("Failed to update status.")),
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
    final isDelivered = status == "DELIVERED";

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
              /// Header: Order Number and Status
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
                      if (!isDelivered)
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

              /// Address Info (Pickup & Delivery)
              if (!isDelivered) ...[
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
                      onPressed: () => launchGoogleMaps(
                          order.userAddress?.addressLine1 ?? ""),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              /// Action Button (Pick Up / Deliver / Reject / Return)
              Row(
                children: [
                  if (!isDelivered)
                    actionButton("Reject", Colors.red, () {
                      context.read<UpdateOrderStatusCubit>().updateOrderStatus(
                            order.orderNumber.toString(),
                            "DELIVERY_REJECTED ",
                          );
                    }),
                  const Spacer(),
                  if (["CONFIRMED", "PENDING", "OUT_FOR_DELIVERY"]
                      .contains(status))
                    actionButton("Pick Up", Colors.green, () {
                      context.read<UpdateOrderStatusCubit>().updateOrderStatus(
                            order.orderNumber.toString(),
                            "PICKED_UP",
                          );
                    }),
                  if (status == "PICKED_UP")
                    Row(
                      children: [
                        actionButton("Return", Colors.red, () {
                          context
                              .read<UpdateOrderStatusCubit>()
                              .updateOrderStatus(
                                order.orderNumber.toString(),
                                "RETURNED",
                              );
                        }),
                        const SizedBox(width: 8),
                        actionButton("Deliver", Colors.orange, () {
                          showOtpDialog(context, order);
                        }),
                      ],
                    ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void showOtpDialog(BuildContext context, dynamic order) {
    final TextEditingController otpController = TextEditingController();
    final orderId = order.orderNumber.toString();

    context.read<DeliverOtpCubit>().triggerOtp(orderId);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Enter Delivery OTP", style: GoogleFonts.poppins()),
          content: BlocBuilder<DeliverOtpCubit, DeliverOtpState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state is DeliverOtpLoading)
                    const CircularProgressIndicator(),
                  if (state is DeliverOtpFailure)
                    Text(state.message,
                        style: const TextStyle(color: Colors.red)),
                  TextField(
                    controller: otpController,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "OTP",
                      counterText: "",
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text("Resend"),
                        onPressed: () {
                          context.read<DeliverOtpCubit>().triggerOtp(orderId);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        child: const Text("Verify & Deliver"),
                        onPressed: () async {
                          final otp = otpController.text.trim();
                          if (otp.length == 6) {
                            await context
                                .read<DeliverOtpCubit>()
                                .verifyOtp(orderId, otp);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter full OTP")),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            )
          ],
        );
      },
    );

    context.read<DeliverOtpCubit>().stream.listen((state) {
      if (state is DeliverOtpVerifySuccess) {
        Navigator.pop(context);
        context
            .read<UpdateOrderStatusCubit>()
            .updateOrderStatus(orderId, "DELIVERED");
      }
    });
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
