import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/auth_provider.dart';

class UserFormScreen extends StatefulWidget {
  UserFormScreen({Key? key}) : super(key: key);

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController companyController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data and populate text fields
  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.fetchProfile().then((_) {
      if (authProvider.user != null) {
        fullNameController.text = authProvider.user?.fullName ?? "";
        companyController.text = authProvider.user?.cmpName ?? "";
        emailController.text = authProvider.user?.userName ?? "";
        mobileController.text = authProvider.user?.contactNo ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade600,
      body: SafeArea(
          child: Consumer<AuthProvider>(builder: (coontext, authProvider, _) {
        return Column(
          children: [
            // Top Profile Section
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Form Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Full Name',
                    controller: fullNameController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'Company name',
                    controller: companyController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'Email Id',
                    controller: emailController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'Mobile No.',
                    controller: mobileController,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                final fullName = fullNameController.text;
                                final companyName = companyController.text;
                                final email = emailController.text;
                                final mobile = mobileController.text;

                                await authProvider.updateProfile(
                                  fullName: fullName,
                                  companyName: companyName,
                                  email: email,
                                  mobile: mobile,
                                );

                                if (!authProvider.isLoading) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Profile updated successfully!'),
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      })),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade300, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
