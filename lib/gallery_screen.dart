import 'package:flutter/material.dart';

import 'constants.dart';

class GalleryScreen extends StatelessWidget {
  final String? heroTag;

  const GalleryScreen({Key? key, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Huge coin'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: widthScreen,
          child: Hero(
            tag: heroTag!,
            child: FadeInImage(
              placeholder: NetworkImage(urls[0]),
              image: NetworkImage(urls[2]),
            ),
          ),
        ),
      ),
    );
  }
}
