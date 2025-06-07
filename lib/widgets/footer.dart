import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/breakpoints.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/widgets/logo.dart';
import 'package:portfolio/widgets/social_media_links.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class Footer extends StatelessWidget {
  final double width;
  final ScrollController scrollController;
  const Footer({required this.width, required this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomColors.brightBackground,
            CustomColors.darkBackground,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Logo(
            width: width,
            scrollController: scrollController,
          ),

          const SizedBox(height: 24),

          // Social Media Links
          const SocialMediaLinks(iconSize: 32),

          const SizedBox(height: 32),

          // Divider
          Container(
            width: width * 0.8,
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

          const SizedBox(height: 24),

          // Footer Info
          width > Breakpoints.sm
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFooterText(l10n.copyrightText),
                    _buildFooterText(l10n.allRightsReserved),
                    _buildFooterText('lukasz.g150@gmail.com'),
                  ],
                )
              : Column(
                  children: [
                    _buildFooterText(l10n.copyrightText),
                    const SizedBox(height: 8),
                    _buildFooterText(l10n.allRightsReserved),
                    const SizedBox(height: 8),
                    _buildFooterText('lukasz.g150@gmail.com'),
                  ],
                ),

          const SizedBox(height: 16),

          // Made with Flutter
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${l10n.madeWithText} ',
                style: GoogleFonts.inter(
                  color: CustomColors.textMuted,
                  fontSize: 12,
                ),
              ),
              Icon(
                Icons.favorite,
                color: CustomColors.secondary,
                size: 14,
              ),
              Text(
                ' ${l10n.usingFlutterText}',
                style: GoogleFonts.inter(
                  color: CustomColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
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
    );
  }

  Widget _buildFooterText(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: CustomColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}
