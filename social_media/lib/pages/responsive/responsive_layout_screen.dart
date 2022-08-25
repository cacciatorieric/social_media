import 'package:flutter/material.dart';
import 'package:social_media/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          //Redimensionamento da aplicação Web
          return webScreenLayout;
        }
        //Redimensionamento da aplicação Mobile
        return mobileScreenLayout;
      },
    );
  }
}
