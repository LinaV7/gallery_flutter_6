import 'package:flutter/material.dart';
import './main.dart';

class GalleryDetailsScreen extends StatelessWidget {
  final Gallery gallery;

  const GalleryDetailsScreen({
    Key? key,
    required this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ignore: unnecessary_null_comparison
          if (gallery != null) ...[
            Hero(
              tag: gallery.title,
              child: Image.asset(
                gallery.image,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(gallery.title,
                      style: Theme.of(context).textTheme.headline6),
                  Text(gallery.description,
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
