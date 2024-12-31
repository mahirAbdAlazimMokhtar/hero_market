import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/common/widgets/input_field.dart';
import 'package:hero_market/core/common/widgets/rounded_button.dart';
import 'package:hero_market/core/common/widgets/vertical_label_field.dart';
import 'package:hero_market/core/extensions/text_style_extensions.dart';
import 'package:hero_market/core/extensions/widgets_extensions.dart';
import 'package:hero_market/core/resources/styles/text.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:hero_market/src/auth/presentation/app/adapter/cubit/auth_cubit.dart';

import '../../../../../core/resources/styles/colors.dart';
import '../screens/forgot_password_screen.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryController = TextEditingController();
  final obscurePasswordNotifier = ValueNotifier<bool>(true);
  final obscureConfirmPasswordNotifier = ValueNotifier<bool>(true);

  final countryNotifier = ValueNotifier<Country?>(null);
  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (country) {
          if (country != countryNotifier.value) countryNotifier.value = country;
        });
  }

  @override
  void initState() {
    super.initState();
    countryNotifier.addListener(() {
      if (countryNotifier.value == null) {
        passwordController.clear();
        countryController.clear();
      } else {
        countryController.text = '+${countryNotifier.value!.phoneCode}';
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePasswordNotifier.dispose();
    obscureConfirmPasswordNotifier.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    countryController.dispose();
    countryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state case AuthError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        } else if (state is Registered) {
          context.go('/');
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              VerticalLabelField(
                label: 'Full Name',
                controller: fullNameController,
                hintText: 'Enter your full name',
                keyboardType: TextInputType.name,
              ),
              Gap(20),
              VerticalLabelField(
                label: 'Email',
                controller: emailController,
                hintText: 'Enter your Email',
                keyboardType: TextInputType.emailAddress,
              ),
              Gap(30),
              ValueListenableBuilder(
                valueListenable: countryNotifier,
                builder: (context, country, __) {
                  return Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone Number',
                          style: AppTextStyles.paragraphSubTextRegular1
                              .adaptiveColor(context)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // حقل رمز الدولة
                          Flexible(
                            flex: 1,
                            child: InputField(
                              controller: countryController,
                              defaultValidation: false,
                              readOnly: true,
                              contentPadding: const EdgeInsets.only(left: 10),
                              suffixIcon: GestureDetector(
                                onTap: pickCountry,
                                child: const Icon(Icons.arrow_drop_down),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              validator: (value) {
                                if (!isPhoneValid(
                                  phoneNumberController.text,
                                  defaultCountryCode: country?.countryCode,
                                )) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10), // مسافة بين الحقول
                      
                          Flexible(
                            flex: 3,
                            child: InputField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              hintText: 'Enter your phone number',
                              enabled: country != null,
                              validator: (value) {
                                if (!isPhoneValid(
                                  value ?? '',
                                  defaultCountryCode: country?.countryCode ?? 'US',
                                )) {
                                  return 'Invalid Phone number';
                                }
                                return null;
                              },
                              inputFormatters: [
                                PhoneInputFormatter(
                                  defaultCountryCode: country?.countryCode ?? 'US',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const Gap(20),
              ValueListenableBuilder(
                valueListenable: obscurePasswordNotifier,
                builder: (_, obscurePassword, __) {
                  return VerticalLabelField(
                    label: 'Password',
                    controller: passwordController,
                    hintText: 'Enter your password',
                    obscureText: obscurePassword,
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          obscurePasswordNotifier.value = !obscurePassword,
                      child: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.lightThemeSecondaryTextColor,
                      ),
                    ),
                  );
                },
              ),
              const Gap(20),
              ValueListenableBuilder(
                valueListenable: obscureConfirmPasswordNotifier,
                builder: (_, obscureConfirmPassword, __) {
                  return VerticalLabelField(
                    label: 'Confirm Password',
                    controller: confirmPasswordController,
                    hintText: 'please confirm your password',
                    obscureText: obscureConfirmPassword,
                    suffixIcon: GestureDetector(
                      onTap: () => obscureConfirmPasswordNotifier.value =
                          !obscureConfirmPasswordNotifier.value,
                      child: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.lightThemeSecondaryTextColor,
                      ),
                    ),
                    validator: (value) {
                      if (value != passwordController.text.trim()) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  );
                },
              ),
              const Gap(20),
              SizedBox(
                width: double.maxFinite,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      context.go(ForgotPasswordScreen.path);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.paragraphSubTextRegular1
                          .adaptiveColor(context),
                    ),
                  ),
                ),
              ),
              const Gap(40),
              RoundedButton(
                  text: 'Sign Up',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final phoneNumber = phoneNumberController.text.trim();
                      final country = countryNotifier.value!;
                      final formattedNumber =
                          '+${country.phoneCode}${toNumericString(phoneNumber)}';
                      final fullName = fullNameController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      context.read<AuthCubit>().register(
                            fullName: fullName,
                            email: email,
                            password: password,
                            phoneNumber:
                                formattedNumber, // هنا يتم إرسال الرقم بعد تنسيقه
                          );
                    }
                  }).loading(state is AuthLoading),
            ],
          ),
        );
      },
    );
  }
}
