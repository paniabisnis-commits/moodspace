import 'package:flutter/material.dart';
import 'mood_decor.dart';
import 'mood_model.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: MoodDecorBackground(
      accentColor: appPrimary,
      child: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Row(
                children: [

                  ScreenBackButton(
                    onTap: () => Navigator.pop(context),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [
                            appPrimary.withValues(alpha: 0.92),
                            appPrimary.withValues(alpha: 0.72),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: appPrimary.withValues(alpha: 0.22),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [

                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.privacy_tip_rounded,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 14),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Text(
                                  'Kebijakan Privasi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 2),

                                Text(
                                  'Privasi dan keamanan data pengguna',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SectionAccentCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [

                          _PolicySection(
                            title: 'Informasi Pengguna',
                            body:
                                'MoodSpace dapat menyimpan data mood, aktivitas, '
                                'dan refleksi yang kamu catat untuk meningkatkan '
                                'pengalaman penggunaan aplikasi.',
                          ),

                          _PolicySection(
                            title: 'Privasi Data',
                            body:
                                'Kami tidak menjual atau membagikan data pribadi '
                                'pengguna kepada pihak ketiga.',
                          ),

                          _PolicySection(
                            title: 'Keamanan',
                            body:
                                'Data pengguna disimpan dengan pendekatan yang '
                                'aman untuk menjaga privasi dan kenyamanan.',
                          ),

                          _PolicySection(
                            title: 'Kontrol Pengguna',
                            body:
                                'Pengguna memiliki kontrol penuh terhadap data '
                                'yang disimpan di dalam aplikasi.',
                          ),

                          _PolicySection(
                            title: 'Penyimpanan Data',
                            body:
                                'Data yang tersimpan di aplikasi digunakan untuk '
                                'menampilkan riwayat mood, statistik emosi, '
                                'dan pengalaman personalisasi pengguna.',
                          ),

                          _PolicySection(
                            title: 'Penggunaan Aplikasi',
                            body:
                                'Pengguna diharapkan menggunakan aplikasi '
                                'secara bijak dan tidak menyalahgunakan fitur '
                                'yang tersedia di dalam MoodSpace.',
                          ),

                          _PolicySection(
                            title: 'Hak Pengguna',
                            body:
                                'Pengguna dapat menghapus data, memperbarui '
                                'informasi, atau menghentikan penggunaan aplikasi '
                                'kapan saja sesuai kebutuhan.',
                          ),

                          _PolicySection(
                            title: 'Persetujuan Pengguna',
                            body:
                                'Dengan menggunakan MoodSpace, pengguna dianggap '
                                'telah memahami dan menyetujui kebijakan privasi '
                                'yang berlaku di aplikasi ini.',
                          ),

                          _PolicySection(
                            title: 'Kontak & Bantuan',
                            body:
                                'Jika memiliki pertanyaan terkait privasi atau '
                                'keamanan data, pengguna dapat menghubungi tim '
                                'pengembang melalui menu bantuan aplikasi.',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Center(
                      child: Text(
                        'Last updated • May 2026',
                        style: TextStyle(
                          color: Color(0xFF9AA3BD),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  const _PolicySection({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: appInk,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            body,
            style: const TextStyle(
              height: 1.7,
              color: Color(0xFF697391),
            ),
          ),
        ],
      ),
    );
  }
}