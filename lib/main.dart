import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_task/core/theme/app_themes.dart';
import 'package:whatsapp_task/feature/presentation/bloc/call/bloc/call_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/call/bloc/call_event.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/chat/bloc/chat_event.dart';
import 'package:whatsapp_task/feature/presentation/bloc/cubits/theme_cubit.dart';
import 'package:whatsapp_task/feature/presentation/bloc/story/bloc/story_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/story/bloc/story_event.dart';
import 'package:whatsapp_task/feature/presentation/screens/home_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const WhatsApp());
}

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => di.sl<ThemeCubit>(),
        ),
        BlocProvider<ChatBloc>(
          create: (_) => di.sl<ChatBloc>()..add(GetChatsEvent()),
        ),
        BlocProvider<StoryBloc>(
          create: (_) => di.sl<StoryBloc>()..add(GetStoriesEvent()),
        ),
        BlocProvider<CallBloc>(
          create: (_) => di.sl<CallBloc>()..add(GetCallsEvent()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'WhatsApp Task',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeMode,
            home: const HomeScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
