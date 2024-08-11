import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? userId,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor, required Icon child,
  }) : super(key: userId);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;    
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      //style: Theme.of(context).textTheme.bodyLarge?.apply(color: kWhite),
      // trailing: endIcon
      //     ? Container(
      //         width: 30,
      //         height: 30,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(100),
      //           color: Colors.grey.withOpacity(0.1),
      //         ),
      //         child:
      //             Icon(Icons.arrow_forward_ios_rounded, size: 18.0, color: Colors.grey))
      //     : null,
    );
  }
}

