import 'dart:ui';
import 'package:eato_delivery_partner/core/constants/img_const.dart';
import 'package:eato_delivery_partner/presentation/screens/profile/deliveryPartnerProfile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryPartnerDashboard extends StatefulWidget {
  const DeliveryPartnerDashboard({super.key});

  @override
  State<DeliveryPartnerDashboard> createState() =>
      _DeliveryPartnerDashboardState();
}

class _DeliveryPartnerDashboardState extends State<DeliveryPartnerDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> _orders = [
    // {
    //   "id": "#EATO1234",
    //   "status": "New",
    //   "pickup": "Pizza Hub, Hitech City",
    //   "delivery": "Jubilee Hills, Hyderabad",
    //   "price": "₹299",
    //   "time": "Today • 1:00 PM",
    //   "eta": "25 - 30 min",
    //   "phone": "9876543210"
    // },
    // {
    //   "id": "#EATO1235",
    //   "status": "Accepted",
    //   "pickup": "Biryani Nation, Gachibowli",
    //   "delivery": "Madhapur, Hyderabad",
    //   "price": "₹399",
    //   "time": "Today • 12:40 PM",
    //   "eta": "15 - 20 min",
    //   "phone": "9876543211"
    // },
    // {
    //   "id": "#EATO1236",
    //   "status": "Delivered",
    //   "pickup": "KFC, Gachibowli",
    //   "delivery": "Dilsukhnagar, Hyderabad",
    //   "price": "₹249",
    //   "time": "Today • 12:10 PM",
    //   "eta": "Delivered",
    //   "phone": "9876543212"
    // },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _launchGoogleMaps(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$encodedAddress';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void showCallConfirmation(BuildContext context, String phone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Icon(Icons.phone_in_talk_rounded,
                  size: 48, color: Colors.green),
              const SizedBox(height: 20),
              Text(
                "Call the Customer?",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                phone,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    launchUrl(Uri.parse("tel:$phone"));
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.call, color: Colors.white),
                  label: Text(
                    "Call Now",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showActionDialog(String status, String orderId) {
    String title = status == "New" ? "Accept Order?" : "Mark as Delivered?";
    String message = status == "New"
        ? "Are you sure you want to accept order $orderId?"
        : "Confirm that you have delivered order $orderId?";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text(message, style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: status == "New" ? Colors.green : Colors.orange,
            ),
            child: Text(status == "New" ? "Accept" : "Deliver"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(status == "New"
                    ? "Order $orderId Accepted"
                    : "Order $orderId Delivered"),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _orderCard(Map<String, String> order, BuildContext context) {
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
                children: [
                  Text(
                    order["id"]!,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _statusChip(order["status"]!),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.phone, color: Colors.green),
                    onPressed: () =>
                        showCallConfirmation(context, order["phone"]!),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    order["price"]!,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                order["time"]!,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              ),
              const Divider(height: 24),
              _infoRow(
                icon: Icons.restaurant,
                color: Colors.orange,
                title: "Pickup",
                subtitle: order["pickup"]!,
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _infoRow(
                      icon: Icons.delivery_dining,
                      color: Colors.teal,
                      title: "Delivery",
                      subtitle: order["delivery"]!,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigation, color: Colors.teal),
                    onPressed: () => _launchGoogleMaps(order["delivery"]!),
                  ),
                ],
              ),


              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ETA",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order["eta"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (order["status"] == "New")
                    _actionButton("Accept", Colors.green, () {
                      _showActionDialog("New", order["id"]!);
                    }),
                  if (order["status"] == "Accepted")
                    _actionButton("Deliver", Colors.orange, () {
                      _showActionDialog("Accepted", order["id"]!);
                    }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(String text, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color bgColor;
    if (status == "New") {
      bgColor = Colors.blue.shade100;
    } else if (status == "Accepted") {
      bgColor = Colors.orange.shade100;
    } else {
      bgColor = Colors.green.shade100;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.grey.shade600)),
              Text(subtitle,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrders(String status) {
    final filtered =
        _orders.where((order) => order["status"] == status).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Text(
            "No Orders Found",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          return _orderCard(filtered[index], context);
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue[600],
            child: const Icon(Icons.delivery_dining, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SpeedDelivery",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Delivery Partner",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(Icons.notifications_none, color: Colors.black87, size: 26),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DeliveryPartnerProfileScreen(),
                ),
              );
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: AssetImage(rider), // replace with your image
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          _summaryCard("0", "Pending", Colors.blue.shade50, Colors.blue),
          _summaryCard("0", "Completed", Colors.green.shade50, Colors.green),
          _summaryCard(
              "0", "In Progress", Colors.orange.shade50, Colors.orange),
        ],
      ),
    );
  }

  Widget _summaryCard(String count, String label, Color bg, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(count,
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600, color: color)),
            const SizedBox(height: 4),
            Text(label, style: GoogleFonts.poppins(fontSize: 12, color: color)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Divider(),
            _buildSummaryCards(),
            const SizedBox(height: 8),
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              indicatorColor: Colors.blueAccent,
              tabs: const [
                Tab(text: "New"),
                Tab(text: "Accepted"),
                Tab(text: "Delivered"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOrders("New"),
                  _buildOrders("Accepted"),
                  _buildOrders("Delivered"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
