import 'package:bloc/bloc.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';

class FlightsDataCubit extends Cubit<FlightModel> {
  FlightsDataCubit() : super(FlightModel());

  void resetState() {
    emit(FlightModel());
  }

  // Helper method to create a new state with all values copied
  FlightModel _copyStateWith({
    DateTime? departureDate,
    DateTime? returnDate,
    String? flightClass,
    Map<String, int>? travellers,
    String? fromText,
    String? toText,
    String? departureDateText,
    String? returnDateText,
    String? travellersText = "1 Traveller , Economy",
  }) {
    final newModel = FlightModel(
      departureDate: departureDate ?? state.departureDate,
      returnDate: returnDate ?? state.returnDate,
      flightClass: flightClass ?? state.flightClass,
      travellers: travellers ?? Map<String, int>.from(state.travellers),
    );

    // Copy all controller values with potential overrides
    newModel.fromController.text = fromText ?? state.fromController.text;
    newModel.toController.text = toText ?? state.toController.text;
    newModel.departureDateController.text =
        departureDateText?.substring(0, 10) ??
            state.departureDateController.text;
    newModel.returnDateController.text =
        returnDateText?.substring(0, 10) ?? state.returnDateController.text;
    newModel.travellersController.text =
        travellersText ?? state.travellersController.text;

    return newModel;
  }

  // Update departure location
  void updateFrom(String value) {
    emit(_copyStateWith(
      fromText: value,
      travellersText: state.travellersController.text,
    ));
  }

  // Update destination
  void updateTo(String value) {
    emit(_copyStateWith(
      toText: value,
      travellersText: state.travellersController.text,
    ));
  }

  // Update departure date
  void updateDepartureDate(DateTime date) {
    emit(_copyStateWith(
      departureDate: date,
      departureDateText: date.toString(),
      travellersText: state.travellersController.text,
    ));
  }

  // Update return date
  void updateReturnDate(DateTime? date) {
    emit(_copyStateWith(
      returnDate: date,
      returnDateText: date?.toString() ?? '',
      travellersText: state.travellersController.text,
    ));
  }

  // Update flight class
  void updateFlightClass(String flightClass) {
    emit(_copyStateWith(flightClass: flightClass));
  }

  // Update travellers
  void updateTravellers(String type, int count) {
    final updatedTravellers = Map<String, int>.from(state.travellers);
    updatedTravellers[type] = count;

    final travellersText = 'Adults: ${updatedTravellers['adults']}, '
        'Children: ${updatedTravellers['children']}, '
        'Infants: ${updatedTravellers['infants']}';

    emit(_copyStateWith(
      travellers: updatedTravellers,
      travellersText: travellersText,
    ));
  }
}
