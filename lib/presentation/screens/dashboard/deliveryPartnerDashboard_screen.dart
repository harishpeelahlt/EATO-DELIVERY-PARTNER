import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  bool isOnline = true;
  Position? currentPosition;

  List<DeliveryOrder> orders = [
    DeliveryOrder(
      id: '1001',
      customerName: 'Rakesh Sharma',
      address: 'Madhapur, Hyderabad',
      restaurant: 'Pizza Palace',
      phone: '+919999999999',
      status: 'New',
      distance: '2.5 km',
      eta: '15 min',
      imageUrl: 'https://i.pravatar.cc/100?img=14',
    ),
    DeliveryOrder(
      id: '1002',
      customerName: 'Sneha Reddy',
      address: 'Kondapur, Hyderabad',
      restaurant: 'Burger Hub',
      phone: '+918888888888',
      status: 'Ongoing',
      distance: '1.2 km',
      eta: '8 min',
      imageUrl: 'https://i.pravatar.cc/100?img=15',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _getLiveLocation();
  }

  Future<void> _getLiveLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) return;
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Geolocator.getPositionStream().listen((Position position) {
      setState(() => currentPosition = position);
    });
  }

  void callCustomer(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void navigateToAddress(String address) async {
    final Uri mapsUri = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}");
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    }
  }

  void openRiderLiveLocation() async {
    if (currentPosition != null) {
      final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${currentPosition!.latitude},${currentPosition!.longitude}',
      );
      await launchUrl(googleMapsUrl);
    }
  }

  void updateOrderStatus(DeliveryOrder order, String newStatus) {
    setState(() {
      final index = orders.indexWhere((o) => o.id == order.id);
      if (index != -1) {
        orders[index] = orders[index].copyWith(status: newStatus);
      }
    });
  }

  void showOrderDetailsModal(DeliveryOrder order) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order #${order.id}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Customer: ${order.customerName}'),
            Text('Phone: ${order.phone}'),
            Text('Address: ${order.address}'),
            Text('Restaurant: ${order.restaurant}'),
            Text('ETA: ${order.eta}, Distance: ${order.distance}'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => callCustomer(order.phone),
                  icon: const Icon(Icons.phone),
                  label: const Text('Call'),
                ),
                ElevatedButton.icon(
                  onPressed: () => navigateToAddress(order.address),
                  icon: const Icon(Icons.map),
                  label: const Text('Navigate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF10B981);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/150?img=18'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Welcome Back",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12)),
                            Text("Jagadeesh",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.navigation_outlined,
                            color: Colors.white),
                        onPressed: openRiderLiveLocation,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isOnline ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isOnline ? Icons.check_circle : Icons.cancel,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isOnline ? "Online" : "Offline",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: isOnline,
                        onChanged: (val) => setState(() => isOnline = val),
                        activeColor: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: primaryColor,
              tabs: const [
                Tab(text: 'New'),
                Tab(text: 'Ongoing'),
                Tab(text: 'History'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: ['New', 'Ongoing', 'History'].map(_orderList).toList(),
            ),
          ),
        ],
      ),
    );
  }


  Widget _orderList(String status) {
    final filtered = orders.where((o) => o.status == status).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (_, i) {
        final order = filtered[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(order.imageUrl),
                      radius: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(order.customerName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Chip(
                      label: Text(order.eta,
                          style: const TextStyle(color: Colors.white)),
                      backgroundColor: const Color(0xFF10B981),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("📍 ${order.address}",
                    style: const TextStyle(color: Colors.grey)),
                Text("🍽️ ${order.restaurant}",
                    style: const TextStyle(color: Colors.grey)),
                Text("🚗 ${order.distance}",
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => showOrderDetailsModal(order),
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      label: const Text("View"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black,
                      ),
                    ),
                    if (order.status == 'New')
                      ElevatedButton(
                        onPressed: () => updateOrderStatus(order, 'Ongoing'),
                        child: const Text("Accept"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      )
                    else if (order.status == 'Ongoing')
                      ElevatedButton(
                        onPressed: () => updateOrderStatus(order, 'History'),
                        child: const Text("Delivered"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                      ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DeliveryOrder {
  final String id;
  final String customerName;
  final String address;
  final String restaurant;
  final String phone;
  final String status;
  final String distance;
  final String eta;
  final String imageUrl;

  DeliveryOrder({
    required this.id,
    required this.customerName,
    required this.address,
    required this.restaurant,
    required this.phone,
    required this.status,
    required this.distance,
    required this.eta,
    required this.imageUrl,
  });

  DeliveryOrder copyWith({String? status}) {
    return DeliveryOrder(
      id: id,
      customerName: customerName,
      address: address,
      restaurant: restaurant,
      phone: phone,
      status: status ?? this.status,
      distance: distance,
      eta: eta,
      imageUrl: imageUrl,
    );
  }
}
