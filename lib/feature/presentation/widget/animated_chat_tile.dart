import 'package:flutter/material.dart';
import '../../domain/entities/chat.dart';

class AnimatedChatTile extends StatefulWidget {
  final Chat chat;
  final VoidCallback onTap;
  final int index;

  const AnimatedChatTile({
    Key? key,
    required this.chat,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  State<AnimatedChatTile> createState() => _AnimatedChatTileState();
}

class _AnimatedChatTileState extends State<AnimatedChatTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600 + (widget.index * 100)),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    ));

    // Start animation after a small delay
    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // إزالة الانيميشن المعقد والاستدعاء المباشر
              print('Tile tapped for: ${widget.chat.name}'); // للتأكد
              widget.onTap(); // استدعاء مباشر
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: 'avatar_${widget.chat.id}',
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: _getAvatarColor(widget.chat.name),
                          child: Text(
                            widget.chat.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      if (widget.chat.isOnline)
                        Positioned(
                          right: 2,
                          bottom: 2,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFF25D366),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.chat.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              widget.chat.time,
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.chat.unreadCount > 0
                                    ? const Color(0xFF25D366)
                                    : (isDark ? Colors.white60 : Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.chat.lastMessage,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark ? Colors.white70 : Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.chat.unreadCount > 0)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF25D366),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.chat.unreadCount > 99 ? '99+' : widget.chat.unreadCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.red[400]!,
      Colors.pink[400]!,
      Colors.purple[400]!,
      Colors.deepPurple[400]!,
      Colors.indigo[400]!,
      Colors.blue[400]!,
      Colors.lightBlue[400]!,
      Colors.cyan[400]!,
      Colors.teal[400]!,
      Colors.green[400]!,
      Colors.lightGreen[400]!,
      Colors.lime[400]!,
      Colors.yellow[400]!,
      Colors.amber[400]!,
      Colors.orange[400]!,
      Colors.deepOrange[400]!,
    ];
    
    return colors[name.hashCode % colors.length];
  }
}