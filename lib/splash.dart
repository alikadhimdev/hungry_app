import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/view/signup_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Fade animation for logo
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Slide animation for burger image
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Start animation
    _controller.forward();

    // Navigate after animation finishes
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => const SignupView()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          children: [
            const Gap(250),

            // Fade-In Logo
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) =>
                  Opacity(opacity: _fadeAnimation.value, child: child),
              child: SvgPicture.asset("assets/logo/logo.svg"),
            ),

            const Spacer(),

            // Slide-Up Burger
            AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) =>
                  SlideTransition(position: _slideAnimation, child: child),
              child: Image.asset("assets/splash/burger.png", height: 200),
            ),
          ],
        ),
      ),
    );
  }
}
