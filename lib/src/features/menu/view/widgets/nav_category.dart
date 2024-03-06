import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/data/text_styles.dart';

class NavCategory extends StatelessWidget {
  const NavCategory({super.key, required this.tags, required this.current});

  final List<String> tags;
  final int current;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 60,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, _) => SizedBox(width: 16),
                itemCount: tags.length,
                itemBuilder: (context, index) =>
                    FilterChip(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        side: BorderSide.none,
                        label: Text(
                          tags[index],
                            style: AppTextStyles.chip,
                        ),
                        selected: index == current ? true : false,
                        onSelected: (bool selected) {
                        },
                    ),
            ),
    );
  }


}