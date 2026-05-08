import 'package:flutter/material.dart';

import 'commitment_screen.dart';
import 'mood_decor.dart';
import 'mood_model.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF7F8FC),

      body: MoodDecorBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,

                padding: EdgeInsets.fromLTRB(
                  28,
                  32,
                  28,
                  keyboardOpen ? 24 : 40,
                ),

                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight -32,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [

                        Column(
                          children: [

                            Container(
                              width: 82,
                              height: 82,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: appSecondary.withValues(alpha: 0.18),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.waving_hand_rounded,
                                color: appPrimary,
                                size: 38,
                              ),
                            ),

                            const SizedBox(height: 24),

                            const Text(
                              'Kami harus memanggilmu apa?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3F51B5),
                              ),
                            ),

                            const SizedBox(height: 14),

                            const Text(
                              'Supaya pengalamanmu terasa lebih personal dan hangat.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [

                            SectionAccentCard(
                              padding: const EdgeInsets.all(22),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const Text(
                                    'Nama Kamu',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  TextField(
                                    controller: nameController,
                                    textInputAction: TextInputAction.done,

                                    decoration: const InputDecoration(
                                      hintText: 'Masukkan nama...',
                                      prefixIcon: Icon(
                                        Icons.person_outline_rounded,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  const Text(
                                    'Nama ini akan muncul di beranda dan pengaturan profilmu.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF7D87A6),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 28),

                            SizedBox(
                              width: double.infinity,
                              height: 65,

                              child: ElevatedButton(
                                onPressed: () {
                                  final name = nameController.text.trim();

                                  if (name.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Masukkan nama kamu dulu ya.',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CommitmentScreen(userName: name),
                                    ),
                                  );
                                },

                                child: const Text('Lanjutkan'),
                              ),
                            ),

                            SizedBox(
                              height: keyboardOpen ? 20 : 40,
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
        ),
      );
    }
  }