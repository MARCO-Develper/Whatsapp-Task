import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_task/feature/domain/entities/call.dart';
import 'package:whatsapp_task/feature/presentation/bloc/call/bloc/call_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/call/bloc/call_state.dart';

class CallsTab extends StatelessWidget {
  const CallsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      builder: (context, state) {
        if (state is CallLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CallError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text("Error loading calls"),
              ],
            ),
          );
        } else if (state is CallLoaded) {
          return ListView.builder(
            itemCount: state.calls.length,
            itemBuilder: (context, index) {
              final call = state.calls[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getAvatarColor(call.name),
                  child: Text(
                    call.name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(call.name),
                subtitle: Row(
                  children: [
                    Icon(
                      _getCallIcon(call.status),
                      size: 16,
                      color: _getCallColor(call.status),
                    ),
                    const SizedBox(width: 4),
                    Text(call.time),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    call.type == CallType.video ? Icons.videocam : Icons.call,
                    color: const Color(0xFF25D366),
                  ),
                  onPressed: () {
                    // TODO: implement make call
                  },
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  static IconData _getCallIcon(CallStatus status) {
    switch (status) {
      case CallStatus.incoming:
        return Icons.call_received;
      case CallStatus.outgoing:
        return Icons.call_made;
      case CallStatus.missed:
        return Icons.call_missed;
    }
  }

  static Color _getCallColor(CallStatus status) {
    switch (status) {
      case CallStatus.incoming:
      case CallStatus.outgoing:
        return Colors.green;
      case CallStatus.missed:
        return Colors.red;
    }
  }

  static Color _getAvatarColor(String name) {
    final colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.indigo,
      Colors.blue,
      Colors.teal,
      Colors.green,
      Colors.orange,
    ];
    return colors[name.hashCode % colors.length];
  }
}
