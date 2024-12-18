import 'dart:convert';

import 'package:clump_project/utils/routes/routes_name.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/registration_model.dart';
import '../model/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<dynamic> _statusList = [];
  List<dynamic> get statusList => _statusList;
  User? _user;
  User? get user => _user;

  String? _fullName;
  String? _contactNo;
  String? _email;
  String? _password;

  String? _token;
  String? get token => _token;
  void saveSignupData({
    required String fullName,
    required String contactNo,
    required String email,
    required String password,
  }) {
    _fullName = fullName;
    _contactNo = contactNo;
    _email = email;
    _password = password;
    notifyListeners();
  }

  Future<void> registerUser(
    BuildContext context, {
    required String cmpName,
    required String cmpAddress,
  }) async {
    final url = Uri.parse('https://practical.ouranostech.com/api/registration');

    _isLoading = true;
    notifyListeners();

    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['full_name'] = _fullName ?? "";
      request.fields['contactNo'] = _contactNo ?? "";
      request.fields['confirm_password'] = _password ?? "";
      request.fields['user_name'] = _email ?? "";
      request.fields['password'] = _password ?? "";
      request.fields['cmpName'] = cmpName;
      request.fields['cmp_address'] = cmpAddress;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 200) {
        print("Registration Successful!");
        Navigator.pushNamed(context, RoutesName.home);
      } else {
        throw Exception('Failed to register. Error: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    const String url = "https://practical.ouranostech.com/api/login";

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email_or_mobile': email,
          'password': password,
          "device_id": "",
          "device_type": "",
          "fcm_token": "string"
        }),
      );

      print("Login Response Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Login successful: ${data['data']['user_token']}');
        print('Login full name: ${data['data']['user']['full_name']}');

        // Parse User Data
        _user = User.fromJson(data['data']['user']);

        notifyListeners();

        Navigator.pushNamed(context, RoutesName.home);
      } else {
        print('Failed to login: ${response.body}');
      }
    } catch (e) {
      print("Login Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _storeUserData(
      String token, Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user', json.encode(userData));

    _token = token;
    _user = User.fromJson(userData); // Update local user state
    notifyListeners();
  }

  // Load Token and User from SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    final userData = prefs.getString('user');

    if (_token != null && userData != null) {
      _user = User.fromJson(json.decode(userData));
      notifyListeners();
    }
  }

  // Fetch User Profile Using Token
  Future<void> fetchProfile() async {
    if (_token == null) {
      print("Token not found. Unable to fetch profile.");
      return;
    }

    final url = Uri.parse('https://practical.ouranostech.com/api/profile');

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _user = User.fromJson(data['data']); // Update user data
        notifyListeners();
      } else {
        print("Failed to fetch profile: ${response.body}");
      }
    } catch (e) {
      print("Error fetching profile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout User
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _user = null;
    _token = null;

    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.login, (route) => false);
    notifyListeners();
  }

  Future<void> updateProfile({
    required String fullName,
    required String companyName,
    required String email,
    required String mobile,
  }) async {
    const url = 'https://practical.ouranostech.com/api/profile/update';

    _isLoading = true;
    notifyListeners();

    try {
      final token = _token;
      if (token == null) {
        throw Exception("Token not found. Please log in again.");
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'full_name': fullName,
          'company_name': companyName,
          'email': email,
          'mobile': mobile,
        }),
      );

      if (response.statusCode == 200) {
        print("Profile updated successfully.");

        // Update local user data
        final data = json.decode(response.body);
        _user = User.fromJson(data['data']);
        notifyListeners();
      } else {
        print("Failed to update profile: ${response.body}");
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print("Error updating profile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getStatus() async {
    const url = 'https://practical.ouranostech.com/api/status/get';

    _isLoading = true;
    notifyListeners();

    try {
      final token = _token;
      if (token == null) {
        throw Exception("Token not found. Please log in again.");
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("Status fetched successfully.");
        final data = json.decode(response.body);
        _statusList = data['data'] ?? [];
        notifyListeners();
      } else {
        print("Failed to fetch status: ${response.body}");
        throw Exception('Failed to fetch status');
      }
    } catch (e) {
      print("Error fetching status: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
