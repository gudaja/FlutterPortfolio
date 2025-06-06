import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/utils/breakpoints.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/widgets/contact_section.dart';
import 'package:portfolio/widgets/hero_section.dart';
import 'package:portfolio/widgets/modern_navbar.dart';
import 'package:portfolio/widgets/modern_skill_card.dart';
import 'package:portfolio/l10n/app_localizations.dart';
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
  late final GlobalKey aboutKey;
  late final GlobalKey homeKey;
  late final GlobalKey contactKey;
  late final ScrollController scrollController;
  late final RxBool showFloatingButton;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  List<SkillData> _getSkills(AppLocalizations l10n) => [
        SkillData(
          title: 'Flutter',
          description: l10n.flutterSkillDescription,
          iconPath: 'assets/images/flutter.png',
          progress: 0.9,
          primaryColor: CustomColors.primary,
          secondaryColor: CustomColors.primaryDark,
        ),
        SkillData(
          title: 'C++',
          description: l10n.cppSkillDescription,
          iconPath: 'assets/images/cpp.png',
          progress: 0.85,
          primaryColor: CustomColors.secondary,
          secondaryColor: CustomColors.secondaryDark,
        ),
        SkillData(
          title: 'Golang',
          description: l10n.golangSkillDescription,
          iconPath: 'assets/images/go.png',
          progress: 0.88,
          primaryColor: CustomColors.accent,
          secondaryColor: CustomColors.accentDark,
        ),
        SkillData(
          title: 'Linux Developer',
          description: l10n.linuxSkillDescription,
          iconPath: 'assets/images/python.png', // Tymczasowo używamy python.png
          progress: 0.92,
          primaryColor: CustomColors.purple,
          secondaryColor: const Color(0xff4A148C),
        ),
        SkillData(
          title: 'Embedded Developer',
          description: l10n.embeddedSkillDescription,
          iconPath:
              'assets/images/backend_icon.png', // Tymczasowo używamy backend_icon.png
          progress: 0.83,
          primaryColor: const Color(0xffFF7043),
          secondaryColor: const Color(0xffD84315),
        ),
      ];

  @override
  void initState() {
    intrestsKey = GlobalKey();
    skillsKey = GlobalKey();
    aboutKey = GlobalKey();
    homeKey = GlobalKey();
    contactKey = GlobalKey();
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

    interests = [];

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

  List<Map> _getInterests(AppLocalizations l10n) => [
        {
          'intrest': l10n.flutterDevelopmentInterest,
          'color': CustomColors.primary,
          'textColor': CustomColors.darkBackground,
        },
        {
          'intrest': l10n.uiUxDesignInterest,
          'color': CustomColors.secondary,
          'textColor': CustomColors.textPrimary,
        },
        {
          'intrest': l10n.mobileAppsInterest,
          'color': CustomColors.accent,
          'textColor': CustomColors.darkBackground,
        },
        {
          'intrest': l10n.problemSolvingInterest,
          'color': CustomColors.purple,
          'textColor': CustomColors.textPrimary,
        },
        {
          'intrest': l10n.techInnovationInterest,
          'color': CustomColors.primary,
          'textColor': CustomColors.darkBackground,
        },
        {
          'intrest': l10n.codeQualityInterest,
          'color': CustomColors.secondary,
          'textColor': CustomColors.textPrimary,
        },
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double width = MediaQuery.of(context).size.width;
    final skills = _getSkills(l10n);
    final localInterests = _getInterests(l10n);

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
        child: Column(
          children: [
            // Sticky Navigation Bar
            ModernNavBar(
              width: width,
              skillsKey: skillsKey,
              intrestsKey: intrestsKey,
              aboutKey: aboutKey,
              contactKey: contactKey,
              scrollController: scrollController,
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    // Hero Section
                    HeroSection(
                      width: width,
                      onProjectsPressed: () {
                        // Scroll to interests/projects section
                        if (intrestsKey.currentContext != null) {
                          Scrollable.ensureVisible(
                            intrestsKey.currentContext!,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      onContactPressed: () {
                        // Scroll to contact section
                        if (contactKey.currentContext != null) {
                          Scrollable.ensureVisible(
                            contactKey.currentContext!,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),

                    // About Section
                    Container(
                      key: aboutKey,
                      child: _buildAboutSection(width, l10n),
                    ),

                    // Skills Section
                    Container(
                      key: skillsKey,
                      child: _buildSkillsSection(width, l10n, skills),
                    ),

                    // Interests Section
                    Container(
                      key: intrestsKey,
                      child:
                          _buildInterestsSection(width, l10n, localInterests),
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

                    // Contact Section
                    Container(
                      key: contactKey,
                      child: ContactSection(width: width),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(double width, AppLocalizations l10n) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
        child: Column(
          children: [
            Text(
              l10n.aboutMeTitle,
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
                l10n.aboutMeDescription,
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

  Widget _buildSkillsSection(
      double width, AppLocalizations l10n, List<SkillData> skills) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: Column(
        children: [
          Text(
            l10n.mySkillsTitle,
            style: GoogleFonts.inter(
              fontSize: width > 768 ? 48 : 36,
              fontWeight: FontWeight.bold,
              color: CustomColors.textPrimary,
            ),
          ),
          const SizedBox(height: 48),

          // Skills Grid
          if (width > 1200)
            // Desktop - 3 karty w pierwszym rzędzie, 2 w drugim
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: skills.take(3).map((skill) {
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
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 1, child: SizedBox()),
                    ...skills.skip(3).map((skill) {
                      return Expanded(
                        flex: 2,
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
                    const Expanded(flex: 1, child: SizedBox()),
                  ],
                ),
              ],
            )
          else if (width > 768)
            // Tablet - 2 karty na rząd
            Wrap(
              alignment: WrapAlignment.center,
              children: skills.map((skill) {
                return Container(
                  width: (width - 96) / 2, // 32*2 padding + 32 spacing
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
            )
          else
            // Mobile - pojedyncze kolumny
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

  Widget _buildInterestsSection(
      double width, AppLocalizations l10n, List<Map> interests) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
      child: Column(
        children: [
          Text(
            l10n.interestsTitle,
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
