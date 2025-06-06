import 'package:flutter/material.dart';
import 'package:portfolio/providers/language_provider.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n/app_localizations.dart';

class LanguageSwitcher extends StatefulWidget {
  final LanguageProvider languageProvider;

  const LanguageSwitcher({
    super.key,
    required this.languageProvider,
  });

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isExpanded = false;
  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isExpanded) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _isExpanded = true;
    _controller.forward();

    final buttonBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (buttonBox == null) return;

    final overlay = Overlay.of(context);
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);
    final buttonSize = buttonBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Invisible overlay to detect taps outside
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.transparent),
            ),
          ),
          // Dropdown menu
          Positioned(
            top: buttonPosition.dy + buttonSize.height + 8,
            right: MediaQuery.of(context).size.width -
                buttonPosition.dx -
                buttonSize.width,
            child: Material(
              color: Colors.transparent,
              child: ScaleTransition(
                scale: _scaleAnimation,
                alignment: Alignment.topRight,
                child: _buildDropdownMenu(),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _isExpanded = false;
    _controller.reverse();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _buttonKey,
      decoration: BoxDecoration(
        gradient: CustomColors.primaryGradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: CustomColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            print('🎯 Kliknięto główny przycisk językowy'); // Debug
            _toggleDropdown();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.languageProvider
                      .getLanguageFlag(widget.languageProvider.locale),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.languageProvider
                      .getLanguageName(widget.languageProvider.locale),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.darkBackground,
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: CustomColors.darkBackground,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownMenu() {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: CustomColors.cardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: CustomColors.primary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: LanguageProvider.supportedLocales
              .map((locale) => _buildLanguageOption(locale, l10n))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(Locale locale, AppLocalizations l10n) {
    final isSelected = widget.languageProvider.locale == locale;

    return Material(
      color: isSelected
          ? CustomColors.primary.withOpacity(0.1)
          : Colors.transparent,
      child: InkWell(
        onTap: () {
          print('🎯 Kliknięto opcję języka: ${locale.languageCode}'); // Debug
          widget.languageProvider.changeLanguage(locale);
          _removeOverlay();
        },
        child: Container(
          width: 160,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Text(
                widget.languageProvider.getLanguageFlag(locale),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.languageProvider.getLanguageName(locale),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? CustomColors.primary
                        : CustomColors.textPrimary,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check,
                  color: CustomColors.primary,
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
