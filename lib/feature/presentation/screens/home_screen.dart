import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/cubits/theme_cubit.dart';
import 'package:whatsapp_task/feature/presentation/widget/calls_tab.dart';
import 'package:whatsapp_task/feature/presentation/widget/chats_tab.dart';
import 'package:whatsapp_task/feature/presentation/widget/home_fab.dart';
import 'package:whatsapp_task/feature/presentation/widget/status_tab.dart';
import 'package:whatsapp_task/feature/presentation/screens/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fabAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        actions: [
          IconButton(
              icon: const Icon(Icons.camera_alt_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'new_group', child: Text('New group')),
              const PopupMenuItem(
                  value: 'new_broadcast', child: Text('New broadcast')),
              const PopupMenuItem(
                  value: 'linked_devices', child: Text('Linked devices')),
              const PopupMenuItem(
                  value: 'starred', child: Text('Starred messages')),
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
              PopupMenuItem(
                  value: 'theme',
                  child: Text(isDark ? 'Light mode' : 'Dark mode')),
            ],
            onSelected: (value) {
              if (value == 'theme') context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Status'),
            Tab(text: 'Chats'),
            Tab(text: 'Calls')
          ],
          onTap: (_) {
            _fabAnimationController.reset();
            _fabAnimationController.forward();
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const StatusTab(),
          ChatsTab(
            onChatTap: _onChatTap,
          ),
          const CallsTab(),
        ],
      ),
      floatingActionButton: HomeFAB(
        tabController: _tabController,
        animationController: _fabAnimationController,
      ),
    );
  }

  void _onChatTap(dynamic chat) {
    print('Chat tapped: ${chat.name}');

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ChatScreen(chat: chat),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
              position: animation.drive(tween), child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }
}
