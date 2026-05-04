
import 'package:get_it/get_it.dart';
import 'package:whatsapp/feature/authorization/data/datasource/auth_remote_datasource.dart';
import 'package:whatsapp/feature/authorization/data/repository/auth_repo.dart';
import 'package:whatsapp/feature/authorization/presentation/cubit/authorization_cubit.dart';
import 'package:whatsapp/feature/chat/data/datasource/chat_remote_datasource.dart';
import 'package:whatsapp/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:whatsapp/feature/chat/presentation/cubit/message_cubit.dart';
import 'package:whatsapp/feature/chat/presentation/cubit/users_cubit.dart';
import 'package:whatsapp/feature/nav_screen/cubit/navigation_cubit.dart';
import 'package:whatsapp/feature/profile/data/datasource/profile_remote_datasource.dart';
import 'package:whatsapp/feature/profile/data/repository/profile_repo.dart';
import 'package:whatsapp/feature/profile/presentation/cubit/profile_cubit.dart';

import '../../feature/chat/data/repository/chat_repo.dart';

final getIt = GetIt.instance;
void configureDependencies(){
getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasource(),);
getIt.registerLazySingleton<ProfileRemoteDatasource>(() => ProfileRemoteDatasource(),);
getIt.registerLazySingleton<ChatRemoteDatasource>(() => ChatRemoteDatasource(),);
getIt.registerLazySingleton<AuthRepo>(()=>AuthRepo(getIt<AuthRemoteDatasource>()));
getIt.registerLazySingleton<ProfileRepo>(()=>ProfileRepo(getIt<ProfileRemoteDatasource>()));
getIt.registerLazySingleton<ChatRepo>(()=>ChatRepo(getIt<ChatRemoteDatasource>()));
getIt.registerLazySingleton<AuthorizationCubit>(()=>AuthorizationCubit(getIt<AuthRepo>()));
getIt.registerLazySingleton<ProfileCubit>(()=>ProfileCubit(getIt<ProfileRepo>()));
getIt.registerLazySingleton<ChatCubit>(()=>ChatCubit(getIt<ChatRepo>()));
getIt.registerLazySingleton<MessageCubit>(()=>MessageCubit(getIt<ChatRepo>()));
getIt.registerLazySingleton<UsersCubit>(()=>UsersCubit(getIt<ChatRepo>()));
getIt.registerLazySingleton<NavigationCubit>(()=>NavigationCubit());

}