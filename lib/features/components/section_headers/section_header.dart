import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;

  // Icon trước title
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final Color? leadingIconBackgroundColor;

  // Icon sau title
  final IconData? trailingTitleIcon;
  final Color? trailingTitleIconColor;
  final Color? trailingTitleIconBackgroundColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAll,

    // Icon trước title
    this.leadingIcon,
    this.leadingIconColor = Colors.black87,
    this.leadingIconBackgroundColor,

    // Icon sau title
    this.trailingTitleIcon,
    this.trailingTitleIconColor = Colors.white,
    this.trailingTitleIconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Phần bên trái: Title, icons và subtitle
          Expanded(
            child: Row(
              children: [
                // Icon trước title (nếu có)
                if (leadingIcon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: leadingIconBackgroundColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                        leadingIcon,
                        color: leadingIconColor,
                        size: 16
                    ),
                  ),
                  const SizedBox(width: 8),
                ],

                // Title và subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title và icon sau title
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: Color(0xFF2B3A5C),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Icon sau title (nếu có)
                          if (trailingTitleIcon != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: trailingTitleIconBackgroundColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                  trailingTitleIcon,
                                  color: trailingTitleIconColor,
                                  size: 14
                              ),
                            ),
                          ],
                        ],
                      ),

                      // Subtitle (nếu có)
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Khoảng cách giữa title và nút "Xem tất cả"
          const SizedBox(width: 8),

          // Nút "Xem tất cả" (nếu có)
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child:  Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Color(0xFF2B3A5C),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
