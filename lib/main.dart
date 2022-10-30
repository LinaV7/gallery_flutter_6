// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'gallery_detail.dart';

void main() {
  runApp(const GalleryApp());
}

class Gallery {
  final dynamic image;
  final String title;
  final String description;

  Gallery(this.image, this.title, this.description);
}

class GalleryApp extends StatefulWidget {
  const GalleryApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  Gallery? _selectedGallery;

  List<Gallery> galleries = [
    Gallery('assets/images/one_altai.jpg', 'Altai 1', 'Altai nature 1'),
    Gallery('assets/images/two_altai.jpg', 'Altai 2', 'Altai nature 2'),
    Gallery('assets/images/three_altai.jpg', 'Altai 3', 'Altai nature 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'galleries App',
      home: Navigator(
        pages: [
          MaterialPage(
            key: const ValueKey('GalleryListPage'),
            child: galleriesListScreen(
              galleries: galleries,
              onTapped: _handleGalleryTapped,
            ),
          ),
          if (_selectedGallery != null)
            GalleryDetailsPage(gallery: _selectedGallery!)
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          // Update the list of pages by setting _selectedGallery to null
          setState(() {
            _selectedGallery = null;
          });

          return true;
        },
      ),
    );
  }

  void _handleGalleryTapped(Gallery gallery) {
    setState(() {
      _selectedGallery = gallery;
    });
  }
}

class GalleryDetailsPage extends Page {
  final Gallery gallery;

  GalleryDetailsPage({
    required this.gallery,
  }) : super(key: ValueKey(gallery));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return GalleryDetailsScreen(gallery: gallery);
      },
    );
  }
}

class galleriesListScreen extends StatelessWidget {
  final List<Gallery> galleries;
  final ValueChanged<Gallery> onTapped;

  galleriesListScreen({
    Key? key,
    required this.galleries,
    required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var gallery in galleries)
            ListTile(
              leading: ClipOval(
                child: Image.asset(
                  gallery.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(gallery.title),
              subtitle: Text(gallery.description),
              onTap: () => onTapped(gallery),
            )
        ],
      ),
    );
  }
}
