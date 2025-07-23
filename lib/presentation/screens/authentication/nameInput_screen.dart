import 'package:eato_delivery_partner/components/custom_button.dart';
import 'package:eato_delivery_partner/components/custom_snackbar.dart';
import 'package:eato_delivery_partner/components/custom_topbar.dart';
import 'package:eato_delivery_partner/core/constants/colors.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_state.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/update/update_current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/update/update_current_customer_state.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/roles/rolesPost_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/roles/rolesPost_state.dart';
import 'package:eato_delivery_partner/presentation/cubit/registration/registration_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/registration/registration_state.dart';
import 'package:eato_delivery_partner/presentation/screens/authentication/approvalPending_screen.dart';
import 'package:eato_delivery_partner/presentation/screens/dashboard/deliveryPartnerDashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameInputScreen extends StatefulWidget {
  final String? initialEmail;
  const NameInputScreen({super.key, this.initialEmail});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _vehicleNumberController;
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> registrationPayload = {};
  Map<String, dynamic> updatePayload = {};
  bool _navigateManually = true;

  void _navigateTo(Widget screen) {
    _navigateManually = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController(text: widget.initialEmail ?? '');
    _vehicleNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _vehicleNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RolePostCubit, RolePostState>(
          listener: (context, state) {
            if (state is RolePostFailure) {
              CustomSnackbars.showErrorSnack(
                context: context,
                title: "Failed",
                message: "Role Assignment Failed",
              );
            } else if (state is RolePostSuccess) {
              context.read<RegistrationCubit>().register(registrationPayload);
            }
          },
        ),
        BlocListener<RegistrationCubit, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationFailure) {
              CustomSnackbars.showErrorSnack(
                context: context,
                title: "Failed",
                message: "Registration Failed",
              );
            } else if (state is RegistrationSuccess) {
              context
                  .read<UpdateCurrentCustomerCubit>()
                  .updateCustomer(updatePayload, context);
            }
          },
        ),
        BlocListener<UpdateCurrentCustomerCubit, UpdateCurrentCustomerState>(
          listener: (context, state) {
            if (state.error != null && state.error!.isNotEmpty) {
              CustomSnackbars.showErrorSnack(
                context: context,
                title: "Failed",
                message: "Something went wrong",
              );
            } else if (state.data != null) {
              CustomSnackbars.showSuccessSnack(
                context: context,
                title: "Success",
                message: "Profile updated successfully",
              );

              context.read<CurrentCustomerCubit>().GetCurrentCustomer(context);
            }
          },
        ),
        BlocListener<CurrentCustomerCubit, CurrentCustomerState>(
          listener: (context, state) {
            if (!_navigateManually) return;

            if (state is CurrentCustomerLoaded) {
              final model = state.currentCustomerModel;
              final roles = model.roles.map((r) => r.name).toList();
              final hasDeliveryRole = roles.contains('ROLE_DELIVERY_PARTNER');
              final isDeliveryPartner = model.deliveryPartner ?? false;

              if (hasDeliveryRole) {
                if (isDeliveryPartner) {
                  _navigateTo(const DeliveryPartnerDashboard());
                } else {
                  _navigateTo(const ApprovalPendingScreen());
                }
              }
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "Welcome to Eato",
          showBackButton: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("First Name"),
                _buildTextField(
                  controller: _firstNameController,
                  hint: "Enter first name",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                    LengthLimitingTextInputFormatter(30),
                  ],
                  validatorMsg: "Please enter your first name",
                ),
                const SizedBox(height: 24),
                _buildLabel("Last Name"),
                _buildTextField(
                  controller: _lastNameController,
                  hint: "Enter last name",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                    LengthLimitingTextInputFormatter(30),
                  ],
                  validatorMsg: "Please enter your last name",
                ),
                const SizedBox(height: 24),
                _buildLabel("Email"),
                _buildTextField(
                  controller: _emailController,
                  hint: "Enter email address",
                  inputType: TextInputType.emailAddress,
                  validatorMsg: "Please enter a valid email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildLabel("Vehicle Number"),
                _buildTextField(
                  controller: _vehicleNumberController,
                  hint: "Enter vehicle number",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9 ]')),
                    LengthLimitingTextInputFormatter(15),
                    UpperCaseTextFormatter(),
                  ],
                  validatorMsg: "Please enter your vehicle number",
                  textCapitalization: TextCapitalization.characters,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'This name will appear on your account and food orders',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                BlocBuilder<RolePostCubit, RolePostState>(
                  builder: (context, roleState) {
                    final isLoadingRole = roleState is RolePostLoading;

                    return BlocBuilder<RegistrationCubit, RegistrationState>(
                      builder: (context, regState) {
                        final isRegLoading = regState is RegistrationLoading;

                        return BlocBuilder<UpdateCurrentCustomerCubit,
                            UpdateCurrentCustomerState>(
                          builder: (context, updateState) {
                            return CustomButton(
                              buttonText: "Save Changes",
                              isLoading: isLoadingRole ||
                                  isRegLoading ||
                                  updateState.isLoading,
                              onPressed: _saveChanges,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    List<TextInputFormatter>? inputFormatters,
    TextInputType inputType = TextInputType.text,
    String? Function(String?)? validator,
    String? validatorMsg,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        keyboardType: inputType,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return validatorMsg;
              }
              return null;
            },
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final fullName =
          '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}'
              .trim();

      updatePayload = {
        'fullName': fullName,
        'email': _emailController.text.trim(),
        'fcmToken': '',
      };

      registrationPayload = {
        'vehicleNumber': _vehicleNumberController.text.trim(),
        'status': 'AVAILABLE',
        'active': true,
        'available': true,
      };

      context
          .read<RolePostCubit>()
          .postRole(role: 'ROLE_DELIVERY_PARTNER', context: context);
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
