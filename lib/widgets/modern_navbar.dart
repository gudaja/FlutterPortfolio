import 'package:flutter/material.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernNavBar extends StatefulWidget {
  final double width;
  final ScrollController scrollController;
  final GlobalKey skillsKey;
  final GlobalKey intrestsKey;

  const ModernNavBar({
    super.key,
    required this.width,
    required this.scrollController,
    required this.skillsKey,
    required this.intrestsKey,
  });

  @override
  State<ModernNavBar> createState() => _ModernNavBarState();
}

class _ModernNavBarState extends State<ModernNavBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isScrolled = false;
  int _selectedIndex = 0;

  final List<NavItem> _navItems = [
    NavItem('Home', Icons.home_rounded),
    NavItem('About', Icons.person_rounded),
    NavItem('Skills', Icons.code_rounded),
    NavItem('Projects', Icons.work_rounded),
    NavItem('Contact', Icons.mail_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    widget.scrollController.addListener(_onScroll);
    _animationController.forward();
  }

  void _onScroll() {
    if (widget.scrollController.offset > 100 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (widget.scrollController.offset <= 100 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 80,
          decoration: BoxDecoration(
            color: _isScrolled
                ? CustomColors.darkBackground.withOpacity(0.8)
                : Colors.transparent,
            border: _isScrolled
                ? Border(
                    bottom: BorderSide(
                      color: CustomColors.primary.withOpacity(0.2),
                      width: 1,
                    ),
                  )
                : null,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  // Logo
                  _buildLogo(),

                  const Spacer(),

                  // Navigation items (desktop)
                  if (widget.width > 768) ...[
                    _buildDesktopNav(),
                  ] else ...[
                    // Mobile menu button
                    _buildMobileMenuButton(),
                  ],
                ],
              ),
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

  Widget _buildDesktopNav() {
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
        children: _navItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = _selectedIndex == index;

          return _buildNavItem(
            item.title,
            item.icon,
            isSelected,
            () => _onNavItemTap(index),
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
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: isSelected ? CustomColors.primaryGradient : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: CustomColors.primary.withOpacity(0.4),
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
                  color: isSelected
                      ? CustomColors.darkBackground
                      : CustomColors.textSecondary,
                ),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.darkBackground,
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
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on index
    switch (index) {
      case 0: // Home
        widget.scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
        break;
      case 1: // About
        widget.scrollController.animateTo(
          MediaQuery.of(context).size.height * 0.8,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
        break;
      case 2: // Skills
        if (widget.skillsKey.currentContext != null) {
          Scrollable.ensureVisible(
            widget.skillsKey.currentContext!,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        }
        break;
      case 3: // Projects
        // Add your projects section navigation
        break;
      case 4: // Contact
        // Add your contact section navigation
        break;
    }
  }

  void _showMobileMenu() {
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
            ..._navItems.asMap().entries.map((entry) {
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
