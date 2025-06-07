import 'package:flutter/material.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/providers/language_provider.dart';
import 'package:portfolio/widgets/language_switcher.dart';
import 'package:portfolio/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModernNavBar extends StatefulWidget {
  final double width;
  final ScrollController scrollController;
  final GlobalKey skillsKey;
  final GlobalKey intrestsKey;
  final GlobalKey? aboutKey;
  final GlobalKey? projectsKey;
  final GlobalKey? contactKey;

  const ModernNavBar({
    super.key,
    required this.width,
    required this.scrollController,
    required this.skillsKey,
    required this.intrestsKey,
    this.aboutKey,
    this.projectsKey,
    this.contactKey,
  });

  @override
  State<ModernNavBar> createState() => _ModernNavBarState();
}

class _ModernNavBarState extends State<ModernNavBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _navAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _navAnimation;
  bool _isScrolled = false;
  int _selectedIndex = 0;
  double _animatedSelectedIndex = 0.0; // Animowana pozycja
  bool _isManualScrolling = false; // Flaga dla manual scroll

  List<NavItem> _getNavItems(AppLocalizations l10n) => [
        NavItem(l10n.home, Icons.home_rounded),
        NavItem(l10n.about, Icons.person_rounded),
        NavItem(l10n.skills, Icons.code_rounded),
        NavItem('Projects', Icons.work_rounded), // TODO: Add to translations
        NavItem(l10n.contact, Icons.mail_rounded),
      ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _navAnimationController = AnimationController(
      duration:
          const Duration(milliseconds: 700), // Długość animacji scrollowania
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _navAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _navAnimationController,
      curve: Curves.easeInOut,
    ));

    _navAnimation.addListener(() {
      if (!mounted) return;
      setState(() {
        // Aktualizuj animowaną pozycję podczas animacji
        _animatedSelectedIndex = _navAnimation.value;
      });
    });

    widget.scrollController.addListener(_onScroll);
    _animationController.forward();
  }

  void _onScroll() {
    // TEMPORARY: Force navbar to always be in scrolled state for debugging
    if (!_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    }

    // Auto-update active navigation item based on scroll position
    _updateActiveNavigation();
  }

  void _updateActiveNavigation() {
    // Nie aktualizuj podczas manual scrollowania
    if (_isManualScrolling) return;

    final scrollOffset = widget.scrollController.offset;

    int newSelectedIndex = 0; // Default to Home

    // Get section positions dynamically
    final aboutOffset = _getSectionOffset(widget.aboutKey);
    final skillsOffset = _getSectionOffset(widget.skillsKey);
    final interestsOffset = _getSectionOffset(widget.intrestsKey);
    final contactOffset = _getSectionOffset(widget.contactKey);

    // Define sections with their positions
    final sections = <Map<String, dynamic>>[];

    // Home section
    sections.add({'index': 0, 'offset': 0.0});

    // About section
    if (aboutOffset > 0) {
      sections.add({'index': 1, 'offset': aboutOffset});
    }

    // Skills section
    if (skillsOffset > 0) {
      sections.add({'index': 2, 'offset': skillsOffset});
    }

    // Interests/Projects section
    if (interestsOffset > 0) {
      sections.add({'index': 3, 'offset': interestsOffset});
    }

    // Contact section (footer area)
    if (contactOffset > 0) {
      sections.add({'index': 4, 'offset': contactOffset});
    }

    // Find the current section based on scroll position
    for (int i = sections.length - 1; i >= 0; i--) {
      final sectionOffset = sections[i]['offset'] as double;
      if (scrollOffset >= sectionOffset - 200) {
        // 200px offset for better UX
        newSelectedIndex = sections[i]['index'] as int;
        break;
      }
    }

    // Update selected index if changed
    if (newSelectedIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newSelectedIndex;
        if (!_isManualScrolling) {
          _animatedSelectedIndex = newSelectedIndex.toDouble();
        }
      });
    }
  }

  double _getSectionOffset(GlobalKey? key) {
    if (key?.currentContext == null) return -1.0;

    try {
      final RenderBox? renderBox =
          key!.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox == null) return -1.0;

      final position = renderBox.localToGlobal(Offset.zero);
      // Since navbar is now outside the scroll view, we just need the scroll position
      // when this section would be at the top (accounting for navbar height)
      return position.dy + widget.scrollController.offset - 80;
    } catch (e) {
      return -1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _navAnimationController.dispose();
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _isScrolled
              ? CustomColors.darkBackground.withOpacity(0.95)
              : CustomColors.darkBackground.withOpacity(0.8),
          boxShadow: _isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: CustomColors.primary.withOpacity(0.2),
                    blurRadius: 25,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
          border: _isScrolled
              ? Border(
                  bottom: BorderSide(
                    color: CustomColors.primary.withOpacity(0.4),
                    width: 2,
                  ),
                )
              : Border(
                  bottom: BorderSide(
                    color: CustomColors.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                // Logo with scroll animation
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween(begin: 0.0, end: _isScrolled ? 1.0 : 0.0),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 1.0 - (value * 0.1),
                      child: _buildLogo(),
                    );
                  },
                ),

                const Spacer(),

                // Navigation items (desktop)
                if (widget.width > 768) ...[
                  _buildDesktopNav(l10n),
                  const SizedBox(width: 16),
                  // Language switcher
                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return LanguageSwitcher(
                        languageProvider: languageProvider,
                      );
                    },
                  ),
                ] else ...[
                  // Language switcher (mobile)
                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return LanguageSwitcher(
                        languageProvider: languageProvider,
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  // Mobile menu button
                  _buildMobileMenuButton(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: CustomColors.primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CustomColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        '</Dev>',
        style: GoogleFonts.firaCode(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: CustomColors.darkBackground,
        ),
      ),
    );
  }

  Widget _buildDesktopNav(AppLocalizations l10n) {
    final navItems = _getNavItems(l10n);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomColors.darkBackground.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: CustomColors.primary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: navItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = _selectedIndex == index;

          return _buildNavItem(
            item.title,
            item.icon,
            isSelected,
            () => _onNavItemTap(index),
            index,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNavItem(
    String title,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
    int itemIndex,
  ) {
    // Oblicz intensity animacji dla tego elementu
    final animationDistance = (_animatedSelectedIndex - itemIndex).abs();
    final isAnimating = _isManualScrolling && animationDistance < 1.0;
    final animationIntensity = isAnimating ? (1.0 - animationDistance) : 0.0;
    // Używaj animacji intensity dla smooth przejścia
    final effectiveSelected = isSelected || animationIntensity > 0.1;
    final gradientOpacity = isSelected ? 1.0 : animationIntensity;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: effectiveSelected
            ? LinearGradient(
                colors: CustomColors.primaryGradient.colors
                    .map((color) => color.withOpacity(gradientOpacity))
                    .toList(),
                begin: CustomColors.primaryGradient.begin,
                end: CustomColors.primaryGradient.end,
              )
            : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: effectiveSelected
            ? [
                BoxShadow(
                  color:
                      CustomColors.primary.withOpacity(0.4 * gradientOpacity),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: effectiveSelected
                      ? Color.lerp(
                          CustomColors.textSecondary,
                          CustomColors.darkBackground,
                          gradientOpacity,
                        )
                      : CustomColors.textSecondary,
                ),
                if (effectiveSelected && gradientOpacity > 0.5) ...[
                  const SizedBox(width: 8),
                  AnimatedOpacity(
                    opacity: gradientOpacity,
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.lerp(
                          CustomColors.textSecondary,
                          CustomColors.darkBackground,
                          gradientOpacity,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: CustomColors.darkBackground.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: CustomColors.primary.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: _showMobileMenu,
          child: const Icon(
            Icons.menu_rounded,
            color: CustomColors.primary,
            size: 24,
          ),
        ),
      ),
    );
  }

  void _onNavItemTap(int index) {
    // Sprawdź czy widget nie jest w trakcie niszczenia
    if (!mounted) return;

    // Włącz flagę manual scrolling
    _isManualScrolling = true;

    // Ustaw docelowy index
    final targetIndex = index;
    final startIndex = _selectedIndex;

    // Skonfiguruj animację nawigacji
    _navAnimation = Tween<double>(
      begin: startIndex.toDouble(),
      end: targetIndex.toDouble(),
    ).animate(CurvedAnimation(
      parent: _navAnimationController,
      curve: Curves.easeInOut,
    ));

    // Uruchom animację nawigacji - sprawdź czy controller jest zainicjalizowany
    try {
      _navAnimationController.forward(from: 0.0);
    } catch (e) {
      // Fallback jeśli animacja nie może być uruchomiona
      setState(() {
        _selectedIndex = targetIndex;
        _animatedSelectedIndex = targetIndex.toDouble();
        _isManualScrolling = false;
      });
      return;
    }

    // Funkcja callback po zakończeniu animacji
    void _onScrollComplete() {
      if (!mounted) return;

      setState(() {
        _selectedIndex = targetIndex;
        _animatedSelectedIndex = targetIndex.toDouble();
        _isManualScrolling = false;
      });

      try {
        _navAnimationController.reset();
      } catch (e) {
        // Ignoruj błąd jeśli controller jest już zdisposowany
      }
    }

    // Handle navigation based on index
    switch (index) {
      case 0: // Home
        widget.scrollController
            .animateTo(
              0,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
            )
            .then((_) => _onScrollComplete());
        break;
      case 1: // About
        widget.scrollController
            .animateTo(
              MediaQuery.of(context).size.height * 0.8,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
            )
            .then((_) => _onScrollComplete());
        break;
      case 2: // Skills
        if (widget.skillsKey.currentContext != null) {
          Scrollable.ensureVisible(
            widget.skillsKey.currentContext!,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          ).then((_) => _onScrollComplete());
        } else {
          _onScrollComplete();
        }
        break;
      case 3: // Projects (Interests section)
        if (widget.intrestsKey.currentContext != null) {
          Scrollable.ensureVisible(
            widget.intrestsKey.currentContext!,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          ).then((_) => _onScrollComplete());
        } else {
          // Fallback: scroll to a calculated position
          widget.scrollController
              .animateTo(
                MediaQuery.of(context).size.height * 2.0,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
              )
              .then((_) => _onScrollComplete());
        }
        break;
      case 4: // Contact
        if (widget.contactKey?.currentContext != null) {
          Scrollable.ensureVisible(
            widget.contactKey!.currentContext!,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          ).then((_) => _onScrollComplete());
        } else {
          // Fallback: scroll to bottom
          widget.scrollController
              .animateTo(
                widget.scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
              )
              .then((_) => _onScrollComplete());
        }
        break;
    }
  }

  void _showMobileMenu() {
    final l10n = AppLocalizations.of(context)!;
    final navItems = _getNavItems(l10n);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: CustomColors.darkBackground.withOpacity(0.9),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: CustomColors.gray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...navItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return ListTile(
                leading: Icon(
                  item.icon,
                  color: CustomColors.primary,
                ),
                title: Text(
                  item.title,
                  style: GoogleFonts.inter(
                    color: CustomColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onNavItemTap(index);
                },
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class NavItem {
  final String title;
  final IconData icon;

  NavItem(this.title, this.icon);
}
