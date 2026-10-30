import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/core/utils/validators.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:flutter_application_1/features/auth/views/login_screen.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
   final TextEditingController _emailController = TextEditingController();
   @override
   void dispose() {
    _emailController.dispose();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child:Center(
      child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Form(
        key:_formKey,
        autovalidateMode:AutovalidateMode.onUserInteraction,
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          Image.asset(
          'assets/icons/forgot.png',
           height: 72,
          width: 72,
          ),
          const SizedBox(height: 20),
          const Text(
          'Forgot Password?',
          style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
                  ),
                  ),
                  const SizedBox(height: 8),
       const Text(
                    'Enter your email and we will send you a link to reset your password',
                    style: TextStyle(
                      fontSize: 15,
                     
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 32), 
                TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.mail_outline, color: AppColors.textSecondary),
                    ),
                  ),
                  const SizedBox(height: 16),    
                   const SizedBox(height: 24),
                   Consumer<AuthProvider>(
  builder: (context, authProvider, child) {
    return CustomButton(
      text: authProvider.isLoading
          ? 'Sending...'
          : 'Send Reset Link',

      onPressed: authProvider.isLoading
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                final success =
                    await authProvider.sendPasswordReset(
                  _emailController.text,
                );

                if (success) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Password reset link sent successfully!',
                      ),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } else {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        authProvider.errorMessage ??
                            'Failed to send reset link',
                      ),
                    ),
                  );
                }
              }
            },
    );
  },
),
                  const SizedBox(height: 28),  

          Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Remember your Password? ',
                        style: TextStyle(
                        color: AppColors.textPrimary,
                          fontSize: 14,
                          
                          fontWeight:FontWeight.w100,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  )

         ], 
        )
        ),
        ),
      )
      )
    );
  }
}