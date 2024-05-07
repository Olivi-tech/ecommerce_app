import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImageDisplay extends StatelessWidget {
  final Uint8List? imageFile;
  final String? imageUrl; // New property for network image URL
  final VoidCallback? onImagePick;

  const CustomImageDisplay({
    super.key,
    this.imageFile,
    this.imageUrl,
    this.onImagePick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImagePick,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Display the network image if available
            if (imageUrl != null && imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: NetworkImage(
                    imageUrl!,
                  ),
                ),
              ),
            // Display the local image if available
            if (imageFile != null && imageFile!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.memory(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
            // Show the "Pick Image" overlay if no image is available
            if (imageFile == null || imageFile!.isEmpty)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.grey),
                    Text(
                      'Image',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  final String imageUrl;

  const ImageView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: CachedNetworkImage(
        key: ValueKey(imageUrl),
        useOldImageOnUrlChange: true,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
