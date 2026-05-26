import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Future<void> _handleSignOut() async {
    try {
      await const FirebaseAuthService().signOut();
    } on AuthFailure catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    }
  }

  String _displayName(User? user) {
    final name = user?.displayName?.trim();
    if (name != null && name.isNotEmpty) {
      return name;
    }

    final email = user?.email?.trim();
    if (email == null || email.isEmpty) {
      return 'Orlando Diggs';
    }

    final localPart = email.split('@').first;
    if (localPart.isEmpty) {
      return 'Orlando Diggs';
    }

    return localPart
        .split(RegExp(r'[._-]'))
        .where((part) => part.isNotEmpty)
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .join(' ');
  }

  String _initials(String name) {
    final parts = name.split(' ').where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty) {
      return 'U';
    }

    if (parts.length == 1) {
      return parts.first.characters.first.toUpperCase();
    }

    return '${parts.first.characters.first}${parts.last.characters.first}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = _displayName(user);
    final initials = _initials(userName);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontSize: 34,
                                    height: 1.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$userName.',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontSize: 34,
                                    height: 1.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: _handleSignOut,
                        child: Tooltip(
                          message: 'Tap to sign out',
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2F1B83), Color(0xFF5C45D3)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x24000000),
                                  blurRadius: 16,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _PromotionBanner(
                    onJoinNow: () {},
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Find Your Job',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 14),
                  _JobsSummarySection(
                    onRemoteTap: () {},
                    onFullTimeTap: () {},
                    onPartTimeTap: () {},
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Recent Job List',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 14),
                  const _RecentJobCard(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: _BottomNavigationBar(
          selectedIndex: _selectedIndex,
          onChanged: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}

class _PromotionBanner extends StatelessWidget {
  final VoidCallback onJoinNow;

  const _PromotionBanner({required this.onJoinNow});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF2B127C), Color(0xFF170B53)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x28000000),
            blurRadius: 22,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned(
              top: -32,
              right: -24,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              right: 8,
              child: Container(
                width: 144,
                height: 144,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 6),
                        const Text(
                          '50% off\ntake any courses',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: onJoinNow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF2A65A),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            'Join Now',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 142,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 10,
                          child: Container(
                            width: 108,
                            height: 108,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.18),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 6,
                          bottom: 0,
                          child: Container(
                            width: 102,
                            height: 138,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9F1EA),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              size: 70,
                              color: Color(0xFF5C45D3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobsSummarySection extends StatelessWidget {
  final VoidCallback onRemoteTap;
  final VoidCallback onFullTimeTap;
  final VoidCallback onPartTimeTap;

  const _JobsSummarySection({
    required this.onRemoteTap,
    required this.onFullTimeTap,
    required this.onPartTimeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _StatsCard(
            color: const Color(0xFFACE5FB),
            count: '44.5k',
            label: 'Remote Job',
            icon: Icons.description_outlined,
                  iconBackground: Colors.white.withValues(alpha: 0.8),
            height: 164,
            onTap: onRemoteTap,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatsCard(
                color: const Color(0xFFD4C6FF),
                count: '66.8k',
                label: 'Full Time',
                icon: Icons.business_center_outlined,
                iconBackground: Colors.white.withValues(alpha: 0.75),
                height: 76,
                showIcon: false,
                onTap: onFullTimeTap,
              ),
              const SizedBox(height: 12),
              _StatsCard(
                color: const Color(0xFFFFD6AA),
                count: '38.9k',
                label: 'Part Time',
                icon: Icons.timer_outlined,
                iconBackground: Colors.white.withValues(alpha: 0.75),
                height: 76,
                showIcon: false,
                onTap: onPartTimeTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  final Color color;
  final String count;
  final String label;
  final IconData icon;
  final Color iconBackground;
  final double? height;
  final bool showIcon;
  final VoidCallback onTap;

  const _StatsCard({
    required this.color,
    required this.count,
    required this.label,
    required this.icon,
    required this.iconBackground,
    required this.onTap,
    this.height,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: showIcon
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 20, color: const Color(0xFF3A3070)),
                ),
                const SizedBox(height: 12),
                Text(
                  count,
                  style: const TextStyle(
                    color: Color(0xFF1F1840),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1F1840),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count,
                  style: const TextStyle(
                    color: Color(0xFF1F1840),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1F1840),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: card,
      ),
    );
  }
}

class _RecentJobCard extends StatelessWidget {
  const _RecentJobCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF4F0FF),
                ),
                child: const Icon(Icons.apple, color: Color(0xFF1B1B1D), size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Designer',
                      style: TextStyle(
                        color: Color(0xFF201A4F),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Google inc . California, USA',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border_rounded, color: Color(0xFF655A86)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '\$15K/Mo',
            style: TextStyle(
              color: Color(0xFF201A4F),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _TagChip(label: 'Senior designer'),
              _TagChip(label: 'Full time'),
            ],
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD9C9),
                foregroundColor: const Color(0xFF8B4E2F),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3F8),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF80759F),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _BottomNavigationBar({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: const [
            BoxShadow(
              color: Color(0x16000000),
              blurRadius: 24,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavIcon(
              icon: Icons.home_outlined,
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),
            _NavIcon(
              icon: Icons.person_outline,
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),
            GestureDetector(
              onTap: () => onChanged(2),
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 26),
              ),
            ),
            _NavIcon(
              icon: Icons.chat_bubble_outline_rounded,
              selected: selectedIndex == 3,
              onTap: () => onChanged(3),
            ),
            _NavIcon(
              icon: Icons.bookmark_outline_rounded,
              selected: selectedIndex == 4,
              onTap: () => onChanged(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _NavIcon({required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 28,
        color: selected ? AppColors.primary : const Color(0xFFA89FC1),
      ),
    );
  }
}