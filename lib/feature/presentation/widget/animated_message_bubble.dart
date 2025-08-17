import 'package:flutter/material.dart';
import '../../domain/entities/message.dart';

class AnimatedMessageBubble extends StatefulWidget {
  final Message message;
  final int index;

  const AnimatedMessageBubble({
    Key? key,
    required this.message,
    required this.index,
  }) : super(key: key);

  @override
  State<AnimatedMessageBubble> createState() => _AnimatedMessageBubbleState();
}

class _AnimatedMessageBubbleState extends State<AnimatedMessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500 + (widget.index * 50)),
      vsync: this,
    );

    final slideOffset = widget.message.isMe 
        ? const Offset(1.0, 0.0) 
        : const Offset(-1.0, 0.0);

    _slideAnimation = Tween<Offset>(
      begin: slideOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    // Start animation with a delay based on index
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: widget.message.isMe 
                  ? MainAxisAlignment.end 
                  : MainAxisAlignment.start,
              children: [
                if (!widget.message.isMe) const SizedBox(width: 8),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: widget.message.isMe 
                          ? const Color(0xFF005C4B)
                          : (isDark ? const Color(0xFF1F2C33) : Colors.white),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.message.text,
                          style: TextStyle(
                            color: widget.message.isMe 
                                ? Colors.white 
                                : (isDark ? Colors.white : Colors.black87),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.message.time,
                              style: TextStyle(
                                color: widget.message.isMe 
                                    ? Colors.white70 
                                    : (isDark ? Colors.white60 : Colors.grey[600]),
                                fontSize: 11,
                              ),
                            ),
                            if (widget.message.isMe) ...[
                              const SizedBox(width: 4),
                              Icon(
                                _getStatusIcon(widget.message.status),
                                size: 16,
                                color: _getStatusColor(widget.message.status),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.message.isMe) const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.sent:
        return Icons.done;
      case MessageStatus.delivered:
        return Icons.done_all;
      case MessageStatus.read:
        return Icons.done_all;
    }
  }

  Color _getStatusColor(MessageStatus status) {
    switch (status) {
      case MessageStatus.sent:
        return Colors.white70;
      case MessageStatus.delivered:
        return Colors.white70;
      case MessageStatus.read:
        return const Color(0xFF4FC3F7);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
