import 'package:dio/dio.dart';
import 'package:eato_delivery_partner/core/network/dio_client.dart';
import 'package:eato_delivery_partner/core/network/network_cubit.dart';
import 'package:eato_delivery_partner/core/network/network_service.dart';
import 'package:eato_delivery_partner/data/dataSource/authentication/current_customer_remote_data_source.dart';
import 'package:eato_delivery_partner/data/dataSource/authentication/deleteAccount_dataSource.dart';
import 'package:eato_delivery_partner/data/dataSource/authentication/rolesPost_dataSource.dart';
import 'package:eato_delivery_partner/data/dataSource/authentication/signin_remote_data_source.dart';
import 'package:eato_delivery_partner/data/dataSource/authentication/signup_remote_data_source.dart';
import 'package:eato_delivery_partner/data/dataSource/authentication/trigger_otp_remote_data_source.dart';
import 'package:eato_delivery_partner/data/dataSource/authentication/update_current_customer_dataSource.dart';
import 'package:eato_delivery_partner/data/dataSource/availability/availability_dataSource.dart';
import 'package:eato_delivery_partner/data/dataSource/location/location_remotedatasource.dart';
import 'package:eato_delivery_partner/data/dataSource/orders/fetchOrders/fetchOrders_dataSource.dart';
import 'package:eato_delivery_partner/data/dataSource/orders/updateOrderStatus/updateOrderStatus_dataSource.dart';
import 'package:eato_delivery_partner/data/dataSource/partnerDetails/partnerDetails_dataSource.dart';
import 'package:eato_delivery_partner/data/dataSource/registration/registration_dataSource.dart';
import 'package:eato_delivery_partner/data/repoImpl/authentication/current_customer_repository_impl.dart';
import 'package:eato_delivery_partner/data/repoImpl/authentication/deleteAccount_repoImpl.dart';
import 'package:eato_delivery_partner/data/repoImpl/authentication/rolesPost_repoImpl.dart';
import 'package:eato_delivery_partner/data/repoImpl/authentication/signin_repository_impl.dart';
import 'package:eato_delivery_partner/data/repoImpl/authentication/signup_repository_impl.dart';
import 'package:eato_delivery_partner/data/repoImpl/authentication/trigger_otp_repository_impl.dart';
import 'package:eato_delivery_partner/data/repoImpl/authentication/update_current_customer_repoImpl.dart';
import 'package:eato_delivery_partner/data/repoImpl/availability/availability_repoImpl.dart';
import 'package:eato_delivery_partner/data/repoImpl/location/location_repoImpl.dart';
import 'package:eato_delivery_partner/data/repoImpl/orders/fetchOrders/fetchOrders_repoImpl.dart';
import 'package:eato_delivery_partner/data/repoImpl/orders/updateOrderStatus/updateOrderStatus_repoImpl.dart';
import 'package:eato_delivery_partner/data/repoImpl/partnerDetails/partnerDetails_repoImpl.dart';
import 'package:eato_delivery_partner/data/repoImpl/registration/registration_repoImpl.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/current_customer_repository.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/deleteAccount_repository.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/rolesPost_repository.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/signin_repository.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/signup_repository.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/trigger_otp_repository.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/update_current_customer_repository.dart';
import 'package:eato_delivery_partner/domain/repository/availability/availability_repository.dart';
import 'package:eato_delivery_partner/domain/repository/location/location_repo.dart';
import 'package:eato_delivery_partner/domain/repository/orders/fetchOrders/fetchOrders_repository.dart';
import 'package:eato_delivery_partner/domain/repository/orders/updateOrderStatus/updateOrderStatus_repository.dart';
import 'package:eato_delivery_partner/domain/repository/partnerDetails/partnerDetails_repository.dart';
import 'package:eato_delivery_partner/domain/repository/registration/registration_repository.dart';
import 'package:eato_delivery_partner/domain/usecase/authentication/current_customer_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/authentication/deleteAccount_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/authentication/rolesPost_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/authentication/signin_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/authentication/signup_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/authentication/trigger_otp_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/authentication/update_current_customer_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/availability/availability_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/location/location_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/orders/fetchOrders/fetchOrders_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/orders/updateOrderStatus/updateOrderStatus_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/partnerDetails/partnerDetails_usecase.dart';
import 'package:eato_delivery_partner/domain/usecase/registration/registration_usecase.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/get/current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/update/update_current_customer_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/deleteAccount/deleteAccount_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/login/trigger_otp_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/roles/rolesPost_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/signUp/signup_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/signin/sigin_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/availability/availability_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/location/location_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/orders/fetchOrders/fetchOrders_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/orders/updateOrderStatus/updateOrderStatus_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/partnerDetails/partnerDetails_cubit.dart';
import 'package:eato_delivery_partner/presentation/cubit/registration/registration_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final GetIt sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => NetworkService());
  sl.registerLazySingleton<DioClient>(
    () => DioClient(sl<Dio>(), secureStorage: sl<FlutterSecureStorage>()),
  );

  //network
  sl.registerFactory<NetworkCubit>(() => NetworkCubit());

  sl.registerLazySingleton<TriggerOtpRemoteDataSource>(
    () => TriggerOtpRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<TriggerOtpRepository>(
    () => TriggerOtpRepositoryImpl(
        remoteDataSource: sl<TriggerOtpRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => TriggerOtpValidationUseCase(repository: sl<TriggerOtpRepository>()),
  );
  sl.registerFactory(() => TriggerOtpCubit(
        useCase: sl<TriggerOtpValidationUseCase>(),
        networkService: sl<NetworkService>(),
      ));

//signin

  sl.registerLazySingleton<SignInRemoteDataSource>(
    () => SignInRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(remoteDataSource: sl<SignInRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => SignInValidationUseCase(repository: sl<SignInRepository>()),
  );
  sl.registerFactory(() => SignInCubit(
        useCase: sl<SignInValidationUseCase>(),
        networkService: sl<NetworkService>(),
        // createCartCubit: sl(),
      ));

  //signup

  sl.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(remoteDataSource: sl<SignUpRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => SignUpValidationUseCase(repository: sl<SignUpRepository>()),
  );
  sl.registerFactory(() => SignUpCubit(
        useCase: sl<SignUpValidationUseCase>(),
        networkService: sl<NetworkService>(),
      ));

  //RolePost
  sl.registerLazySingleton<RolePostRemoteDatasource>(
    () => RolePostRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );

  sl.registerLazySingleton<RolePostRepository>(
    () => RolePostRepoImpl(remoteDataSource: sl<RolePostRemoteDatasource>()),
  );
  sl.registerLazySingleton(
    () => RolePostUsecase(sl<RolePostRepository>()),
  );

  sl.registerFactory(
      () => RolePostCubit(sl<RolePostUsecase>(), sl<NetworkService>()));

  //currentcustomer

  sl.registerLazySingleton<CurrentCustomerRemoteDataSource>(
    () => CurrentCustomerRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<CurrentCustomerRepository>(
    () => CurrentCustomerRepositoryImpl(
        remoteDataSource: sl<CurrentCustomerRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => CurrentCustomerValidationUseCase(sl<CurrentCustomerRepository>()),
  );
  sl.registerFactory(() => CurrentCustomerCubit(
      sl<CurrentCustomerValidationUseCase>(), sl<NetworkService>()));

  //DeleteAccount
  sl.registerLazySingleton<DeleteAccountRemoteDataSource>(
    () => DeleteAccountRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<DeleteAccountRepository>(
    () => DeleteAccountRepositoryImpl(
        remoteDataSource: sl<DeleteAccountRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => DeleteAccountUseCase(repository: sl<DeleteAccountRepository>()),
  );
  sl.registerFactory(() => DeleteAccountCubit(
        sl<DeleteAccountUseCase>(),
      ));

  //location//

  sl.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(client: http.Client()),
  );
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
        remoteDataSource: sl<LocationRemoteDataSource>(),
        latLangRemoteDataSource: sl<LocationRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => LocationUsecase(
        repository: sl<LocationRepository>(),
        latLongRepository: sl<LocationRepository>()),
  );
  sl.registerFactory(() => LocationCubit(
        usecase: sl<LocationUsecase>(),
        networkService: sl<NetworkService>(),
      ));

  //UpdateCurrentCustomer

  sl.registerLazySingleton<UpdateCurrentCustomerRemoteDatasource>(
    () =>
        UpdateCurrentCustomerRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<UpdateCurrentCustomerRepository>(
    () => UpdateCurrentCustomerRepositoryImpl(
        remoteDatasource: sl<UpdateCurrentCustomerRemoteDatasource>()),
  );
  sl.registerLazySingleton(
    () => UpdateCurrentCustomerUseCase(
        repository: sl<UpdateCurrentCustomerRepository>()),
  );
  sl.registerFactory(() => UpdateCurrentCustomerCubit(
        useCase: sl<UpdateCurrentCustomerUseCase>(),
        networkService: sl<NetworkService>(),
      ));

//Registration

  sl.registerLazySingleton<RegistrationRemoteDataSource>(
    () => RegistrationRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepositoryImpl(
        remoteDataSource: sl<RegistrationRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => RegistrationUseCase(repository: sl<RegistrationRepository>()),
  );
  sl.registerFactory(() => RegistrationCubit(
        sl<RegistrationUseCase>(),
      ));

  //Availability
  sl.registerLazySingleton<AvailabilityRemoteDataSource>(
    () => AvailabilityRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<AvailabilityRepository>(
    () => AvailabilityRepositoryImpl(
        remoteDataSource: sl<AvailabilityRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => AvailabilityUseCase(repository: sl<AvailabilityRepository>()),
  );
  sl.registerFactory(() => AvailabilityCubit(
        sl<AvailabilityUseCase>(),
      ));

  //PartnerDetails
  sl.registerLazySingleton<PartnerDetailsRemoteDataSource>(
    () => PartnerDetailsRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<PartnerDetailsRepository>(
    () => PartnerDetailsRepositoryImpl(
        remoteDataSource: sl<PartnerDetailsRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => PartnerDetailsUseCase(repository: sl<PartnerDetailsRepository>()),
  );
  sl.registerFactory(() => PartnerDetailsCubit(
        sl<PartnerDetailsUseCase>(),
      ));

  //FetchOrders

  sl.registerLazySingleton<FetchOrdersRemoteDataSource>(
    () => FetchOrdersRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<FetchOrdersRepository>(
    () => FetchOrdersRepositoryImpl(
        remoteDataSource: sl<FetchOrdersRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () => FetchOrdersUseCase(repository: sl<FetchOrdersRepository>()),
  );
  sl.registerFactory(() => FetchOrdersCubit(
        sl<FetchOrdersUseCase>(),
      ));

  //UpdateOrderStatus

  sl.registerLazySingleton<UpdateOrderStatusRemoteDataSource>(
    () => UpdateOrderStatusRemoteDataSourceImpl(client: sl<DioClient>().dio),
  );
  sl.registerLazySingleton<UpdateOrderStatusRepository>(
    () => UpdateOrderStatusRepositoryImpl(
        remoteDataSource: sl<UpdateOrderStatusRemoteDataSource>()),
  );
  sl.registerLazySingleton(
    () =>
        UpdateOrderStatusUseCase(repository: sl<UpdateOrderStatusRepository>()),
  );
  sl.registerFactory(() => UpdateOrderStatusCubit(
        sl<UpdateOrderStatusUseCase>(),
      ));
}
