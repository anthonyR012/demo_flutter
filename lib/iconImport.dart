import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconImportWidget extends StatefulWidget {
  const IconImportWidget({super.key});

  @override
  State<IconImportWidget> createState() => _IconImportWidgetState();
}

class _IconImportWidgetState extends State<IconImportWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        "assets/icons/32.svg",
        semanticsLabel: 'Acme Logo',
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        height: 40,
        width: 40,
      ),
    );
  }
}
