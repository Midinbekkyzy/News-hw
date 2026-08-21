import 'package:flutter/material.dart';
import 'package:news_hw/core/di/service_locator.dart';
import 'package:news_hw/core/service/storage_service/shared_preferences_service.dart';
import 'package:news_hw/features/auth/presentation/auth_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _index = 0;

  static const _slides = [
    _OnboardingSlide(
      icon: Icons.newspaper_outlined,
      title: 'Новости в одном месте',
      subtitle:
          'Следите за актуальными событиями и читайте свежие материалы без лишнего шума.',
    ),
    _OnboardingSlide(
      icon: Icons.search_rounded,
      title: 'Ищите то, что важно',
      subtitle:
          'Находите темы по запросу и смотрите подборки: тренды, новинки и рекомендации.',
    ),
    _OnboardingSlide(
      icon: Icons.menu_book_rounded,
      title: 'Читайте подробно',
      subtitle:
          'Открывайте статью целиком, смотрите картинку, автора и полный текст новости.',
    ),
  ];

  bool get _isLastPage => _index == _slides.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await getIt<SharedPreferencesService>().saveBool(
      SharedPreferencesKeys.hasSeenOnboarding,
      true,
    );
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const AuthPage()),
    );
  }

  void _next() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 16, 30, 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: _isLastPage
                    ? const SizedBox(height: 48)
                    : TextButton(
                        onPressed: _finish,
                        child: const Text(
                          'Пропустить',
                          style: TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _slides.length,
                  onPageChanged: (index) => setState(() => _index = index),
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F1F1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            slide.icon,
                            size: 44,
                            color: const Color(0xFF232323),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF232323),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          slide.subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.35,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_slides.length, (index) {
                  final isActive = index == _index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF232323)
                          : const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: _isLastPage ? _finish : _next,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: Text(_isLastPage ? 'Пропустить' : 'Далее'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}
