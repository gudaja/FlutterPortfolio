import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/widgets/social_media_links.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';

class HeroSection extends StatefulWidget {
  final double width;
  final VoidCallback? onProjectsPressed;
  final VoidCallback? onContactPressed;

  const HeroSection({
    super.key,
    required this.width,
    this.onProjectsPressed,
    this.onContactPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _particleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));

    _fadeController.forward();
    _slideController.forward();
    _particleController.repeat(); // Nieskończona animacja!
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: widget.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: CustomColors.backgroundGradient,
      ),
      child: Stack(
        children: [
          // Animated background particles
          ...List.generate(20, (index) => _buildParticle(index)),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated greeting
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          CustomColors.primaryGradient.createShader(bounds),
                      child: Text(
                        l10n.hello,
                        style: GoogleFonts.inter(
                          fontSize: widget.width > 768 ? 24 : 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Animated name
                  SlideTransition(
                    position: _slideAnimation,
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          CustomColors.primaryGradient.createShader(bounds),
                      child: Text(
                        l10n.iAm,
                        style: GoogleFonts.inter(
                          fontSize: widget.width > 768 ? 64 : 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Animated typewriter text
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            l10n.flutterDeveloper,
                            textStyle: GoogleFonts.inter(
                              fontSize: widget.width > 768 ? 32 : 24,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.secondary,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                          TypewriterAnimatedText(
                            l10n.mobileAppCreator,
                            textStyle: GoogleFonts.inter(
                              fontSize: widget.width > 768 ? 32 : 24,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.accent,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                          TypewriterAnimatedText(
                            l10n.uiUxEnthusiast,
                            textStyle: GoogleFonts.inter(
                              fontSize: widget.width > 768 ? 32 : 24,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.purple,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        repeatForever: true,
                        pause: const Duration(milliseconds: 1000),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Description
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        l10n.heroDescription,
                        style: GoogleFonts.inter(
                          fontSize: widget.width > 768 ? 18 : 16,
                          color: CustomColors.textSecondary,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // CTA Buttons
                  SlideTransition(
                    position: _slideAnimation,
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildCTAButton(
                          l10n.viewProjects,
                          CustomColors.primaryGradient,
                          widget.onProjectsPressed ?? () {},
                        ),
                        _buildCTAButton(
                          l10n.contactMe,
                          CustomColors.secondaryGradient,
                          widget.onContactPressed ?? () {},
                          outlined: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Social Media Links
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Text(
                          l10n.findMeOnline,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: CustomColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const SocialMediaLinks(
                          iconSize: 28,
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
    );
  }

  Widget _buildParticle(int index) {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        final screenHeight = MediaQuery.of(context).size.height;
        final progress = (_particleController.value + index * 0.1) % 1.0;
        final yPosition = -50 + (screenHeight + 100) * progress;

        return Positioned(
          left: (index * 45.0) % widget.width,
          top: yPosition,
          child: Container(
            width: 3 + (index % 3).toDouble(),
            height: 3 + (index % 3).toDouble(),
            decoration: BoxDecoration(
              color: CustomColors.primary.withOpacity(0.4 - (index % 4) * 0.05),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: CustomColors.primary.withOpacity(0.3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCTAButton(
    String text,
    LinearGradient gradient,
    VoidCallback onPressed, {
    bool outlined = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: outlined ? null : gradient,
        border:
            outlined ? Border.all(color: CustomColors.primary, width: 2) : null,
        borderRadius: BorderRadius.circular(30),
        boxShadow: outlined
            ? null
            : [
                BoxShadow(
                  color: CustomColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: outlined
                    ? CustomColors.primary
                    : CustomColors.darkBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
