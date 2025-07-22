import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApprovalPendingScreen extends StatelessWidget {
  const ApprovalPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hourglass_top_rounded, size: 100, color: Colors.amber),
              const SizedBox(height: 20),
              Text(
                'Approval Pending',
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your account is under review.\nWe will notify you once approved.',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.amber,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              //   ),
              //   child: const Text(
              //     'Back to Login',
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
