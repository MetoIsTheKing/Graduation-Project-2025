import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/core/utils/app_colors.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/signup_widgets/auth_phone_widget.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/manager/profile_cubit.dart';
import 'package:graduation_project_2025/features/home/profile/presentation/manager/profile_state.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/auth_textfield.dart';
import 'package:graduation_project_2025/features/auth/presentation/widgets/shared_widgets/error_toast.dart';
import 'package:intl_phone_field/countries.dart';

class EditProfileDialog extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final FocusNode firstNameFocus;
  final FocusNode lastNameFocus;
  final FocusNode phoneFocus;
  final double fieldsSpacing;
  final void Function(Country country) onCountryChanged;
  final Country selectedCountry;
  final double? dialogWidth;
  final double dialogHeight;

  const EditProfileDialog({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.firstNameFocus,
    required this.lastNameFocus,
    required this.phoneFocus,
    required this.fieldsSpacing,
    required this.selectedCountry,
    required this.onCountryChanged,
    this.dialogWidth = 300,
    required this.dialogHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dialogHeight * .05),
          child: BlocConsumer<ProfileCubit, UserState>(
            listener: (context, state) {
              if (state is UserProfileLoaded) {
                successToast(
                        title: 'Success',
                        description: 'Profile updated successfully')
                    .show(context);
                Navigator.pop(context);
              } else if (state is UserError) {
                errorToast(title: 'Error', description: state.message)
                    .show(context);
              }
            },
            builder: (context, state) {
              return ListView(
                children: [
                  const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: dialogHeight * .04),
                  AuthTextField(
                    prefix: 'First name',
                    hint: 'Enter First name',
                    keyboardType: TextInputType.name,
                    focusNode: firstNameFocus,
                    nextFocusNode: lastNameFocus,
                    controller: firstNameController,
                    needValidation: true,
                  ),
                  SizedBox(height: dialogHeight * .04),
                  AuthTextField(
                    prefix: 'Last name',
                    hint: 'Enter Last name',
                    keyboardType: TextInputType.name,
                    focusNode: lastNameFocus,
                    nextFocusNode: phoneFocus,
                    controller: lastNameController,
                    needValidation: true,
                  ),
                  SizedBox(height: dialogHeight * .04),
                  AuthPhoneWidget(
                    focusNode: phoneFocus,
                    controller: phoneController,
                    onCountryChanged: onCountryChanged,
                    initialCountry: selectedCountry,
                  ),
                  SizedBox(height: dialogHeight * .0005),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: state is UserLoading
                        ? null
                        : () {
                            final cubit = context.read<ProfileCubit>();

                            cubit.updateUserProfile({
                              'firstName': firstNameController.text.trim(),
                              'lastName': lastNameController.text.trim(),
                              'phoneNumber':
                                  "+${selectedCountry.dialCode}${phoneController.text}",
                            });
                          },
                    child: state is UserLoading
                        ? const CircularProgressIndicator()
                        : const Text('Save'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
