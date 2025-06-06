import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/widgets/social_media_links.dart';
import 'package:google_fonts/google_fonts.dart';

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
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        'Cześć! 👋',
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
                        'Jestem [U#-dev]',
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
                            'Flutter Developer',
                            textStyle: GoogleFonts.inter(
                              fontSize: widget.width > 768 ? 32 : 24,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.secondary,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                          TypewriterAnimatedText(
                            'Mobile App Creator',
                            textStyle: GoogleFonts.inter(
                              fontSize: widget.width > 768 ? 32 : 24,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.accent,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                          TypewriterAnimatedText(
                            'UI/UX Enthusiast',
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
                        'Passion meets code. Tworzę nowoczesne aplikacje mobilne '
                        'które łączą doskonały design z funkcjonalnością.',
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
                          'Zobacz Projekty',
                          CustomColors.primaryGradient,
                          widget.onProjectsPressed ?? () {},
                        ),
                        _buildCTAButton(
                          'Skontaktuj się',
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
                          'Znajdź mnie w sieci',
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
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 3000 + (index * 200)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Positioned(
          left: (index * 37.5) % widget.width,
          top: (MediaQuery.of(context).size.height * value) %
              MediaQuery.of(context).size.height,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: CustomColors.primary.withOpacity(0.3),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: CustomColors.primary.withOpacity(0.5),
                  blurRadius: 8,
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
