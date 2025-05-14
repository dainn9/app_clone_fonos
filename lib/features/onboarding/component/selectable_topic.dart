import 'package:flutter/material.dart';

class SelectableTopic extends StatefulWidget {
  final IconData icon;
  final String content;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableTopic({
    super.key,
    required this.icon,
    required this.content,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<SelectableTopic> createState() => _SelectableTopicState();
}

class _SelectableTopicState extends State<SelectableTopic> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color:
                widget.isSelected
                    ? Colors.blue.withOpacity(0.1)
                    : (_isHovering
                        ? Colors.grey.withOpacity(0.05)
                        : Colors.white),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color:
                  widget.isSelected
                      ? Colors.blue
                      : (_isHovering
                          ? Colors.grey.withOpacity(0.5)
                          : Colors.grey.withOpacity(0.2)),
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color:
                    widget.isSelected
                        ? Colors.blue
                        : (_isHovering ? Colors.black87 : Colors.black),
              ),
              const SizedBox(width: 10),
              Text(
                widget.content,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      widget.isSelected
                          ? Colors.blue
                          : (_isHovering ? Colors.black87 : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
