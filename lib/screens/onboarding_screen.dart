import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_iti/data/cubits/onboarding_cubit/OnboardingCubit.dart';
import 'package:graduation_project_iti/data/cubits/onboarding_cubit/onboardingstate.dart';
import 'package:graduation_project_iti/widgets/splash_onboarding/Indicator_widget.dart';
import 'package:graduation_project_iti/widgets/splash_onboarding/OnboardingPage_widget.dart';
import 'package:graduation_project_iti/widgets/splash_onboarding/SkipButton_widget.dart';

class OnboardingScreen extends StatelessWidget {
  void _skipOnboarding(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return PageView(
                controller: context.read<OnboardingCubit>().pageController,
                onPageChanged: (index) {
                  context.read<OnboardingCubit>().updatePage(index);
                },
                children: [
                  OnboardingPage(
                    color: Color(0xff191F1A),
                    imagePath: 'assets/images/splash.jpg',
                    titlePart1: 'Welcome to',
                    titlePart2: 'Playfinity Central',
                    titlePart1Color: Colors.white,
                    titlePart2Color: Color(0xff6BDF70),
                    description: 'Your one-stop-shop for all things sports!',
                  ),
                  OnboardingPage(
                    color: Color(0xff191F1A),
                    imagePath: 'assets/images/scroll2.jpg',
                    titlePart1: 'Discover Local',
                    titlePart2: 'Sports Events',
                    titlePart1Color: Colors.white,
                    titlePart2Color: Color(0xff6BDF70),
                    description: 'Personalize your experience!',
                  ),
                  OnboardingPage(
                    color: Color(0xff191F1A),
                    imagePath: 'assets/images/scroll3.jpg',
                    titlePart1: 'Enjoy the',
                    titlePart2: 'World of Sports',
                    titlePart1Color: Colors.white,
                    titlePart2Color: Color(0xff6BDF70),
                    description: 'At your fingertips!',
                  ),
                ],
              );
            },
          ),
          SkipButton(onPressed: () => _skipOnboarding(context)),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                int currentIndex = state is OnboardingPageUpdated ? state.currentPage : 0;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Indicator(isActive: index == currentIndex),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}