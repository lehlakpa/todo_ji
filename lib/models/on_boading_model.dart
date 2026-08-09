import 'package:flutter/material.dart';
import 'package:todo_ji/models/onborading.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingModel page;
  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;

  const OnboardingContent({
    super.key,
    required this.page,
    required this.currentPage,
    required this.totalPages,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),

      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,

            child: currentPage == 0
                ? const SizedBox(height: 28)
                : GestureDetector(
                    onTap: onSkip,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7535),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                page.image,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            page.title,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 15),
          Text(
            page.description,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: List.generate(totalPages, (index) {
              final selected = index == currentPage;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),

                margin: const EdgeInsets.symmetric(horizontal: 4),

                width: selected ? 18 : 9,
                height: 9,

                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFFF7535)
                      : Colors.grey.shade300,

                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
