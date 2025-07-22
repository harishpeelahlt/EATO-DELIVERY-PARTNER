import 'dart:async';
import 'package:eato_delivery_partner/core/utils/push_notication_services.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_state.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/update/update_current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/screens/authentication/approvalPending_screen.dart';
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
  final NotificationServices _notificationServices = NotificationServices();

  bool _navigateManually = false;

  @override
  void initState() {
    super.initState();
    _startNavigationLogic();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    await _notificationServices.requestNotificationPermissions();
    await _notificationServices.forgroundMessage();

    if (!mounted) return;
    await _notificationServices.firebaseInit(context);

    if (!mounted) return;
    await _notificationServices.setupInteractMessage(context);

    if (!mounted) return;
    await _notificationServices.isRefreshToken();

    _notificationServices.getDeviceToken().then((fcmToken) {
      if (!mounted) return;
      if (fcmToken != null) {
        final payload = {
          'fullName': '',
          'email': '',
          "fcmToken": fcmToken,
        };
        context
            .read<UpdateCurrentCustomerCubit>()
            .updateCustomer(payload, context);
      }
    });
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
          final model = state.currentCustomerModel;
          final roles = model.roles?.map((r) => r.name).toList() ?? [];
          final hasDeliveryRole = roles.contains('ROLE_DELIVERY_PARTNER');
          final isDeliveryPartner = model.deliveryPartner ?? false;

          if (hasDeliveryRole) {
            if (isDeliveryPartner) {
              _navigateTo(const DeliveryPartnerDashboard());
            } else {
              _navigateTo(const ApprovalPendingScreen());
            }
          } else {
            if (!isDeliveryPartner) {
              _navigateTo(const NameInputScreen());
            } else {
              _navigateTo(const LoginScreen());
            }
          }
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
