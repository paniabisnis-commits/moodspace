import 'package:flutter/material.dart';

import 'mood_decor.dart';
import 'mood_model.dart';
import 'test_category_model.dart';
import 'test_detail_screen.dart';
import 'test_result_model.dart';

class TestCategoryScreen extends StatelessWidget {
  const TestCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: MoodDecorBackground(
        accentColor: appPrimary,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverPinnedHeader(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                    child: Row(
                      children: [
                        ScreenBackButton(
                          onTap: () => Navigator.of(context).pop(),
                          color: appPrimary,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: MoodHeader(
                            title: 'Kategori Tes',
                            subtitle: 'Pilih tes yang ingin kamu ikuti',
                            icon: Icons.psychology_alt_rounded,
                            accentColor: appPrimary,
                            compact: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: testCategories.length,
                  itemBuilder: (context, index) {
                    final item = testCategories[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () async {
                        final result = await Navigator.of(context)
                            .push<TestResultModel>(
                              MaterialPageRoute(
                                builder: (_) =>
                                    TestDetailScreen(category: item),
                              ),
                            );

                        if (!context.mounted || result == null) return;
                        Navigator.of(context).pop(result);
                      },
                      child: SectionAccentCard(
                        accentColor: appPrimary,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: item.color.withValues(alpha: 0.14),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                item.icon,
                                color: item.color,
                                size: 26,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: appInk,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color: Color(0xFF6D7695),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: const [
                                Flexible(
                                  child: Text(
                                    'Mulai Tes',
                                    style: TextStyle(
                                      color: appPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 18,
                                  color: appPrimary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
