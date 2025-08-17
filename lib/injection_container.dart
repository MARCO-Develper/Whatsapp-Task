import 'package:get_it/get_it.dart';

// Data Layer
import 'package:whatsapp_task/feature/data/datasources/local/local_data_source.dart';
import 'package:whatsapp_task/feature/data/repositories/call_repository_impl.dart';
import 'package:whatsapp_task/feature/data/repositories/chat_repository_impl.dart';
import 'package:whatsapp_task/feature/data/repositories/story_repository_impl.dart';

// Domain Layer
import 'package:whatsapp_task/feature/domain/repositories/call_repository.dart';
import 'package:whatsapp_task/feature/domain/repositories/chat_repository.dart';
import 'package:whatsapp_task/feature/domain/repositories/story_repository.dart';
import 'package:whatsapp_task/feature/domain/usecases/get_all_calls.dart';
import 'package:whatsapp_task/feature/domain/usecases/get_all_chats.dart';
import 'package:whatsapp_task/feature/domain/usecases/get_all_stories.dart';
import 'package:whatsapp_task/feature/domain/usecases/send_message.dart';

// Presentation Layer
import 'package:whatsapp_task/feature/presentation/bloc/call/bloc/call_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/cubits/theme_cubit.dart';
import 'package:whatsapp_task/feature/presentation/bloc/story/bloc/story_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoCs / Cubits
  sl.registerFactory(() => ChatBloc(
        getAllChats: sl(),
        sendMessage: sl(),
      ));

  sl.registerFactory(() => StoryBloc(getAllStories: sl()));

  sl.registerFactory(() => CallBloc(getAllCalls: sl()));

  sl.registerLazySingleton(() => ThemeCubit());

  // Use cases
  sl.registerLazySingleton(() => GetAllChats(sl()));
  sl.registerLazySingleton(() => SendMessage(sl()));
  sl.registerLazySingleton(() => GetAllStories(sl()));
  sl.registerLazySingleton(() => GetAllCalls(sl()));

  // Repositories
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<StoryRepository>(
    () => StoryRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<CallRepository>(
    () => CallRepositoryImpl(localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
}
