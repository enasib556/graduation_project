import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_iti/data/cubits/onboarding_cubit/onboardingstate.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial()) {
    _startTimer();
  }

  PageController pageController = PageController(initialPage: 0);
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      nextPage();
    });
  }

  void updatePage(int index) {
    emit(OnboardingPageUpdated(index));
  }

  void nextPage() {
    int nextPage = (state is OnboardingPageUpdated) ? (state as OnboardingPageUpdated).currentPage + 1 : 1;
    if (nextPage > 2) {
      nextPage = 0;
    }
    pageController.animateToPage(
      nextPage,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    emit(OnboardingPageUpdated(nextPage));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
