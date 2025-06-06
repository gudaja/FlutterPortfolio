import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/utils/breakpoints.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/widgets/footer.dart';
import 'package:portfolio/widgets/hero_section.dart';
import 'package:portfolio/widgets/modern_navbar.dart';
import 'package:portfolio/widgets/modern_skill_card.dart';
import 'package:google_fonts/google_fonts.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> with TickerProviderStateMixin {
  late final List<Map> interests;
  late final GlobalKey intrestsKey;
  late final GlobalKey skillsKey;
  late final GlobalKey homeKey;
  late final ScrollController scrollController;
  late final RxBool showFloatingButton;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final List<SkillData> skills = [
    SkillData(
      title: 'Flutter',
      description:
          'Cross-platform mobile development z Dart. Tworzenie nowoczesnych aplikacji iOS i Android.',
      iconPath: 'assets/images/flutter.png',
      progress: 0.9,
      primaryColor: CustomColors.primary,
      secondaryColor: CustomColors.primaryDark,
    ),
    SkillData(
      title: 'Python',
      description:
          'Backend development, AI/ML, automatyzacja. Django, FastAPI, data science.',
      iconPath: 'assets/images/python.png',
      progress: 0.85,
      primaryColor: CustomColors.secondary,
      secondaryColor: CustomColors.secondaryDark,
    ),
    SkillData(
      title: 'Java',
      description:
          'Enterprise development, Spring Boot, microservices, Android development.',
      iconPath: 'assets/images/java.png',
      progress: 0.8,
      primaryColor: CustomColors.accent,
      secondaryColor: CustomColors.accentDark,
    ),
  ];

  @override
  void initState() {
    intrestsKey = GlobalKey();
    skillsKey = GlobalKey();
    homeKey = GlobalKey();
    scrollController = ScrollController();
    showFloatingButton = false.obs;

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    interests = [
      {
        'intrest': 'Flutter Development',
        'color': CustomColors.primary,
        'textColor': CustomColors.darkBackground,
      },
      {
        'intrest': 'UI/UX Design',
        'color': CustomColors.secondary,
        'textColor': CustomColors.textPrimary,
      },
      {
        'intrest': 'Mobile Apps',
        'color': CustomColors.accent,
        'textColor': CustomColors.darkBackground,
      },
      {
        'intrest': 'Problem Solving',
        'color': CustomColors.purple,
        'textColor': CustomColors.textPrimary,
      },
      {
        'intrest': 'Tech Innovation',
        'color': CustomColors.primary,
        'textColor': CustomColors.darkBackground,
      },
      {
        'intrest': 'Code Quality',
        'color': CustomColors.secondary,
        'textColor': CustomColors.textPrimary,
      },
    ];

    scrollController.addListener(() {
      if (scrollController.offset >= Breakpoints.floatingButton) {
        showFloatingButton.value = true;
      } else {
        showFloatingButton.value = false;
      }
    });

    _fadeController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.darkBackground,
      floatingActionButton: ObxValue<RxBool>(
        (data) => AnimatedScale(
          scale: data.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              gradient: CustomColors.primaryGradient,
              borderRadius: BorderRadius.circular(30),
              boxShadow: CustomColors.glowShadow,
            ),
            child: FloatingActionButton(
              onPressed: () => scrollController.animateTo(
                scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: CustomColors.darkBackground,
                size: 28,
              ),
            ),
          ),
        ),
        showFloatingButton,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: CustomColors.backgroundGradient,
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Stack(
            children: [
              Column(
                children: [
                  // Hero Section
                  HeroSection(width: width),

                  // About Section
                  _buildAboutSection(width),

                  // Skills Section
                  Container(
                    key: skillsKey,
                    child: _buildSkillsSection(width),
                  ),

                  // Interests Section
                  Container(
                    key: intrestsKey,
                    child: _buildInterestsSection(width),
                  ),

                  // Divider
                  Container(
                    width: width,
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.transparent,
                          CustomColors.primary.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  // Footer
                  Footer(width: width, scrollController: scrollController),
                ],
              ),

              // Modern Navigation Bar
              ModernNavBar(
                width: width,
                skillsKey: skillsKey,
                intrestsKey: intrestsKey,
                scrollController: scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection(double width) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
        child: Column(
          children: [
            Text(
              'O mnie',
              style: GoogleFonts.inter(
                fontSize: width > 768 ? 48 : 36,
                fontWeight: FontWeight.bold,
                color: CustomColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                'Jestem pasjonatem technologii mobilnych z wieloletnim doświadczeniem '
                'w tworzeniu aplikacji Flutter. Specjalizuję się w przekształcaniu '
                'pomysłów w funkcjonalne, piękne aplikacje mobilne.',
                style: GoogleFonts.inter(
                  fontSize: width > 768 ? 18 : 16,
                  color: CustomColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: Column(
        children: [
          Text(
            'Umiejętności',
            style: GoogleFonts.inter(
              fontSize: width > 768 ? 48 : 36,
              fontWeight: FontWeight.bold,
              color: CustomColors.textPrimary,
            ),
          ),
          const SizedBox(height: 48),

          // Skills Grid
          if (width > 768)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: skills.map((skill) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ModernSkillCard(
                      title: skill.title,
                      description: skill.description,
                      iconPath: skill.iconPath,
                      progress: skill.progress,
                      primaryColor: skill.primaryColor,
                      secondaryColor: skill.secondaryColor,
                    ),
                  ),
                );
              }).toList(),
            )
          else
            Column(
              children: skills.map((skill) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: ModernSkillCard(
                    title: skill.title,
                    description: skill.description,
                    iconPath: skill.iconPath,
                    progress: skill.progress,
                    primaryColor: skill.primaryColor,
                    secondaryColor: skill.secondaryColor,
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildInterestsSection(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: Column(
        children: [
          Text(
            'Zainteresowania',
            style: GoogleFonts.inter(
              fontSize: width > 768 ? 48 : 36,
              fontWeight: FontWeight.bold,
              color: CustomColors.textPrimary,
            ),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: interests.map((interest) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      interest['color'] as Color,
                      (interest['color'] as Color).withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: (interest['color'] as Color).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  interest['intrest'] as String,
                  style: GoogleFonts.inter(
                    color: interest['textColor'] as Color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}

class SkillData {
  final String title;
  final String description;
  final String iconPath;
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;

  SkillData({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
  });
}
