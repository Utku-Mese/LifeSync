import 'package:flutter/material.dart';
import 'package:life_sync/utils/app_theme.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Ara...',
          hintStyle: const TextStyle(
            color: AppTheme.nearlyDarkBlue,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.nearlyDarkBlue,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          fillColor: AppTheme.nearlyWhite,
        ),
      ),
    );
  }
}