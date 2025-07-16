import 'package:eato_delivery_partner/core/network/network_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/update/update_current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/deleteAccount/deleteAccount_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/login/trigger_otp_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/roles/rolesPost_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/signUp/signup_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/signin/sigin_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/location/location_cubit.dart';
import 'package:eato_delivery_partner/presentation/screens/authentication/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init(); 
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<TriggerOtpCubit>()),
        BlocProvider(create: (_) => di.sl<SignInCubit>()),
        BlocProvider(create: (_) => di.sl<SignUpCubit>()),
        BlocProvider(create: (_) => di.sl<CurrentCustomerCubit>()),
        BlocProvider(create: (_) => di.sl<UpdateCurrentCustomerCubit>()),
        BlocProvider(create: (_) => di.sl<NetworkCubit>()),
        BlocProvider(create: (_) => di.sl<LocationCubit>()),
        BlocProvider(create: (_) => di.sl<RolePostCubit>()),
        BlocProvider(create: (_) => di.sl<DeleteAccountCubit>()),
      ],
      child: MaterialApp(
        title: 'Eato',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),

    );
  }
}
