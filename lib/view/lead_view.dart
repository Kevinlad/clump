import 'package:clump_project/utils/routes/routes.dart';
import 'package:clump_project/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/lead_view_model.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({Key? key}) : super(key: key);

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token =
          "97d947148b5e43fa8c5210d3fd9b172052d0dfba943beca1db4ab76e638aad73fb9fa69df7dda10f60ec922596cbb0765613a6d4e6db3968ee249c4175de43edH6fbxOJ1RZITFq6yDS1Eh8BIQ/8fq4uaaOleKVNylaAV/kAv2QiKQX45QKka5z1e2Qxdz8sgDbp9+ujmWa37hWuu81KerHRYIBn7I1lDObDEJDMGV9IkBTOCMdKG4C+JeYZt3/MRiZSTWtBf2zLpOlinmFoXy3o39rpX4nJcDxkIkD/3+icyeC0jHSAwSi1QV6W+Sgaf/qUmwRR20nrfDXngF5x6HUdIpVEbfFD6UI+99XPvQUYMy9/xxlyYB5gU3iamv91UUAZUz+UynjynpJQdVezexm7b7YxBJVpp8Ev9LRTzS4F3Xet745lcTn/vChnVrODUGzeD2cPohwMAyP9dWF0/2rxcldhPwJErz9vW4wiGe5DbHtVpypQTntciNb17XR3dj2om2ooVRbND8Myezi/I9pDGlBvqWhAxn4veHL0+DcM/Urn2mweE5L/l3CzweWLwsxrmiRw3vN1KiftptWnNPIqIJP5Iq+gJ2r8qds6otxn39tfB1ZKFMfA0ZD7heZWjb0A3N+ADLJl6YuNYHgkumWF+ZNlyqnfsTV1B02AL/KSCNt2fHzMaxU9R7P0ybnttdkOSt69DDyjjkxyMKh3DyyUhd8BvdQV14NG9wQntyXSJpIYb1shfBTk+80iWALks8lahDrj6KpqG7YRKEiameFJp/7Jfp6PLer9EV86/VR/20fQ9Qx4VPAuuD5ukosJ/8Kh/NVraW/0DWf7gqU18ey/ztIQYacSV0q+OJC/I2TQCg0KR2ez0efim2Qj7JOHAV7DjZ8fIv7h90/Wk0I4oHSEF+MA7DuveTyBzPS43Rn1HGACXzltps/3kiyfV2hJigZPaynwgLY3oCjhzeIG12gN0MFOyTl0/aTJLoJizqZC37cdDbw7Dq9lYnwmzPz1r5l2aJ4zn95/uKSVNC49b5CCqY7ojg2Wnhjc/4HLp3Cmy5mDI6GBSYHjWA6mpFu2i4YcLssCOkg7dBd3+44+JQV8hmV0s+brc322swNt0Swy7yK+WUGdAHS1ljI92mF3un7Jfz2zzmj+jBxZIhvFR3y/+8x4i8S81z4vYl2xAoni6vetSjLD2DzNnCnvWgzSEoEDwDDZMezMxosVPLIRZqazQdtCUBmJ7BPGe6SmrzN7h5PCq0PIy5lKXPGPrU752eh0by8RDcQG2yasgF6OiFcxAXsWQWU5XCZKRWC5I9V+xKj4FYtn3n95KR+Rh3bPXqdTjng1jU6sM2ehBPczPpfOc+RpEufd/CLELliJehH6TLMmtFiXBtKxHcfamZMmGBSI4jKcSqqgvZMhDkk79XjC1oB8cllpp7BebuHmsBoFk7lTjftR+u273h3oYy+QLgBNQpxxWNYB4X9Qa8l/AZW3lnRdPchXIWmUBC3l+brWzoi5c8GOlsYvxrigVlNCVV4BvpbUuODqV9iFCXS8c0ZvlBB3JyVDWWB30O9jLVFia1WgVgzjO6k9S";
      Provider.of<LeadProvider>(context, listen: false).fetchLeads(token);
    });
  }

  bool isOpen = false;
  bool isCompleted = true;
  bool isClosed = false;

  bool isGPBO = false;
  bool isJustDial = false;
  bool isNewspaper = true;
  bool isGPBS = false;
  @override
  Widget build(BuildContext context) {
    final leadProvider = Provider.of<LeadProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50), 
        elevation: 0,
        title: const Text(
          "Leads",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Search Bar
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Filter Button with Badge
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        leadProvider.sortLeadsByFollowDate();
                      },
                      icon: const Icon(Icons.filter_list, size: 28),
                      color: Colors.green,
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          "2",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                // Sort Button
                IconButton(
                  onPressed: () {
                    _showFilterBottomSheet(context, leadProvider);
                  },
                  icon: const Icon(Icons.swap_vert, size: 28),
                  color: Colors.green,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          leadProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: leadProvider.leads.length,
                  itemBuilder: (context, index) {
                    final lead = leadProvider.leads[index];
                    return buildLeadCard(
                      name: lead['contact_name'] ?? 'N/A',
                      company: lead['cmp_name'] ?? 'N/A',
                      source: lead['address'] ?? 'N/A',
                      status: "Qualified",
                      statusColor: Colors.green,
                    );
                  },
                ),
        ],
      ),
    );
  }

  // Lead Card Widget
  Widget buildLeadCard({
    required String name,
    required String company,
    required String source,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lead Name and Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: statusColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          Text(
            source,
            style: const TextStyle(color: Colors.black45, fontSize: 13),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, LeadProvider provider) {
    List<int> selectedStatuses = [];
    List<String> selectedPromotions = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Ensures full height on large content
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filter",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          provider.resetFilters();
                        },
                        child: const Text("Reset"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          provider.filterLeads(
                            statuses: selectedStatuses,
                            promotions: selectedPromotions,
                          );
                        },
                        child: const Text("Apply"),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              const Text(
                "Filter By:",
                style: TextStyle(),
              ),
              Card(
                child: Column(
                  children: [
                    const Text(
                      "Status",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Divider(),
                    CheckboxListTile(
                      title: const Text("Open (10)"),
                      value: isOpen,
                      onChanged: (bool? value) {
                        setState(() {
                          isOpen = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Completed (5)"),
                      value: isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          isCompleted = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("(Closed)"),
                      value: isClosed,
                      onChanged: (bool? value) {
                        setState(() {
                          isClosed = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              // Status Section
              const Divider(),

              // Promotions Section
              const Text(
                "Promotions",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Card(
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text("GPBO"),
                      value: isGPBO,
                      onChanged: (bool? value) {
                        setState(() {
                          isGPBO = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("JustDial"),
                      value: isJustDial,
                      onChanged: (bool? value) {
                        setState(() {
                          value!
                              ? selectedPromotions.add("Google")
                              : selectedPromotions.remove("Google");
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Newspaper"),
                      value: isNewspaper,
                      onChanged: (bool? value) {
                        setState(() {
                          isNewspaper = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("GPBS"),
                      value: isGPBS,
                      onChanged: (bool? value) {
                        setState(() {
                          isGPBS = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _resetFilters() {
    setState(() {
      isOpen = false;
      isCompleted = false;
      isClosed = false;
      isGPBO = false;
      isJustDial = false;
      isNewspaper = false;
      isGPBS = false;
    });
  }
}
