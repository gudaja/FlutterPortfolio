import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/widgets/social_media_links.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class ContactSection extends StatefulWidget {
  final double width;

  const ContactSection({
    super.key,
    required this.width,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _emailController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _emailScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _emailController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _emailScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _emailController,
      curve: Curves.elasticOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _copyEmail() async {
    final l10n = AppLocalizations.of(context)!;
    await Clipboard.setData(const ClipboardData(text: 'lukasz.g150@gmail.com'));

    _emailController.forward().then((_) {
      _emailController.reverse();
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.emailCopied,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          backgroundColor: CustomColors.primary,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: widget.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomColors.brightBackground,
            CustomColors.darkBackground,
          ],
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 80,
                ),
                child: Column(
                  children: [
                    // Section Title
                    Text(
                      l10n.contactTitle,
                      style: GoogleFonts.inter(
                        fontSize: widget.width > 768 ? 48 : 36,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      l10n.contactSubtitle,
                      style: GoogleFonts.inter(
                        fontSize: widget.width > 768 ? 20 : 16,
                        color: CustomColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 60),

                    // Contact Methods
                    if (widget.width > 768)
                      _buildDesktopContactLayout(l10n)
                    else
                      _buildMobileContactLayout(l10n),

                    const SizedBox(height: 60),

                    // Social Media
                    Column(
                      children: [
                        Text(
                          l10n.findMeOn,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: CustomColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const SocialMediaLinks(iconSize: 40),
                      ],
                    ),

                    const SizedBox(height: 60),

                    // Divider
                    Container(
                      width: widget.width * 0.6,
                      height: 1,
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

                    const SizedBox(height: 40),

                    // Footer info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${l10n.madeWithText} ',
                          style: GoogleFonts.inter(
                            color: CustomColors.textMuted,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(
                          Icons.favorite,
                          color: CustomColors.secondary,
                          size: 16,
                        ),
                        Text(
                          ' ${l10n.usingFlutterText}',
                          style: GoogleFonts.inter(
                            color: CustomColors.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      l10n.copyrightFullText,
                      style: GoogleFonts.inter(
                        color: CustomColors.textMuted,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // App Version
                    Text(
                      'v1.0.0',
                      style: GoogleFonts.inter(
                        color: CustomColors.textMuted.withOpacity(0.7),
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopContactLayout(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildEmailCard(l10n),
        _buildPhoneCard(l10n),
      ],
    );
  }

  Widget _buildMobileContactLayout(AppLocalizations l10n) {
    return Column(
      children: [
        _buildEmailCard(l10n),
        const SizedBox(height: 24),
        _buildPhoneCard(l10n),
      ],
    );
  }

  Widget _buildEmailCard(AppLocalizations l10n) {
    return AnimatedBuilder(
      animation: _emailScaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _emailScaleAnimation.value,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: widget.width > 768 ? 300 : double.infinity,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CustomColors.primary.withOpacity(0.1),
                  CustomColors.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: CustomColors.primary.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.primary.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _copyEmail,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: CustomColors.primaryGradient,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.primary.withOpacity(0.4),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.email_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Email',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'lukasz.g150@gmail.com',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: CustomColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.content_copy,
                            size: 14,
                            color: CustomColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.clickToCopy,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: CustomColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneCard(AppLocalizations l10n) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: widget.width > 768 ? 300 : double.infinity,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CustomColors.secondary.withOpacity(0.1),
            CustomColors.secondary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: CustomColors.secondary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.secondary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    CustomColors.secondary,
                    CustomColors.secondaryDark,
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.secondary.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.location,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CustomColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.polandKrakow,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: CustomColors.secondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.openToRemote,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: CustomColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
