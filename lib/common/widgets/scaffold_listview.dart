import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/common/widgets/custom_appbar.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';

class ScaffoldListView<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const ScaffoldListView({
    Key? key,
    required this.title,
    required this.items,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleStyle),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 20),
                itemBuilder:
                    (context, index) => itemBuilder(context, items[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
