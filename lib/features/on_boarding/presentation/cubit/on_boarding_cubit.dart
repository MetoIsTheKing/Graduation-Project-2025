import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/features/on_boarding/presentation/cubit/content_model.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  int? index;
  OnBoardingCubit() : super(OnBoardingState(onboardingContent[0])) {
    index = onboardingContent.indexOf(state.onboardingContent);
  }

  Future<void> nextOnboarding() async {
    if (index! < onboardingContent.length - 1) {
      if (index != null) {
        index = index! + 1;
        emit(OnBoardingState(onboardingContent[index!]));
      }
    }
  }
}
