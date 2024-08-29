import 'package:flutter/material.dart';
import 'dragDownIndicator.dart';

class ContentList extends StatelessWidget {
  const ContentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DragDownIndicator(),
        const SizedBox(height: 16),
        const Text('Content List'),
        Flexible(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: 26,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('Item $index'));
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
