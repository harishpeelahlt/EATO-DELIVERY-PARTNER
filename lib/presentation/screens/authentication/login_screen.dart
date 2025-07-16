
import 'package:eato_delivery_partner/components/custom_button.dart';
import 'package:eato_delivery_partner/core/constants/colors.dart';
import 'package:eato_delivery_partner/core/constants/img_const.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/login/trigger_otp_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/login/trigger_otp_state.dart';
import 'package:eato_delivery_partner/presentation/screens/dashboard/deliveryPartnerDashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/injection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    // Make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TriggerOtpCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  rider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.65),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 24,
                                bottom: 36,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Eato",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Your favourite meals,\ndelivered fresh.",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Enter your mobile number",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        children: [
                                          const Text("+91",
                                              style: TextStyle(fontSize: 16)),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: mobileController,
                                              focusNode: _focusNode,
                                              maxLength: 10,
                                              keyboardType: TextInputType.phone,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              style:
                                                  const TextStyle(fontSize: 16),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                counterText: "",
                                                hintText: "Mobile number",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          value: isChecked,
                                          onChanged: (val) => setState(
                                              () => isChecked = val ?? false),
                                          activeColor: AppColor.primaryColor,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              setState(() => isChecked = true);
                                              // await Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (_) =>
                                              //         const TermsAndConditionsScreen(),
                                              //   ),
                                              // );
                                            },
                                            child: Text.rich(
                                              TextSpan(
                                                text: 'I agree to the ',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13),
                                                children: [
                                                  TextSpan(
                                                    text: 'Terms & Conditions',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              BlocBuilder<TriggerOtpCubit, TriggerOtpState>(
                                builder: (context, state) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: CustomButton(
                                      buttonText: "Get OTP",
                                      isLoading: state is TriggerOtpLoading,
                                      onPressed: () {
                                        if (isChecked) {
                                          context
                                              .read<TriggerOtpCubit>()
                                              .fetchOtp(
                                                context,
                                                mobileController.text,
                                              );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Please accept Terms & Conditions"),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool('isGuest', true);
                                  await prefs.remove('TOKEN');
                                  if (!mounted) return;
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const DeliveryPartnerDashboard(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  "Continue as Guest",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
