import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});

  @override
  State<ChangePinScreen> createState() =>
      _ChangePinScreenState();
}

class _ChangePinScreenState
    extends State<ChangePinScreen> {

  final oldPinController =
      TextEditingController();

  final newPinController =
      TextEditingController();

  final confirmPinController =
      TextEditingController();

  Future<void> savePin() async {

  final messenger =
      ScaffoldMessenger.of(context);

  final navigator =
      Navigator.of(context);

  final prefs =
      await SharedPreferences.getInstance();

  final currentPin =
      prefs.getString('security_pin') ?? '';

  if (!mounted) return;

  if (oldPinController.text != currentPin) {

    messenger.showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'PIN lama salah',
        ),
      ),
    );

    return;
  }

  if (newPinController.text !=
      confirmPinController.text) {

    messenger.showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Konfirmasi PIN tidak cocok',
        ),
      ),
    );

    return;
  }

  if (newPinController.text.length < 4) {

    messenger.showSnackBar(
      const SnackBar(
        content: Text(
          'PIN minimal 4 digit',
        ),
      ),
    );

    return;
  }

  await prefs.setString(
    'security_pin',
    newPinController.text,
  );

  if (!mounted) return;

  messenger.showSnackBar(
    const SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        'PIN berhasil diubah',
      ),
    ),
  );

  navigator.pop();
}

@override
  void dispose() {
    oldPinController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah PIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: oldPinController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'PIN Lama',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: newPinController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'PIN Baru',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: confirmPinController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Konfirmasi PIN Baru',
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: savePin,
              child: const Text(
                'Simpan',
              ),
            ),

          ],
        ),
      ),
    );
  }
}