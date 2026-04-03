import 'package:farego/core/constants/app_images.dart';
import 'package:farego/core/utils/blink_navigate.dart';
import 'package:farego/features/home_screen/presentation/pages/home_screen.dart';
import 'package:farego/features/splash_screen/presentation/widgets/logo_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// init state
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Future.delayed(const Duration(seconds: 5), _navigateToHome);
  }

  /// Home Navigate
  void _navigateToHome() async {
    if (!mounted) return;
    navigateWithBlink(context, HomeScreen(), isPush: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// background image
          SvgPicture.asset(
            AppImages.splashBackground,
            fit: BoxFit.fill,
            allowDrawingOutsideViewBox: true,
          ),

          /// Black shade
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
              ),
            ),
          ),

          /// Round wave
          Positioned.fill(child: LogoWave()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
}
