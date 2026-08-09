import 'package:flutter/material.dart';
import 'package:todo_ji/models/on_boading_model.dart';
import 'package:todo_ji/models/onborading.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: 'assets/images/logo.png',
      title: 'Discover',
      description:
          'Organize your day and keep everything you need in one place.',
    ),
    OnboardingModel(
      image: 'assets/images/logo.png',
      title: 'Create Tasks',
      description:
          'Quickly create tasks and manage everything you need to complete.',
    ),
    OnboardingModel(
      image: 'assets/images/logo.png',
      title: 'Track Progress',
      description: 'Track your daily progress and stay focused on your goals.',
    ),
    OnboardingModel(
      image: 'assets/images/logo.png',
      title: 'Start Today!',
      description: 'Take control of your day and get things done with Taski.',
    ),
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login/home
      debugPrint('Get Started');
    }
  }

  void skip() {
    _pageController.animateToPage(
      pages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFA63D),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.20),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),

            child: Column(
              children: [
                // =========================
                // SCROLLABLE CONTENT
                // =========================
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,

                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },

                    itemBuilder: (context, index) {
                      return OnboardingContent(
                        page: pages[index],
                        currentPage: currentPage,
                        totalPages: pages.length,
                        onSkip: skip,
                      );
                    },
                  ),
                ),

                // =========================
                // FIXED BOTTOM BUTTON
                // =========================
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),

                  child: SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton(
                      onPressed: nextPage,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7535),
                        foregroundColor: Colors.white,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      child: Text(
                        currentPage == pages.length - 1
                            ? 'Get Started'
                            : 'Next',

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
