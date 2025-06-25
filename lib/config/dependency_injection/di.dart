import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project_2025/config/dependency_injection/di_instances.dart';
import 'package:graduation_project_2025/config/routing/arguments.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';
import 'package:graduation_project_2025/core/network_clients/clients/fake_users_client.dart';
import 'package:graduation_project_2025/core/network_clients/clients/search_airports_client.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart'
    as my_device_info;
import 'package:graduation_project_2025/features/auth/data/datasources/users_remote.dart';
import 'package:graduation_project_2025/features/auth/data/repositories/user_repo_impl.dart';
import 'package:graduation_project_2025/features/auth/domain/repositories/user_repo.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project_2025/features/booking/data/models/one_way_booking_model.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/data_sources/search_flights_remote.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/repository/search_airports_repo.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/flights_data_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/presentation/cubits/search_flights/search_flights_cubit.dart';
import 'package:graduation_project_2025/features/home/explore/flights/data/models/flight_model.dart';

import '../../features/booking/data/models/booking_sub_models.dart';
import '../../features/booking/data/models/round_trip_booking_model.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Register DeviceInfo as a singleton with initial default values
  if (!getIt.isRegistered<my_device_info.DeviceInfo>()) {
    getIt.registerSingleton<my_device_info.DeviceInfo>(
      my_device_info.DeviceInfo(
        orientation: Orientation.portrait,
        deviceType: DeviceType.phone, // Changed to match your enum
        screenWidth: 0.0,
        screenHeight: 0.0,
      ),
    );
  }

  // AirportDetails
  getIt.registerSingleton<AirportsDetails>(
    AirportsDetails(
      arrAirportsDetails: {},
      depAirportsDetails: {},
    ),
  );

  getIt.registerSingleton<FlightSearchQueryParams>(
    FlightSearchQueryParams(),
  );

  // ------- dio client -------
  getIt.registerLazySingleton<DioNetworkClient>(() => FakeUsersClient(),
      instanceName: DiInstances.dioUserClient);
  getIt.registerLazySingleton<DioNetworkClient>(
      () => AmadeusApiClient(
            apiKey: dotenv.env['AMADEUS_API_KEY'] ?? 'your_api_key',
            apiSecret: dotenv.env['AMADEUS_API_SECRET'] ?? 'your_api_secret',
          ),
      instanceName: DiInstances.amadeusClient);

  //------------ data sources ------------

  // UserRemote
  getIt.registerLazySingleton<UsersRemote>(
    () => UsersRemoteImpl(
        fakeUsersClient:
            getIt<DioNetworkClient>(instanceName: DiInstances.dioUserClient)),
  );
  // SearchAirportsRemote
  getIt.registerLazySingleton<SearchFlightssRemoteDataSource>(
    () => SearchFlightssRemoteDataSourceImpl(
      amadeusApiClient:
          getIt<DioNetworkClient>(instanceName: DiInstances.amadeusClient),
    ),
  );

  //------------ repositories ------------

  // UserRepo
  getIt.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(getIt<UsersRemote>()),
  );
  // SearchAirportsRepo
  getIt.registerLazySingleton<SearchFlightsRepo>(
    () => SearchFlightsRepo(
        remoteDataSource: getIt<SearchFlightssRemoteDataSource>()),
  );
  //------------ cubits ------------

  // SearchFlightsCubits
  getIt.registerSingleton<SearchFlightsCubit>(
    SearchFlightsCubit(searchAirportsRepo: getIt<SearchFlightsRepo>()),
  );
  getIt.registerLazySingleton<FlightsDataCubit>(
    () => FlightsDataCubit(),
  );

  //AuthCubit
  getIt.registerSingleton<AuthCubit>(
    AuthCubit(getIt<UserRepo>()),
  );

  // Booking Models

  //OneWay
  getIt.registerSingleton<OneWayBookingModel>(
    OneWayBookingModel(
      flightId: '',
      numberOfStops: 0,
      originAirportCode: '',
      destinationAirportCode: '',
      originCity: '',
      destinationCity: '',
      departureDate: DateTime.now(),
      arrivalDate: DateTime.now(),
      selectedBaggageOption: BaggageOptionModel(
        type: '',
        weight: '',
        price: 0.0,
      ),
      totalPrice: 0.0,
      currency: 'USD',
      travellersInfo: [],
      contactDetails: ContactDetailsModel(
        email: '',
        phone: '',
      ),
    ),
  );
  // RoundTrip
  getIt.registerSingleton<RoundTripBookingModel>(
    RoundTripBookingModel(
      flightData: [
        FlightDataModel(
          flightId: '',
          typeOfFlight: '',
          numberOfStops: 0,
          originAirportCode: '',
          destinationAirportCode: '',
          originCity: '',
          destinationCity: '',
          departureDate: DateTime.now(),
          arrivalDate: DateTime.now(),
          selectedBaggageOption: BaggageOptionModel(
            type: '',
            weight: '',
            price: 0.0,
          ),
        ),
        FlightDataModel(
          flightId: '',
          typeOfFlight: '',
          numberOfStops: 0,
          originAirportCode: '',
          destinationAirportCode: '',
          originCity: '',
          destinationCity: '',
          departureDate: DateTime.now(),
          arrivalDate: DateTime.now(),
          selectedBaggageOption: BaggageOptionModel(
            type: '',
            weight: '',
            price: 0.0,
          ),
        )
      ],
      totalPrice: 0.0,
      currency: 'USD',
      travellersInfo: [],
      contactDetails: ContactDetailsModel(
        email: '',
        phone: '',
      ),
    ),
  );
}
