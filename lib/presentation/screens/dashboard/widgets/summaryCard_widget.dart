import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget summaryCard(String count, String label, Color bg, Color color) {
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

Widget buildSummaryCards() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: Row(
      children: [
        summaryCard("0", "Pending", Colors.blue.shade50, Colors.blue),
        summaryCard("0", "Completed", Colors.green.shade50, Colors.green),
        summaryCard("0", "In Progress", Colors.orange.shade50, Colors.orange),
      ],
    ),
  );
}
