
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../components/custom_button.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   bool _acceptedTerms = false;

//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//     _fadeAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _fullNameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Stack(
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.45,
//                 child: Image.asset(
//                   dish,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//                     height: MediaQuery.of(context).size.height * 0.6,
//                     decoration: BoxDecoration(
//                       color: AppColor.PrimaryColor,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30),
//                       ),
//                     ),
//                     child: Form(
//                       key: _formKey,
//                       child: ListView(
//                         shrinkWrap: true,
//                         children: [
//                           Center(
//                             child: Text(
//                               "Sign Up",
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColor.White,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           _buildTextField(
//                             controller: _fullNameController,
//                             hint: "Full Name",
//                             icon: Icons.person,
//                             validator: (value) => value!.isEmpty
//                                 ? "Please enter full name"
//                                 : null,
//                           ),
//                           const SizedBox(height: 15),
//                           _buildTextField(
//                             controller: _phoneController,
//                             hint: "Phone Number",
//                             icon: Icons.phone,
//                             keyboardType: TextInputType.phone,
//                             maxLength: 10,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly
//                             ],
//                             validator: (value) =>
//                                 value == null || value.length < 10
//                                     ? "Enter valid phone number"
//                                     : null,
//                           ),
//                           const SizedBox(height: 15),
//                           _buildTextField(
//                             controller: _emailController,
//                             hint: "Email",
//                             icon: Icons.email,
//                             keyboardType: TextInputType.emailAddress,
//                             validator: (value) =>
//                                 value!.isEmpty || !value.contains('@')
//                                     ? "Enter valid email"
//                                     : null,
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: _acceptedTerms,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _acceptedTerms = value ?? false;
//                                   });
//                                 },
//                                 activeColor: Colors.transparent,
//                                 side: BorderSide(color: AppColor.White, width: 2),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _acceptedTerms = !_acceptedTerms;
//                                   });
//                                 },
//                                 child: Text(
//                                   "I agree to the Terms & Conditions",
//                                   style: TextStyle(color: AppColor.White),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           CustomButton(
//                             buttonText: "Sign Up",
//                             isLoading: state is SignUpLoading,
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 if (!_acceptedTerms) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text(
//                                             'Please accept terms & conditions')),
//                                   );
//                                   return;
//                                 }
//                                 context.read<SignUpCubit>().fetchOtp(
//                                       context,
//                                       _phoneController.text.trim(),
//                                       _fullNameController.text.trim(),
//                                     );
//                               }
//                             },
//                           ),
//                           const SizedBox(height: 20),
//                           Center(
//                             child: TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 "Already have an account? Login",
//                                 style: TextStyle(
//                                   color: AppColor.BgWhite,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     int? maxLength,
//     String? Function(String?)? validator,
//     List<TextInputFormatter>? inputFormatters,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLength: maxLength,
//       validator: validator,
//       inputFormatters: inputFormatters,
//       style: TextStyle(color: AppColor.White),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(color: AppColor.White),
//         prefixIcon: Icon(icon, color: AppColor.White),
//         filled: true,
//         fillColor: Colors.transparent,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColor.White),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColor.White, width: 2),
//         ),
//       ),
//     );
//   }
// }
