import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/validators.dart';
import '../../core/utils/mock_data.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Form key for validation
  final formKey = GlobalKey<FormState>();
  
  // Reactive variables
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final emailError = Rx<String?>(null);
  final passwordError = Rx<String?>(null);
  
  @override
  void onInit() {
    super.onInit();
    // Pre-fill demo credentials for easier testing
    emailController.text = MockData.demoEmail;
    passwordController.text = MockData.demoPassword;
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  
  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }
  
  // Validate email field
  void validateEmail(String value) {
    emailError.value = Validators.validateEmail(value);
  }
  
  // Validate password field
  void validatePassword(String value) {
    passwordError.value = Validators.validatePassword(value);
  }
  
  // Check if form is valid
  bool get isFormValid {
    return emailError.value == null && 
           passwordError.value == null &&
           emailController.text.isNotEmpty &&
           passwordController.text.isNotEmpty;
  }
  
  // Handle login
  Future<void> login() async {
    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    // Clear any previous errors
    emailError.value = null;
    passwordError.value = null;
    
    // Show loading
    isLoading.value = true;
    
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock authentication
      if (emailController.text == MockData.demoEmail && 
          passwordController.text == MockData.demoPassword) {
        // Success - navigate to dashboard
        Get.offAllNamed(Routes.dashboard);
      } else {
        // Failed - show error
        Get.snackbar(
          'Login Failed',
          'Invalid email or password. Try: ${MockData.demoEmail}',
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle unexpected errors
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Handle demo login (quick login for testing)
  void loginWithDemo() {
    emailController.text = MockData.demoEmail;
    passwordController.text = MockData.demoPassword;
    login();
  }
  
  // Clear form
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    emailError.value = null;
    passwordError.value = null;
  }
}
