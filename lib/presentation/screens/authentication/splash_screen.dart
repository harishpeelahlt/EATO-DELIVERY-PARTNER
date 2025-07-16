import 'dart:async';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_state.dart';
import 'package:eato_delivery_partner/presentation/screens/authentication/login_screen.dart';
import 'package:eato_delivery_partner/presentation/screens/authentication/nameInput_screen.dart';
import 'package:eato_delivery_partner/presentation/screens/dashboard/deliveryPartnerDashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigateManually = false;

  @override
  void initState() {
    super.initState();
    _startNavigationLogic();
  }

  Future<void> _startNavigationLogic() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('TOKEN');
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
      _navigateTo(const LoginScreen());
      return;
    }

    if (token == null || token.isEmpty) {
      _navigateTo(const LoginScreen());
      return;
    }

    await context.read<CurrentCustomerCubit>().GetCurrentCustomer(context);
    setState(() => _navigateManually = true);
  }

  void _navigateTo(Widget screen) {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentCustomerCubit, CurrentCustomerState>(
      listener: (context, state) {
        if (!_navigateManually) return;

        if (state is CurrentCustomerLoaded) {
          final eato = state.currentCustomerModel.eato ?? false;
          _navigateTo(eato
              ? const DeliveryPartnerDashboard()
              : const NameInputScreen());
        } else {
          _navigateTo(const LoginScreen());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Eato Partner',
                style: GoogleFonts.montserrat(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Delivering on time, every time',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
