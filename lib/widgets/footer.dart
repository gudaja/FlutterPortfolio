import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/breakpoints.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/widgets/logo.dart';
import 'package:portfolio/widgets/social_media_links.dart';

class Footer extends StatelessWidget {
  final double width;
  final ScrollController scrollController;
  const Footer({required this.width, required this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    _buildFooterText('Copyright © 2024 Portfolio'),
                    _buildFooterText('All rights reserved'),
                    _buildFooterText('lukasz.g150@gmail.com'),
                  ],
                )
              : Column(
                  children: [
                    _buildFooterText('Copyright © 2024 Portfolio'),
                    const SizedBox(height: 8),
                    _buildFooterText('All rights reserved'),
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
                'Made with ',
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
                ' using Flutter',
                style: GoogleFonts.inter(
                  color: CustomColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
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
