import 'package:clump_project/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                if (index == 2) {
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pushReplacementNamed(context, RoutesName.login);
                  });
                }
              });
            },
            children: [
              _buildPage(
                imagePath: 'assets/images/clump.png',
              ),
              _buildPage(
                imagePath: 'assets/images/clump2.png',
              ),
              _buildPage(
                imagePath: 'assets/images/clump3.png',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String imagePath,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
