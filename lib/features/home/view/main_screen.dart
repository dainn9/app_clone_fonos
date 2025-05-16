import 'package:app_clone_fonos/features/home/component/custom_app_bar.dart';
import 'package:app_clone_fonos/features/home/view/home_author.dart';
import 'package:app_clone_fonos/features/home/view/home_detail.dart';
import 'package:app_clone_fonos/features/home/view/home_search.dart';
import 'package:app_clone_fonos/features/signin_signup/views/sign_in_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../../signin_signup/providers/auth_provider.dart';
import 'home_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Danh sách các tiêu đề tương ứng với các tab
  final List<String> _titles = [
    'Khám phá',
    'PodCourse',
    'Tìm kiếm',
    'Thư viện',
    'Thử thách',
  ];

  // Danh sách các màn hình tương ứng với các tab
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),
      HomeDetail(),
      HomeSearch(),
      HomeAuthor(),
      Placeholder(),
    ];
  }

  // Xử lý khi người dùng nhấn vào tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Kiểm tra nếu người dùng chưa đăng nhập thì chuyển về màn hình đăng nhập
    if (!authProvider.isLoggedIn) {
      return SignInScreen();
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: _titles[_selectedIndex],
        showSearchBar: _selectedIndex == 2,
        showIcon: _selectedIndex == 0,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFFF8A65),
          // Màu cam như trong hình
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Khám phá',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library),
              label: 'PodCourse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Tìm kiếm',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Thư viện'),
            BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Thử thách'),
          ],
        ),
      ),
    );
  }
}
