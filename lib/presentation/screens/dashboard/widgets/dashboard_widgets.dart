import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget actionButton(String text, Color color, VoidCallback onTap) {
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

Widget statusChip(String status) {
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

Widget infoRow({
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

