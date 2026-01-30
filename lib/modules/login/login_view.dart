import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
     controller.isLoading.value;
      return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              
              // App logo/illustration
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Welcome text
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to manage your finances',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Login form
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    // Email field
                    Obx((){
                     controller.emailError.value;
                      return TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        style: AppTextStyles.bodyMedium,
                        validator: (value) {
                          controller.validateEmail(value ?? '');
                          return controller.emailError.value;
                        },
                        onChanged: controller.validateEmail,
                      );
                    }),
                    
                    const SizedBox(height: 20),
                    
                    // Password field
                    Obx((){
                     controller.passwordError.value;
                      return TextFormField(
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordVisible.value,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        style: AppTextStyles.bodyMedium,
                        validator: (value) {
                          controller.validatePassword(value ?? '');
                          return controller.passwordError.value;
                        },
                        onChanged: controller.validatePassword,
                        onFieldSubmitted: (_) => controller.login(),
                      );
                    }),
                    
                    const SizedBox(height: 32),
                    
                    // Login button
                    Obx((){
                     controller.isFormValid;
                      return PrimaryButton(
                        text: 'Sign In',
                        onPressed: controller.isFormValid ? controller.login : null,
                        isLoading: controller.isLoading.value,
                        width: double.infinity,
                      );
                    }),
                    
                    const SizedBox(height: 16),
                    
                    // Demo login button
                    SecondaryButton(
                      text: 'Use Demo Account',
                      onPressed: controller.loginWithDemo,
                      width: double.infinity,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Demo credentials info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryLight.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Demo Credentials',
                                style: AppTextStyles.label.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Email: user@example.com\nPassword: password123',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
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
    });
  }
}
