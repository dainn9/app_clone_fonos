import '../../../core/design_systems/design_system_export.dart';

class AttachmentListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AttachmentListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}
