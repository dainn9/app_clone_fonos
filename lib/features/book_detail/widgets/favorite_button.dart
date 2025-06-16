import 'package:app_clone_fonos/features/book_detail/widgets/circle_icon_button_book.dart';
import 'package:flutter/material.dart';
import '../../../core/design_systems/design_system_export.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return CircleIconButtonBook(
      icon: isFavorited ? Icons.favorite : Icons.favorite_border,
      iconColor: Colors.white,
      backgroundColor: Colors.grey.withOpacity(0.2),
      onPressed: () {
        setState(() {
          isFavorited = !isFavorited;
        });
      },
    );
  }
}
