import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/core/utils/validators.dart';
import 'package:flutter_application_1/core/widgets/custom_button.dart';
import 'package:flutter_application_1/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:flutter_application_1/features/home/views/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final _formKey = GlobalKey<FormState>();
   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child:Center(
          child: SingleChildScrollView(
           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
           child: Form(
            key: _formKey,
            autovalidateMode:AutovalidateMode.onUserInteraction,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                Image.asset(
                  'assets/icons/sign-in.png',
                   height: 72,
                  width: 72,
                  ),
                   const SizedBox(height: 20),
                   const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Login to continue shopping',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
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
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: Validators.validateLoginPassword,
                    decoration: InputDecoration(
                      hintText: 'Enter Your password',
                      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textSecondary),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                   const SizedBox(height: 14),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                    onTap: (){
                          Navigator.pushReplacementNamed(context,AppRoutes.forgotPassword);
                        },  
                         child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )
                    )
                  ],
                  ),
       /*
       ////////////////////////////////////////////////////////////////////////////////////
       ///              Login
       /// ///////////////////////////////////////////////////////////////////////////////
       */           
                   const SizedBox(height: 24),
                  Consumer<AuthProvider>(
  builder: (context, authProvider, child) {
    return CustomButton(
      text: authProvider.isLoading
          ? 'Logging In...'
          : 'Login',

      onPressed: authProvider.isLoading
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                final success = await authProvider.signIn(
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                if (success) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login Successful!'),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                } else {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        authProvider.errorMessage ??
                            'Login failed',
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
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                        ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                       ),
                       Expanded(
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ),
                        
                    ],
                  ),
                  const SizedBox(height: 24),
                  /*
   ///////////////////////////////////////////////////////////////////////////////////////////
                               ///google sign in
                               
   ////////////////////////////////////////////////////////////////////////////////////////////
                  */
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: (){

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google-logo.png', // Google logo asset path
                            height: 24,
                            width: 24,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have an account?',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, AppRoutes.register);
                        },
                        child: const Text(
                          'Create Account',
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
            ),
            ),
          ),
        )
        ),
    );
  }
}