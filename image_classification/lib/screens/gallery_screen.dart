import 'package:flutter/material.dart';
import 'package:image_classification/screens/analysis_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<AssetEntity> _assets = [];

  Future<void> _getAssets() async {
    final PermissionState permissionState =
        await PhotoManager.requestPermissionExtend();

    if (permissionState.isAuth) {
      List<AssetPathEntity> assetPathList = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );
      List<AssetEntity> assets = [];

      for (AssetPathEntity assetPath in assetPathList) {
        // int number = await assetPath.assetCountAsync;
        List<AssetEntity> assetsInPath =
            await assetPath.getAssetListPaged(page: 0, size: 50);
        assets.addAll(assetsInPath);
      }
      setState(() {
        _assets = assets;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: _assets.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  fullscreenDialog: true,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end);
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    );

                    return SlideTransition(
                      position: tween.animate(curvedAnimation),
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      AnalysisScreen(file: _assets[index]),
                ),
              );
            },
            child: Image(
              image: AssetEntityImageProvider(_assets[index]),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
