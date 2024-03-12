import 'package:flutter/material.dart';

import '../../common/colors.dart';


class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onSubmitted;
  final VoidCallback? onPressed;

  const SearchInput({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: 'Search City',
                suffixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const SizedBox(
            height: 50,
            child: Center(
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
            ),
          )
        )
      ],
    );
  }
}
