import 'package:flutter/cupertino.dart';
import 'package:landly/utils/app_sizes.dart';

enum AppIcons {
  location,
  edit,
}

class IconSelector extends StatelessWidget {
  final AppIcons icon;
  final double? size;

  IconSelector({
    required this.icon,
    Key? key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      getIcon(),
      height: size ?? AppSizes.getBaseScale(context) * 18,
      width: size ?? AppSizes.getBaseScale(context) * 18,
    );
  }

  String getIcon() {
    switch (icon) {
      case AppIcons.location:
        return 'assets/icons/location.png';
      case AppIcons.edit:
        return 'assets/icons/edit.png';
      default:
        return 'assets/icons/location.png';
    }
  }
}
