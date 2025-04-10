import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingBuilderWidget extends StatelessWidget {
  const LoadingBuilderWidget({super.key});
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Center(
        child:  CupertinoActivityIndicator(),
      ),
    );
  }
}
