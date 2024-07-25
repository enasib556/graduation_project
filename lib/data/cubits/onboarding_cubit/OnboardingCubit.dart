import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'OnboardingCubit.dart';
class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  PageController pageController = PageController(initialPage: 0);

  void updatePage(int index) {
    emit(index);
  }

  void nextPage() {
    int nextPage = state + 1;
    if (nextPage > 2) {
      nextPage = 0;
    }
    pageController.animateToPage(
      nextPage,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    emit(nextPage);
  }
}