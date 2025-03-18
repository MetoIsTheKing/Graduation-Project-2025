import 'package:graduation_project_2025/features/home/explore/flights/presentation/flight_model.dart';

class FlightActionsModel {
  final Function(DateTime?) onDepartureDateSelected;
  final Function(DateTime?) onReturnDateSelected;
  final Function(FlightModel flightModel) onChangePressed;
  final Function(FlightModel flightModel) onTravellersFieldTapped;
  final void Function() onToFieldTapped;
  final void Function() onFromFieldTaped;
  final Future<void> Function({
    required FlightModel selecteFlightModel,
    bool isReturnDate,
  }) onDatePickerTapped;
  final void Function() onAddAnotherFlightPressed;
  final void Function() onSearchFlightsPressed;

  FlightActionsModel({
    required this.onChangePressed,
    required this.onDepartureDateSelected,
    required this.onReturnDateSelected,
    required this.onFromFieldTaped,
    required this.onToFieldTapped,
    required this.onTravellersFieldTapped,
    required this.onAddAnotherFlightPressed,
    required this.onSearchFlightsPressed,
    required this.onDatePickerTapped,
  });
}
