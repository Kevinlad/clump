import 'package:clump_project/view_model/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyDetailsPage extends StatefulWidget {
  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends State<CompanyDetailsPage> {
  final TextEditingController cmpNameController = TextEditingController();
  final TextEditingController cmpAddressController = TextEditingController();

  final TextEditingController cmpLogoController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cmpNameController.dispose();
    cmpAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registrationProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.green, // Green background
      body: Stack(
        children: [
          // Top green section
          Container(
            height:
                MediaQuery.of(context).size.height * 0.5, // Half screen green
            color: Colors.green,
            child: Column(
              children: [
                const Text(
                  'Company Details',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter your company details to create your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 20),
                // Company Name Field
              ],
            ),
          ),
          // White card in center
          Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: cmpNameController,
                      decoration: InputDecoration(
                          labelText: 'Company Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    const SizedBox(height: 15),
                    // Company Address Field
                    TextField(
                      controller: cmpAddressController,
                      decoration: InputDecoration(
                          labelText: 'Company Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    const SizedBox(height: 15),
                    // File Upload
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Company Logo',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Choose File'),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'No File Chosen',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Submit Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                        onPressed: () async {
                          await registrationProvider.registerUser(
                            context,
                            cmpName: cmpNameController.text,
                            cmpAddress: cmpAddressController.text,
                            // cmpLogo: cmpLogoController.text,
                          );

                          if (registrationProvider.user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration Successful!'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration Failed!'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
