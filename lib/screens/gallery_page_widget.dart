import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/header.dart';
import 'package:flutter_application_1/server/api_service.dart';

class GalleryPageWidget extends StatefulWidget {
  const GalleryPageWidget({super.key});

  @override
  State<GalleryPageWidget> createState() => _GalleryPageWidgetState();
}

class _GalleryPageWidgetState extends State<GalleryPageWidget> {
  Future getImages() async {
    List images = [];
    var data = await ApiService().getPhotos();
    for (var item in data) {
      images.add(item['urls']['small']);
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(pageTitle: 'Gallery'),
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

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var imageUrl = snapshot.data[index];
                    return Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
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
