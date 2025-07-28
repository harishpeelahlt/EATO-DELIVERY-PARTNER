import 'package:eato_delivery_partner/components/custom_topbar.dart';
import 'package:eato_delivery_partner/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(title: "Terms & Conditions"),
       body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section("1. Acceptance of Terms",
                  "By registering or using the Eato Delivery Partner App, you agree to abide by these Terms and Conditions. If you do not agree, please refrain from using the app."),
              _section("2. Eligibility",
                  "You must be at least 18 years old and legally capable of entering into agreements to use the app."),
              _section("3. Account & Verification",
                  "You must provide accurate personal details including identification documents. We reserve the right to approve or reject accounts based on verification."),
              _section("4. Use of Location",
                  "The app collects your real-time location to assign orders, track deliveries, and provide updates to restaurants and customers."),
              _section("5. Delivery Responsibilities",
                  "You are responsible for timely and safe delivery of orders. Any misconduct or repeated delivery failures may result in account suspension."),
              _section("6. Payments",
                  "All delivery earnings are settled offline. The app does not contain any in-app wallet or payment processing features."),
              _section("7. Data Usage",
                  "We collect personal, location, and delivery-related data as outlined in our Privacy Policy. Your information is used to facilitate services and is not sold or rented."),
              _section("8. Third-Party Services",
                  "We may integrate services like Google Maps for navigation. Your use of such services is subject to their respective terms and privacy policies."),
              _section("9. Security",
                  "We implement measures to secure your data, but no system can guarantee 100% protection. Use the app responsibly and report any issues promptly."),
              _section("10. Termination",
                  "We may suspend or terminate your account for violating terms, misusing the platform, or engaging in fraudulent activity."),
              _section("11. Modifications to Terms",
                  "These Terms may be updated from time to time. Significant changes will be communicated through the app or email."),
              _section("12. Contact Information",
                  "For any concerns, contact us at:\n\nHAVE LIFE TECH SOLUTIONS\nEmail: support@eatoapp.in\nPhone: +91-9705047662\nAnakapalle, Visakhapatnam, India"),
              const SizedBox(height: 24),
              // Center(
              //   child: Text(
              //     "Effective Date: 22nd July 2025",
              //     style: GoogleFonts.poppins(
              //       fontSize: 12,
              //       color: Colors.grey,
              //     ),
              //   ),
              // ),
              // Center(
              //   child: Text(
              //     "Version 1.0",
              //     style: GoogleFonts.poppins(
              //       fontSize: 12,
              //       color: Colors.grey,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
  Widget _section(String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
