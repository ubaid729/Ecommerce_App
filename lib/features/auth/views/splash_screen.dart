import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_strings.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.background,
      body: SafeArea(
      child:Column(
        children: [
          const Spacer(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               Image.asset(
                'assets/icons/shopping-bag.png',
                width: 110,
                height: 110,
                fit: BoxFit.contain,
              
                ),
                const SizedBox(height: 20),
                const Text(
                  AppStrings.appName,
                  style: TextStyle(
                    fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                  ),
                )
               
              ],
            ),
          ),
          const Spacer(),
          const Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
            
        ],
      )
      ),
    );
  }
}