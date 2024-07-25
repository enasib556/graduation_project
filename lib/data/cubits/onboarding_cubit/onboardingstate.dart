abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageUpdated extends OnboardingState {
  final int currentPage;

  OnboardingPageUpdated(this.currentPage);
}