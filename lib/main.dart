import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eato_delivery_partner/core/network/network_cubit.dart';
import 'package:eato_delivery_partner/firebase_options.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/update/update_current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/deleteAccount/deleteAccount_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/login/trigger_otp_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/roles/rolesPost_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/signUp/signup_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/signin/sigin_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/availability/availability_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/location/location_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/registration/registration_cubit.dart';
import 'package:eato_delivery_partner/presentation/screens/authentication/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection.dart' as di;


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  di.init();

  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    print("No Internet Connection");
  } else {
    print("Connected to the Internet");
  }

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
        BlocProvider(create: (_) => di.sl<RegistrationCubit>()),
        BlocProvider(create: (_) => di.sl<AvailabilityCubit>()),

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
