import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project_2025/core/network_clients/abstract_client.dart';
import 'package:graduation_project_2025/core/network_clients/clients/fake_users_client.dart';
import 'package:graduation_project_2025/core/responsive/Models/device_info.dart'
    as my_device_info;
import 'package:graduation_project_2025/features/auth/data/datasources/users_remote.dart';
import 'package:graduation_project_2025/features/auth/data/repositories/user_repo_impl.dart';
import 'package:graduation_project_2025/features/auth/domain/repositories/user_repo.dart';
import 'package:graduation_project_2025/features/auth/presentation/cubit/auth_cubit.dart';

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

  // ------- dio client -------
  getIt.registerLazySingleton<DioNetworkClient>(() => FakeUsersClient());

  //------------ data sources ------------

  // UserRemote
  getIt.registerLazySingleton<UsersRemote>(
    () => UsersRemoteImpl(fakeUsersClient: getIt<DioNetworkClient>()),
  );

  //------------ repositories ------------

  // UserRepo
  getIt.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(getIt<UsersRemote>()),
  );

  //------------ cubits ------------

  //AuthCubit
  getIt.registerSingleton<AuthCubit>(
     AuthCubit(getIt<UserRepo>()),
  );
}
