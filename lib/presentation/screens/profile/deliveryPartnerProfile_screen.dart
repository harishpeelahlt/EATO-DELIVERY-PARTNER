import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eato_delivery_partner/components/custom_snackbar.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_state.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/deleteAccount/deleteAccount_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/deleteAccount/deleteAccount_state.dart';
import 'package:eato_delivery_partner/presentation/screens/authentication/login_screen.dart';
import 'package:eato_delivery_partner/presentation/screens/profile/logout.dart';

class DeliveryPartnerProfileScreen extends StatefulWidget {
  const DeliveryPartnerProfileScreen({super.key});

  @override
  State<DeliveryPartnerProfileScreen> createState() =>
      _DeliveryPartnerProfileScreenState();
}

class _DeliveryPartnerProfileScreenState
    extends State<DeliveryPartnerProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CurrentCustomerCubit>().GetCurrentCustomer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text("My Profile",
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildProfileCard(),
            const SizedBox(height: 28),
            _buildOption(
              icon: Icons.logout_rounded,
              title: "Logout",
              color: Colors.orange,
              onTap: () => _showBottomSheet(const LogOutCnfrmBottomSheet()),
            ),
            const SizedBox(height: 12),
            _buildOption(
              icon: Icons.delete_forever_rounded,
              title: "Delete Account",
              color: Colors.redAccent,
              isDestructive: true,
              onTap: () => _showBottomSheet(_buildDeleteSheet(), true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return BlocBuilder<CurrentCustomerCubit, CurrentCustomerState>(
      builder: (context, state) {
        if (state is CurrentCustomerLoading) {
          return const CupertinoActivityIndicator();
        } else if (state is CurrentCustomerError) {
          return _buildError(state.message);
        } else if (state is CurrentCustomerLoaded) {
          final user = state.currentCustomerModel;
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person_outline_rounded,
                      size: 36, color: Colors.deepPurple),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.fullName ?? "No Name",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(user.primaryContact ?? "No Number",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildError(String message) => Column(
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(height: 8),
          Text(message, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () =>
                context.read<CurrentCustomerCubit>().GetCurrentCustomer(context),
            child: const Text("Retry"),
          )
        ],
      );

  BoxDecoration _cardDecoration() => BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.shade100.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      );

  Widget _buildOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) =>
      Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            child: Row(
              children: [
                Icon(icon, size: 26, color: color),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDestructive ? Colors.red : Colors.black),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      );

  void _showBottomSheet(Widget child, [bool isScrollControlled = false]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      builder: (_) => child,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  Widget _buildDeleteSheet() {
    return BlocProvider.value(
      value: context.read<DeleteAccountCubit>(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade400, size: 48),
            const SizedBox(height: 16),
            const Text("Are you sure?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            const SizedBox(height: 12),
            const Text(
              "This will permanently delete your account and all delivery data.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"))),
                const SizedBox(width: 12),
                Expanded(
                  child:
                      BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
                    listener: (context, state) async {
                      if (state is DeleteAccountSuccess) {
                        Navigator.pop(context);
                        CustomSnackbars.showSuccessSnack(
                          context: context,
                          title: "Deleted",
                          message: "Your account has been deleted.",
                        );
                        final prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      } else if (state is DeleteAccountFailure) {
                        CustomSnackbars.showErrorSnack(
                          context: context,
                          title: "Error",
                          message: "Failed to delete account.",
                        );
                      }
                    },
                    builder: (context, state) => ElevatedButton(
                      onPressed: state is DeleteAccountLoading
                          ? null
                          : () => context
                              .read<DeleteAccountCubit>()
                              .deleteAccount(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      child: state is DeleteAccountLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Text("Delete"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
