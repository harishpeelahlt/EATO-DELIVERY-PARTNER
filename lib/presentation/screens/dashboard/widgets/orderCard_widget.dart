import 'dart:ui';
import 'package:eato_delivery_partner/presentation/screens/dashboard/widgets/dashboard_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

bool isOnline = true;

void launchGoogleMaps(String address) async {
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

void showActionDialog(String status, String orderId, BuildContext context) {
  String title = status == "New" ? "Accept Order?" : "Mark as Delivered?";
  String message = status == "New"
      ? "Are you sure you want to accept order $orderId?"
      : "Confirm that you have delivered order $orderId?";

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title:
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
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

class OrderCardWidget extends StatelessWidget {
  final Map<String, String> order;
  final void Function(String status, String orderId, BuildContext context)
      showActionDialog;
  final void Function(BuildContext context, String phone) showCallConfirmation;

  const OrderCardWidget({
    super.key,
    required this.order,
    required this.showActionDialog,
    required this.showCallConfirmation,
  });

  String formatStatus(String status) {
    return status.replaceAll('_', ' ').split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Order ID and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order["id"]!.substring(order["id"]!.length - 4)}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                statusChip(order["status"]!),
              ],
            ),
            const SizedBox(height: 8),

            // Row 2: Address
            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    order["address"]!,
                    style: GoogleFonts.poppins(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row 3: Phone icon aligned right
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.phone, color: Colors.green),
                onPressed: () => showCallConfirmation(context, order["phone"]!),
              ),
            ),

            // Row 4: ETA, Price, and Action button
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ETA column
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

                // Price
                Text(
                  order["price"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                // Action button
                if (order["status"] == "New")
                  actionButton("Accept", Colors.green, () {
                    showActionDialog("New", order["id"]!, context);
                  }),
                if (order["status"] == "Accepted")
                  actionButton("Deliver", Colors.orange, () {
                    showActionDialog("Accepted", order["id"]!, context);
                  }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
