import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class NotFound extends StatelessWidget {
  final String message;
  final String? assetImage;
  final String? networkImageUrl;
  final Color? color;
  final double? imageHeight, imageWidth;
  final bool? showImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showImage ?? false)
            networkImageUrl != null
                ? Image.network(networkImageUrl!)
                : Image.asset(
                    assetImage ?? "assets/images/nothing.png",
                    //color: color ?? appPrimaryColor,
                    height:
                        imageHeight ?? MediaQuery.of(context).size.height * 0.1,
                    width:
                        imageWidth ?? MediaQuery.of(context).size.height * 0.1,
                  ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              message,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }

  NotFound({
    required this.message,
    this.assetImage,
    this.networkImageUrl,
    this.color,
    this.imageHeight,
    this.imageWidth,
    this.showImage,
  });
}
