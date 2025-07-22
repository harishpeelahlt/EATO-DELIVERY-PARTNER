import 'dart:ui';
import 'package:eato_delivery_partner/core/constants/img_const.dart';
import 'package:eato_delivery_partner/presentation/screens/profile/deliveryPartnerProfile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eato_delivery_partner/presentation/cubit/availability/availability_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/partnerDetails/partnerDetails_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/partnerDetails/partnerDetails_state.dart';
import 'package:eato_delivery_partner/presentation/screens/dashboard/widgets/buildOrders_widget.dart';
import 'package:eato_delivery_partner/presentation/screens/dashboard/widgets/summaryCard_widget.dart';

class DeliveryPartnerDashboard extends StatefulWidget {
  const DeliveryPartnerDashboard({super.key});

  @override
  State<DeliveryPartnerDashboard> createState() =>
      _DeliveryPartnerDashboardState();
}

class _DeliveryPartnerDashboardState extends State<DeliveryPartnerDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<PartnerDetailsCubit>().fetchPartnerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocBuilder<PartnerDetailsCubit, PartnerDetailsState>(
          builder: (context, state) {
            if (state is PartnerDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PartnerDetailsLoaded) {
              final partnerId =
                  state.partnerDetails.data?.deliveryPartnerId ?? '';
              return Column(
                children: [
                  buildHeader(context, isOnline, (val) {
                    setState(() => isOnline = val);
                    context.read<AvailabilityCubit>().updateAvailability(val);
                  }),
                  const Divider(),
                  buildSummaryCards(),
                  const SizedBox(height: 8),
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    labelStyle:
                        GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    indicatorColor: Colors.blueAccent,
                    tabs: const [
                      // Tab(text: "New"),
                      Tab(text: "Accepted"),
                      Tab(text: "Delivered"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // BuildOrders("New", partnerId),
                        BuildOrders("Accepted", partnerId),
                        BuildOrders("Delivered", partnerId),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is PartnerDetailsError) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget buildHeader(
    BuildContext context,
    bool isOnline,
    ValueChanged<bool> onToggle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section: Title + Online Toggle
          Row(
            children: [
              // App Title
              Text(
                "Speed Delivery",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 12),

              // Online/Offline Label + Switch
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isOnline ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      isOnline ? Icons.circle : Icons.circle_outlined,
                      size: 10,
                      color: isOnline ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isOnline ? "Online" : "Offline",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isOnline ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Transform.scale(
                      scale: 0.85,
                      child: Switch(
                        value: isOnline,
                        onChanged: onToggle,
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),

          // Right Section: Profile Avatar
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeliveryPartnerProfileScreen(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(rider), // Your image asset
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
