import '../../../core/design_systems/design_system_export.dart';

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hasCircle;
  final VoidCallback? onTap;

  const FeatureButton({
    Key? key,
    required this.icon,
    required this.label,
    this.hasCircle = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          hasCircle
              ? Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          )
              : Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
