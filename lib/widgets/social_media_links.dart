import 'package:flutter/material.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/utils/image_asset_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialMediaLinks extends StatefulWidget {
  final bool isVertical;
  final double iconSize;

  const SocialMediaLinks({
    super.key,
    this.isVertical = false,
    this.iconSize = 24,
  });

  @override
  State<SocialMediaLinks> createState() => _SocialMediaLinksState();
}

class _SocialMediaLinksState extends State<SocialMediaLinks>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<SocialLink> socialLinks = [
    SocialLink(
      name: 'GitHub',
      iconPath: ImageAssetConstants.github,
      url: 'https://github.com/gudaja', // Zmień na swój profil
      color: CustomColors.textPrimary,
    ),
    SocialLink(
      name: 'LinkedIn',
      iconPath: ImageAssetConstants.linkedIn,
      url:
          'https://www.linkedin.com/in/lukasz-gorkiewicz-82336991/', // Zmień na swój profil
      color: const Color(0xff0077B5),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.isVertical
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildSocialIcons(),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: _buildSocialIcons(),
            ),
    );
  }

  List<Widget> _buildSocialIcons() {
    return socialLinks.asMap().entries.map((entry) {
      final index = entry.key;
      final social = entry.value;

      return TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 800 + (index * 200)),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              margin: widget.isVertical
                  ? const EdgeInsets.symmetric(vertical: 8)
                  : const EdgeInsets.symmetric(horizontal: 8),
              child: _SocialIconButton(
                social: social,
                iconSize: widget.iconSize,
              ),
            ),
          );
        },
      );
    }).toList();
  }
}

class _SocialIconButton extends StatefulWidget {
  final SocialLink social;
  final double iconSize;

  const _SocialIconButton({
    required this.social,
    required this.iconSize,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _glowAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.iconSize + 16,
              height: widget.iconSize + 16,
              decoration: BoxDecoration(
                color: _isHovered
                    ? widget.social.color.withOpacity(0.1)
                    : CustomColors.darkBackground.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isHovered
                      ? widget.social.color
                      : CustomColors.primary.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  if (_isHovered)
                    BoxShadow(
                      color: widget.social.color.withOpacity(0.4),
                      blurRadius: 20 * _glowAnimation.value,
                      spreadRadius: 2 * _glowAnimation.value,
                    ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _launchURL(widget.social.url),
                  child: Center(
                    child: Image.asset(
                      widget.social.iconPath,
                      width: widget.iconSize,
                      height: widget.iconSize,
                      color: _isHovered
                          ? widget.social.color
                          : CustomColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback - pokazanie komunikatu
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Nie można otworzyć linku: $url',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: CustomColors.secondary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }
}

class SocialLink {
  final String name;
  final String iconPath;
  final String url;
  final Color color;

  SocialLink({
    required this.name,
    required this.iconPath,
    required this.url,
    required this.color,
  });
}
