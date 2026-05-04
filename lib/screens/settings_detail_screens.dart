import 'package:flutter/material.dart';

import 'mood_decor.dart';
import 'mood_model.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key, required this.userName});

  final String userName;

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      title: 'Detail Profil',
      subtitle: 'Atur identitas dan tampilan akunmu',
      icon: Icons.person_rounded,
      accentColor: appPrimary,
      child: Column(
        children: [
          SectionAccentCard(
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor: Color(0xFFE7EBFB),
                      child: Icon(
                        Icons.person_rounded,
                        size: 44,
                        color: appPrimary,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Material(
                        color: appPrimary,
                        shape: const CircleBorder(),
                        child: IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Fitur ganti avatar siap dipakai.',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Pengguna',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                ),
                const SizedBox(height: 14),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Tentang Kamu',
                    prefixIcon: Icon(Icons.notes_rounded),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pop(_nameController.text.trim()),
              child: const Text('Simpan Perubahan'),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool dailyReminder = true;
  bool moodInsight = true;
  bool weeklySummary = false;

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      title: 'Notifikasi',
      subtitle: 'Kelola pengingat dan update yang ingin kamu terima',
      icon: Icons.notifications_rounded,
      accentColor: appPrimary,
      child: Column(
        children: [
          _switchCard(
            title: 'Pengingat Harian',
            subtitle: 'Bantu kamu check-in mood setiap hari.',
            value: dailyReminder,
            onChanged: (value) => setState(() => dailyReminder = value),
          ),
          const SizedBox(height: 12),
          _switchCard(
            title: 'Insight Mood',
            subtitle: 'Dapatkan notifikasi pola atau refleksi otomatis.',
            value: moodInsight,
            onChanged: (value) => setState(() => moodInsight = value),
          ),
          const SizedBox(height: 12),
          _switchCard(
            title: 'Ringkasan Mingguan',
            subtitle: 'Terima rangkuman tren emosimu tiap minggu.',
            value: weeklySummary,
            onChanged: (value) => setState(() => weeklySummary = value),
          ),
        ],
      ),
    );
  }

  Widget _switchCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SectionAccentCard(
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeThumbColor: appPrimary,
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  String selectedType = 'PIN';

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      title: 'Keamanan & Privasi',
      subtitle: 'Lindungi data mood dan akses aplikasimu',
      icon: Icons.lock_rounded,
      accentColor: appPrimary,
      child: Column(
        children: [
          SectionAccentCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Metode Pengaman',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                _securityChoice(
                  title: 'Gunakan PIN',
                  value: 'PIN',
                  icon: Icons.pin_rounded,
                ),
                const SizedBox(height: 12),
                _securityChoice(
                  title: 'Gunakan Pola',
                  value: 'Pola',
                  icon: Icons.gesture_rounded,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SecuritySetupScreen(type: selectedType),
                  ),
                );
              },
              child: Text('Atur $selectedType'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _securityChoice({
    required String title,
    required String value,
    required IconData icon,
  }) {
    final selected = selectedType == value;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => setState(() => selectedType = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? appPrimary.withValues(alpha: 0.12) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? appPrimary : const Color(0xFFE2E7F6),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? appPrimary : const Color(0xFF8D97BA)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: selected ? appPrimary : appInk,
                ),
              ),
            ),
            Icon(
              selected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected ? appPrimary : const Color(0xFFB2BAD3),
            ),
          ],
        ),
      ),
    );
  }
}

class SecuritySetupScreen extends StatefulWidget {
  const SecuritySetupScreen({super.key, required this.type});

  final String type;

  @override
  State<SecuritySetupScreen> createState() => _SecuritySetupScreenState();
}

class _SecuritySetupScreenState extends State<SecuritySetupScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      title: 'Atur ${widget.type}',
      subtitle: 'Buat ${widget.type.toLowerCase()} untuk membuka aplikasi',
      icon: widget.type == 'PIN' ? Icons.pin_rounded : Icons.gesture_rounded,
      accentColor: appPrimary,
      child: Column(
        children: [
          SectionAccentCard(
            child: TextField(
              controller: _controller,
              obscureText: widget.type == 'PIN',
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: widget.type == 'PIN'
                    ? 'Masukkan 4 digit PIN'
                    : 'Masukkan kata kunci pola',
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${widget.type} berhasil disimpan.')),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }
}

class ExportDataScreen extends StatelessWidget {
  const ExportDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _DetailScaffold(
      title: 'Ekspor Data',
      subtitle: 'Unduh histori mood ke format yang kamu butuhkan',
      icon: Icons.file_download_rounded,
      accentColor: appPrimary,
      child: Column(
        children: [
          _exportCard(
            context,
            label: 'Ekspor ke PDF',
            subtitle: 'Cocok untuk dibaca atau dibagikan.',
            icon: Icons.picture_as_pdf_rounded,
            fileName: 'moodspace-report.pdf',
          ),
          const SizedBox(height: 12),
          _exportCard(
            context,
            label: 'Ekspor ke CSV',
            subtitle: 'Cocok untuk analisis spreadsheet.',
            icon: Icons.table_chart_rounded,
            fileName: 'moodspace-data.csv',
          ),
        ],
      ),
    );
  }

  Widget _exportCard(
    BuildContext context, {
    required String label,
    required String subtitle,
    required IconData icon,
    required String fileName,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () async {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          SnackBar(
            content: Text('Menyiapkan ekspor $fileName...'),
            duration: const Duration(seconds: 1),
          ),
        );
        await Future.delayed(const Duration(milliseconds: 1100));
        if (!context.mounted) return;
        messenger.showSnackBar(
          SnackBar(
            content: Text('Ekspor berhasil: $fileName (128 KB)'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: SectionAccentCard(
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: appPrimary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: appPrimary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Color(0xFF6D7695)),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(0xFF98A1BE),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailScaffold extends StatelessWidget {
  const _DetailScaffold({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: MoodDecorBackground(
        accentColor: accentColor,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: Stack(
                  children: [
                    MoodHeader(
                      title: title,
                      subtitle: subtitle,
                      icon: icon,
                      accentColor: accentColor,
                      compact: true,
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: ScreenBackButton(
                        onTap: () => Navigator.of(context).pop(),
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
