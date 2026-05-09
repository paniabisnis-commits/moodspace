import 'package:flutter/material.dart';
import 'mood_decor.dart';
import 'mood_model.dart';

class MentalHealthChatbotScreen extends StatefulWidget {
  const MentalHealthChatbotScreen({super.key});

  @override
  State<MentalHealthChatbotScreen> createState() =>
      _MentalHealthChatbotScreenState();
}

class _MentalHealthChatbotScreenState
    extends State<MentalHealthChatbotScreen> {

  final TextEditingController controller = TextEditingController();

  final ScrollController scrollController = ScrollController();
  bool isTyping = false;
  final List<Map<String, dynamic>> messages = [
    {
      'isUser': false,
      'text':
          'Halo  Aku di sini untuk menemani kamu. Cerita aja pelan-pelan ya.',
          'time': TimeOfDay.now(),
    },
  ];

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    final text = controller.text.trim();

    if (text.isEmpty || isTyping) return;

    setState(() {
      messages.add({
        'isUser': true,
        'text': text,
        'time': TimeOfDay.now(),
      });

      isTyping = true;
    });

    controller.clear();
    FocusScope.of(context).unfocus();
    scrollToBottom();

    await Future.delayed(
      const Duration(milliseconds: 1200),
    );

    final reply = generateReply(text);

    setState(() {
      isTyping = false;

      messages.add({
        'isUser': false,
        'text': reply,
        'time': TimeOfDay.now(),
      });
    });

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String generateReply(String text) {
    final lowerText = text.toLowerCase();

    if (lowerText == 'halo' ||
        lowerText == 'hai' ||
        lowerText == 'hi') {
      return 'Halo juga  Senang bisa ngobrol sama kamu hari ini. Gimana perasaanmu sekarang?';
    }

    if (lowerText.contains('sedih') ||
        lowerText.contains('capek') ||
        lowerText.contains('lelah')) {
      return 'Aku ngerti rasanya pasti berat ya. Tidak apa-apa kalau hari ini terasa melelahkan. Coba beri waktu sebentar untuk istirahat dan bernapas pelan ';
    }

    if (lowerText.contains('cemas') ||
        lowerText.contains('takut') ||
        lowerText.contains('overthinking')) {
      return 'Perasaan cemas itu valid kok. Kamu tidak harus menyelesaikan semuanya sekaligus. Fokus dulu ke satu hal kecil yang bisa kamu kontrol ';
    }

    if (lowerText.contains('senang') ||
        lowerText.contains('bahagia')) {
      return 'Senang mendengarnya  Semoga hal baik hari ini bisa jadi energi positif untuk kamu terus menjalani harimu.';
    }

    if (lowerText.contains('marah') ||
        lowerText.contains('kesal')) {
      return 'Perasaan marah juga wajar dirasakan. Yang penting kamu tetap memberi ruang untuk dirimu menenangkan pikiran terlebih dahulu ';
    }

    if (lowerText.contains('stress')) {
      return 'Kalau semuanya terasa berat, coba fokus ke satu hal kecil dulu ya. Kamu tidak harus menyelesaikan semuanya sekaligus.';
    }

    if (lowerText.contains('sendiri')) {
      return 'Kamu tidak sendirian kok. Kadang berbagi cerita sedikit demi sedikit juga bisa membantu hati terasa lebih ringan.';
    }

    if (lowerText.contains('bingung')) {
      return 'Tidak apa-apa merasa bingung. Pelan-pelan aja, kamu tidak harus menemukan semua jawabannya hari ini.';
    }

    return 'Terima kasih sudah cerita Aku senang kamu mau berbagi perasaanmu hari ini. Jangan lupa tetap jaga diri dan beri ruang untuk beristirahat ya.';
  }

  @override
  Widget build(BuildContext context) {

    final keyboardOpen =
        MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appBackground,

      body: MoodDecorBackground(
        accentColor: appPrimary,

        child: SafeArea(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),

                child: Row(
                  children: [

                    Container(
                      width: 50,
                      height: 50,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: IconButton(
                        onPressed: () => Navigator.pop(context),

                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: appInk,
                          size: 20,
                        ),
                      ),
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
                                Icons.favorite_rounded,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(width: 14),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    'MoodSpace Assistant',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 2),

                                  Text(
                                    'Tempat cerita dan refleksi diri',
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

              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,

                  padding: const EdgeInsets.fromLTRB(
                    20,
                    8,
                    20,
                    24,
                  ),

                  itemCount: messages.length,

                  itemBuilder: (context, index) {

                    final message = messages[index];
                    final isUser = message['isUser'];

                    return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),

                        child: Row(
                        mainAxisAlignment:
                            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,

                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [

                          if (!isUser)
                            Container(
                              width: 38,
                              height: 38,
                              margin: const EdgeInsets.only(
                                right: 8,
                                bottom: 10,
                              ),

                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    appPrimary,
                                    appSecondary,
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),

                              child: const Icon(
                                Icons.favorite_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),

                          Flexible(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOut,
                        margin: const EdgeInsets.only(bottom: 14),

                        padding: const EdgeInsets.all(16),

                        constraints: const BoxConstraints(
                          maxWidth: 300,
                        ),

                        decoration: BoxDecoration(
                          gradient: isUser
                              ? LinearGradient(
                                  colors: [
                                    appPrimary,
                                    appPrimary.withValues(alpha: 0.82),
                                  ],
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.white,
                                    const Color(0xFFF8F9FF),
                                  ],
                                ),

                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(24),
                            topRight: const Radius.circular(24),
                            bottomLeft: Radius.circular(isUser ? 24 : 8),
                            bottomRight: Radius.circular(isUser ? 8 : 24),
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              spreadRadius: 0.2,
                            ),
                          ],
                        ),

                        child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  message['text'],
                                  style: TextStyle(
                                    color: isUser
                                        ? Colors.white
                                        : appInk,
                                    fontSize: 14,
                                    height: 1.6,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    message['time'].format(context),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isUser
                                          ? Colors.white70
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                                      ),
                                    ),
                                 ],
                              ),
                            );
                          },
                        ),      
                      ),
              if (isTyping)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 14,
                  ),

                  child: Row(
                    children: [

                      Container(
                        width: 38,
                        height: 38,

                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              appPrimary,
                              appSecondary,
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Row(
                          children: [
                            const _TypingDot(delay: 0),
                            const SizedBox(width: 4),
                            const _TypingDot(delay: 200),
                            const SizedBox(width: 4),
                            const _TypingDot(delay: 400),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              AnimatedPadding(
                duration: const Duration(milliseconds: 200),

                padding: EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  keyboardOpen ? 14 : 24,
                ),

                child: Row(
                  children: [

                    Expanded(
                      child: TextField(
                        enabled: !isTyping,
                        controller: controller,
                        cursorColor: appPrimary,

                        minLines: 1,
                        maxLines: 4,

                        textInputAction: TextInputAction.send,

                        onSubmitted: (_) async => await sendMessage(),

                        decoration: InputDecoration(
                          hintText: 'Tulis perasaanmu...',

                          filled: true,
                          fillColor: Colors.white,

                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    GestureDetector(
                      onTap: () async {
                        await sendMessage();
                      },

                      child: Container(
                        width: 56,
                        height: 56,

                        decoration: BoxDecoration(
                          color: appPrimary,
                          shape: BoxShape.circle,

                          boxShadow: [
                            BoxShadow(
                              color: appPrimary.withValues(alpha: 0.28),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypingDot extends StatefulWidget {
  const _TypingDot({
    required this.delay,
  });

  final int delay;

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
void initState() {
  super.initState();

  controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  Future.delayed(
    Duration(milliseconds: widget.delay),
    () {
      if (mounted) {
        controller.repeat(reverse: true);
      }
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.3, end: 1.0).animate(controller),

      child: Container(
        width: 8,
        height: 8,

        decoration: const BoxDecoration(
          color: appPrimary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}