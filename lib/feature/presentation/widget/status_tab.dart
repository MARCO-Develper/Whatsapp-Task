import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/story/bloc/story_bloc.dart';
import 'package:whatsapp_task/feature/presentation/bloc/story/bloc/story_state.dart';
import 'package:whatsapp_task/feature/presentation/widget/animated_story_item.dart';

class StatusTab extends StatelessWidget {
  const StatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(
      builder: (context, state) {
        if (state is StoryLoading) return const Center(child: CircularProgressIndicator());
        if (state is StoryError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        if (state is StoryLoaded) {
          return Column(
            children: [
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.stories.length,
                  itemBuilder: (context, index) => AnimatedStoryItem(
                    story: state.stories[index],
                    index: index,
                    onTap: () {}, 
                  ),
                ),
              ),
              const Expanded(
                child: Center(child: Text("Tap to view stories")),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
