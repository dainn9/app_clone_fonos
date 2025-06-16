import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/design_systems/theme/app_colors.dart';
import '../../../services/onboarding_service.dart';
import '../component/selectable_topic.dart';

class OnboardingScreenStep extends StatefulWidget {
  const OnboardingScreenStep({super.key});

  @override
  State<OnboardingScreenStep> createState() => _OnboardingScreenStepState();
}

class _OnboardingScreenStepState extends State<OnboardingScreenStep> {
  // Biến để theo dõi bước hiện tại
  int _currentStep = 1;
  final int _totalSteps = 3;

  // Danh sách chủ đề cho bước 1
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Phát triển bản thân',
      'icon': Icons.local_florist,
      'selected': false,
    },
    {
      'name': 'Kinh doanh & Đầu tư',
      'icon': Icons.monetization_on,
      'selected': false,
    },
    {'name': 'Tiểu thuyết & Truyện', 'icon': Icons.book, 'selected': false},
    {
      'name': 'Sức khỏe & Phong cách sống',
      'icon': Icons.favorite,
      'selected': false,
    },
    {'name': 'Khoa học & Xã hội', 'icon': Icons.science, 'selected': false},
    {'name': 'Tôn giáo & Tâm linh', 'icon': Icons.spa, 'selected': false},
    {
      'name': 'Gia đình & Trẻ em',
      'icon': Icons.family_restroom,
      'selected': false,
    },
  ];

  // Biến để kiểm tra xem có ít nhất một chủ đề được chọn hay không
  bool get hasSelectedTopics =>
      categories.any((item) => item['selected'] == true);

  @override
  void initState() {
    super.initState();
    _loadSelections();
  }

  Future<void> _loadSelections() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSelections = prefs.getStringList('selectedTopics') ?? [];
    setState(() {
      for (var item in categories) {
        item['selected'] = savedSelections.contains(item['name']);
      }
    });
  }

  Future<void> _saveSelections() async {
    final prefs = await SharedPreferences.getInstance();
    final selected =
        categories
            .where((e) => e['selected'] == true)
            .map((e) => e['name'] as String)
            .toList();
    await prefs.setStringList('selectedTopics', selected);
  }

  void _toggleCategory(int index) {
    setState(() {
      categories[index]['selected'] = !categories[index]['selected'];
    });
    _saveSelections();
  }

  // Phương thức để chuyển đến bước tiếp theo
  void _goToNextStep() async {
    // Đánh dấu đã xem onboarding
    await OnboardingService.setOnboardingSeen(true);

    // Tăng bước hiện tại
    setState(() {
      _currentStep++;
    });
  }

  // Phương thức để quay lại bước trước
  void _goToPreviousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // Phương thức để hoàn thành onboarding
  void _finishOnboarding() async {
    await OnboardingService.setOnboardingSeen(true);
    // Chuyển đến màn hình chính
    Navigator.pushNamedAndRemoveUntil(context, '/sign_in', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildOnboardingHeader(
                step: _currentStep,
                totalSteps: _totalSteps,
                onBack: _goToPreviousStep,
              ),

              // Nội dung chính - thay đổi theo bước hiện tại
              Expanded(child: _buildStepContent()),

              // Phần footer - thay đổi theo bước hiện tại
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget để hiển thị nội dung tương ứng với bước hiện tại
  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildStepOne();
      case 2:
        return _buildStepTwo();
      case 3:
        return _buildStepThree();
      default:
        return const SizedBox.shrink();
    }
  }

  // Widget để hiển thị footer tương ứng với bước hiện tại
  Widget _buildFooter() {
    switch (_currentStep) {
      case 1:
        return Column(
          children: [
            _buildContinueButton(
              enabled: hasSelectedTopics,
              buttonText: 'Tiếp tục',
              onPressed: _goToNextStep,
            ),
            if (!hasSelectedTopics)
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Vui lòng chọn ít nhất một chủ đề để tiếp tục',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
          ],
        );
      case 2:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              _buildGradientButton(
                text: 'Bật thông báo',
                // onPressed: _goToNextStep,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _goToNextStep,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                ),
                child: const Text(
                  'Để sau',
                  style: TextStyle(color: Color(0xFF718096), fontSize: 16),
                ),
              ),
            ],
          ),
        );
      case 3:
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: _buildGradientButton(
            text: 'Hoàn thành',
            onPressed: _finishOnboarding,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // Widget cho bước 1
  Widget _buildStepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Fonos chào bạn!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Chọn vài chủ đề bạn thích để bắt đầu:',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final item = categories[index];
              return SelectableTopic(
                icon: item['icon'],
                content: item['name'],
                isSelected: item['selected'],
                onTap: () => _toggleCategory(index),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget cho bước 2
  Widget _buildStepTwo() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Xin phép thông báo!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ở đây có nhiều sách miễn phí, mã giảm giá. Cấp quyền để nhận tin nha!',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF718096),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            _buildNotificationPreview(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget cho bước 3
  Widget _buildStepThree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Bước cuối cùng!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Bạn đã sẵn sàng để khám phá thế giới sách nói với Fonos.',
          style: TextStyle(fontSize: 16, color: Color(0xFF718096), height: 1.5),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 100,
                  color: AppColors.peachCoral,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Thiết lập hoàn tất!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Hãy bắt đầu hành trình khám phá tri thức cùng Fonos ngay bây giờ.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color(0xFF718096)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Các widget dùng chung

// Widget header cho các màn hình onboarding
Widget _buildOnboardingHeader({
  required int step,
  required int totalSteps,
  required VoidCallback onBack,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
            onPressed: onBack,
          ),
          Text(
            'BƯỚC $step/$totalSteps',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      LinearProgressIndicator(
        value: step / totalSteps,
        backgroundColor: Colors.grey[300],
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
      ),
    ],
  );
}

// Widget nút tiếp tục cho màn hình 1
Widget _buildContinueButton({
  required bool enabled,
  required String buttonText,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.peachCoral,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        disabledBackgroundColor: Colors.grey,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// Widget nút gradient cho màn hình 2 và 3
Widget _buildGradientButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFFFAB76)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

// Widget preview thông báo cho màn hình 2
Widget _buildNotificationPreview() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFAB76), Color(0xFFFF6B6B)],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        _buildNotificationItem(
          icon: Icons.headphones,
          title: 'Sách nói miễn phí ',
          emoji: '👑',
          subtitle: 'Tam Quốc Diễn Nghĩa vừa cập bến',
          time: 'bây giờ',
        ),
        const SizedBox(height: 10),
        _buildNotificationItem(
          icon: Icons.local_offer,
          title: 'Ưu đãi mới ra lò ',
          emoji: '🎁',
          subtitle: 'Giảm giá 30% - chỉ trong hôm nay',
          time: 'bây giờ',
        ),
      ],
    ),
  );
}

// Widget item thông báo cho màn hình 2
Widget _buildNotificationItem({
  required IconData icon,
  required String title,
  required String emoji,
  required String subtitle,
  required String time,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(12),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFF8C66),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(emoji, style: const TextStyle(fontSize: 15)),
                ],
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Color(0xFF718096), fontSize: 13),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Text(
          time,
          style: const TextStyle(color: Color(0xFF718096), fontSize: 12),
        ),
      ],
    ),
  );
}
