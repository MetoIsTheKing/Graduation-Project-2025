import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'flight_details_state.dart';

class FlightDetailsCubit extends Cubit<FlightDetailsState> {
  FlightDetailsCubit() : super(FlightDetailsInitial());
  static FlightDetailsCubit get(context) => BlocProvider.of(context);
  int selectedBaggage = 1;
  double extraPrice = 0;

  void onBaggageSelected(int i, double price) {
    selectedBaggage = i;
    extraPrice = (price * 100).round() / 100;

    emit(BaggageSelectedState());
  }
}
