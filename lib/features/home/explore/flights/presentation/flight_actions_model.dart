class FlightActionsModel {
  final Function(DateTime?) onDepartureDateSelected;
  final Function(DateTime?) onReturnDateSelected;
  final void Function() onChangePressed;
  final void Function() onTravellersFieldTapped;
  final void Function() onToFieldTapped;
  final void Function() onFromFieldTaped;
  final void Function() onAddReturnDateTapped;

  FlightActionsModel({
    required this.onAddReturnDateTapped,
    required this.onChangePressed,
    required this.onDepartureDateSelected,
    required this.onReturnDateSelected,
    required this.onFromFieldTaped,
    required this.onToFieldTapped,
    required this.onTravellersFieldTapped,
  });
}
