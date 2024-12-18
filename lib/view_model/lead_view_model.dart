import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeadProvider extends ChangeNotifier {
   List<dynamic> _allLeads = [];
  List<dynamic> _leads = [];
  bool _isLoading = false;

  List<dynamic> get leads => _leads;
  bool get isLoading => _isLoading;

  // Fetch leads from API
  Future<void> fetchLeads(String token) async {
  final url = Uri.parse('https://practical.ouranostech.com/api/lead/get');
  try {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
    
      _leads = data['data']?['lead'] ?? []; 
    } else {
      throw Exception('Failed to fetch leads');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
void sortLeadsByFollowDate() {
    _leads.sort((a, b) {
      DateTime dateA = DateTime.tryParse(a['followDate'] ?? '') ?? DateTime(0);
      DateTime dateB = DateTime.tryParse(b['followDate'] ?? '') ?? DateTime(0);
      return dateA.compareTo(dateB);
    });
    notifyListeners();
  }

  // Filter leads by Status or Promotion
  void filterLeads({List<int>? statuses, List<String>? promotions}) {
    _leads = _allLeads.where((lead) {
      bool matchesStatus = statuses == null || statuses.contains(lead['status']);
      bool matchesPromotion =
          promotions == null || promotions.contains(lead['cmp_name']);
      return matchesStatus && matchesPromotion;
    }).toList();
    notifyListeners();
  }

  // Reset leads to original state
  void resetFilters() {
    _leads = List.from(_allLeads);
    notifyListeners();
  }

}
