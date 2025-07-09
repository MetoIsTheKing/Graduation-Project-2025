import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_2025/config/dependency_injection/di.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../../core/helpers/my_logger.dart';
import '../../../../../core/network_clients/abstract_client.dart';
import '../../data/models/my_booking_model.dart';
import '../../domain/repositories/my_bookings_repo.dart';

part 'my_bookings_state.dart';

class MyBookingsCubit extends Cubit<MyBookingsState> {
  final MyBookingsRepo myBookingsRepo;
  MyBookingsCubit(this.myBookingsRepo) : super(MyBookingsInitial());

  static MyBookingsCubit get(context) => BlocProvider.of(context);

  void loadBookings() async {
    emit(MyBookingsLoading());
    if (RefreshFailed.value || !(await getIt<AuthCubit>().isLoggedIn())) {
      emit(MyBookingsNotLoggedIn('Please log in to view your bookings'));
      return;
    }
    myBookingsRepo.getMyBookings().then((bookings) {
      for (var booking in bookings) {
        if (booking.status == 'confirmed') {
          MyLogger.yellow('Booking ID: ${booking.id}');
        }
      }
      emit(MyBookingsLoaded(bookings));
    }).catchError((error) {
      MyLogger.red('Error loading bookings: $error');
      emit(MyBookingsError('Something went wrong, please try again later'));
    });
  }

  Future<void> cancelBooking(String bookingId) async {
    emit(MyBookingsLoading());
    myBookingsRepo.cancelFlight(bookingId).then((isCancelled) {
      if (!isCancelled) {
        MyLogger.red('Failed to cancel booking with ID: $bookingId');
        emit(MyBookingFailedCancel());
        loadBookings();
        return;
      } else {
        emit(MyBookingCancelled());
        MyLogger.green('Booking $bookingId cancelled successfully');
        loadBookings();
      }
    }).catchError((error) {
      MyLogger.red('Error cancelling booking: $error');
      emit(MyBookingFailedCancel());
      loadBookings();
    });
  }
}
