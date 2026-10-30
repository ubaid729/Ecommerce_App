import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes/app_router.dart';
import 'package:flutter_application_1/core/routes/app_routes.dart';
import 'package:flutter_application_1/core/theme/app_theme.dart';
import 'package:flutter_application_1/data/repositories/home_repository.dart';
import 'package:flutter_application_1/data/services/firestore_service.dart';
import 'package:flutter_application_1/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:flutter_application_1/features/home/viewmodels/home_viewmodel.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        // AuthViewModel ko globally provide kar rahe hain
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
         ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(
        HomeRepository(
          FirestoreService(),
        ),
      )..loadHomeData(),
    ),
      ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopEase',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
     onGenerateRoute: AppRouter.onGenerateRoute,
    ),
     );
  }
}