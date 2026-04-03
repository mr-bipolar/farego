import 'package:farego/core/theme/app_theme.dart';
import 'package:farego/features/splash_screen/presentation/pages/splash_screen.dart';
import 'package:farego/features/work_screen/presentation/bloc/fare_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Load Google Fonts License
  LicenseRegistry.addLicense(() async* {
    final String license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(<String>['google_fonts'], license);
  });

  runApp(BlocProvider(create: (_) => FareCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FireGoApp',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
