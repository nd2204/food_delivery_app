import 'package:flutter/material.dart';
import 'package:food_delivery_app/viewmodels/profile_view_model.dart';
import 'package:food_delivery_app/widgets/top_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileViewModel _profileViewModel;
  late ColorScheme colors;

  @override
  void initState() {
    super.initState();
    _profileViewModel = ProfileViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    _profileViewModel.dispose();
  }

  void _onLogout() {
    _profileViewModel.signOut();
  }

  @override
  Widget build(BuildContext context) {
    colors = Theme.of(context).colorScheme;

    final AppBarController appBarController = AppBarController(
      TopBarSpec(
        leading: TopBarIconButton(
          backgroundColor: colors.surfaceContainer,
          icon: Icon(Icons.chevron_left_rounded, color: colors.tertiary),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        trailing: TopBarIconButton(
          backgroundColor: colors.surfaceContainer,
          onPressed: () {},
          icon: Icon(Icons.more_horiz, color: colors.tertiary),
        ),
        title: const Text("Profile", style: TextStyle(fontSize: 17)),
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AppBarScope(
          controller: appBarController,
          child: Column(
            children: [
              TopBarContainer(),
              const SizedBox(height: 24),
              Row(
                children: [
                  ProfilePictureFallback(),
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            _profileViewModel.user?.displayName ?? "",
                            style: TextStyle(fontSize: 20, fontWeight: .bold),
                          ),
                          const SizedBox(height: 8),
                          const Text("I love fast food"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    _buildSection([
                      _buildTile(
                        icon: Icons.person,
                        iconColor: Colors.deepOrange,
                        title: "Personal Info",
                      ),
                      _buildTile(
                        icon: Icons.map_outlined,
                        iconColor: Colors.blue,
                        title: "Addresses",
                      ),
                    ]),

                    const SizedBox(height: 20),

                    _buildSection([
                      _buildTile(
                        icon: Icons.shopping_bag_outlined,
                        iconColor: Colors.blue,
                        title: "Cart",
                      ),
                      _buildTile(
                        icon: Icons.favorite_border,
                        iconColor: Colors.purple,
                        title: "Favourite",
                      ),
                      _buildTile(
                        icon: Icons.notifications_none,
                        iconColor: Colors.orange,
                        title: "Notifications",
                      ),
                      _buildTile(
                        icon: Icons.credit_card,
                        iconColor: Colors.lightBlue,
                        title: "Payment Method",
                      ),
                    ]),

                    const SizedBox(height: 20),

                    _buildSection([
                      _buildTile(
                        icon: Icons.help_outline,
                        iconColor: Colors.orange,
                        title: "FAQs",
                      ),
                      _buildTile(
                        icon: Icons.reviews,
                        iconColor: Colors.teal,
                        title: "User Reviews",
                      ),
                      _buildTile(
                        icon: Icons.settings_outlined,
                        iconColor: Colors.indigo,
                        title: "Settings",
                      ),
                    ]),

                    const SizedBox(height: 20),

                    _buildSection([
                      _buildTile(
                        icon: Icons.logout,
                        iconColor: Colors.red,
                        title: "Log Out",
                        onTap: _onLogout,
                      ),
                    ]),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------------------
  // Section Container
  // ----------------------------------------------------------------------
  Widget _buildSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: List.generate(
          children.length,
          (index) => Column(children: [children[index]]),
        ),
      ),
    );
  }

  // ----------------------------------------------------------------------
  // Tile Row
  // ----------------------------------------------------------------------
  Widget _buildTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}

class ProfilePictureFallback extends StatelessWidget {
  const ProfilePictureFallback({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.primaryContainer,
      ),
    );
  }
}
