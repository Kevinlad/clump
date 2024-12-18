import 'package:clump_project/model/registration_model.dart';
import 'package:clump_project/model/user_model.dart';
import 'package:clump_project/view_model/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50), 
        elevation: 0,

        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       
          Container(
            color: const Color(0xFF4CAF50), 
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                ),
                const SizedBox(width: 12),
                Consumer<AuthProvider>(builder: (context, authProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.user?.userName ?? "",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authProvider.user?.cmpName ?? "",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  );
                }),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white30,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.profile);
                    },
                  ),
                )
              ],
            ),
          ),

          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                buildCard(
                  icon: Icons.filter_alt_outlined,
                  title: "Leads",
                  count: "8",
                  context: context,
                ),
                buildCard(
                  icon: Icons.hexagon_outlined,
                  title: "Tasks",
                  count: "10",
                  context: context,
                ),
                buildSimpleCard(
                  title: "Follow Up Lead",
                  context: context,
                ),
                buildSimpleCard(
                  title: "Due Follow up Lead",
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Consumer<AuthProvider>(builder: (context, authProvider, child) {
              return UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF4CAF50)),
                accountName: Text(
                  authProvider.user?.fullName ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                accountEmail: Text(authProvider.user?.userName ?? ""),
                currentAccountPicture: const CircleAvatar(),
              );
            }),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.menu),
                    title: const Text("Leads"),
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.lead);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock_clock),
                    title: const Text("Change Password"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Call the logout function
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                authProvider.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Card Widget for Icon with Count
  Widget buildCard(
      {required IconData icon,
      required String title,
      required String count,
      required BuildContext context}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.green, size: 40),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
        Positioned(
          top: -10,
          right: 10,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.green,
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  // Simple Card Widget without Count
  Widget buildSimpleCard(
      {required String title, required BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }
}
