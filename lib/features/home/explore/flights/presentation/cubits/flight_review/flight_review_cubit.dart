import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'flight_review_state.dart';

class FlightReviewCubit extends Cubit<FlightReviewState> {
  FlightReviewCubit() : super(FlightReviewInitial());
  static FlightReviewCubit get(context) => BlocProvider.of(context);
  String text = 'jjjj';

  void onCurrency() {
    text = 'qqqqqqqqq';
    emit(FlightReviewTextState());
  }
}
