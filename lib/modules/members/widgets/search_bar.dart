import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';


class MySearchBar extends StatelessWidget {
  MySearchBar({
    super.key,
    required this.canSearch,
    required this.searchController,
    required this.onChanged,
  });

  final bool canSearch;
  final TextEditingController searchController;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h, // Adjust height as needed
      child: TextFormField(
        style: TextStyle().copyWith(color: context.colorScheme.secondaryContainer.withAlpha(180)),
        enabled: canSearch,
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor:
              canSearch ? Colors.white : context.colorScheme.secondaryContainer,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          hintText: LocaleKeys.search.tr(),
          hintStyle: context.textTheme.bodyLarge?.copyWith(
            color: canSearch ? null : context.colorScheme.secondaryContainer,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey,
            size: 25.r,
          ),
        ),
      ),
    );
  }
}
