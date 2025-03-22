import 'package:bloc/bloc.dart';

part 'my_bookings_state.dart';

class MyBookingsCubit extends Cubit<MyBookingsState> {
  MyBookingsCubit() : super(MyBookingsInitial());
}
