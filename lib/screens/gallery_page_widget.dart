import 'package:flutter/material.dart';
import '../components/header.dart';
import '../server/api_service.dart';

class GalleryPageWidget extends StatefulWidget {
  const GalleryPageWidget({super.key});

  @override
  State<GalleryPageWidget> createState() => _GalleryPageWidgetState();
}

class _GalleryPageWidgetState extends State<GalleryPageWidget> {
  Future getImages() async {
    try {
      List images = [];
      var data = await ApiService().getPhotos();
      if (data == null) return [];
      for (var item in data) {
        images.add(item['urls']['small']);
      }
      return images;
    } catch (e) {
      throw Exception('Image loading failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(pageTitle: 'Gallery'),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
              future: getImages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }

                if (snapshot.data.isEmpty) {
                  return const Center(child: Text("No images loaded"));
                }

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var imageUrl = snapshot.data[index];
                    return Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: 200,
                        height: 300,
                        child: Image(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ));
                  },
                );
              })),
    );
  }
}
