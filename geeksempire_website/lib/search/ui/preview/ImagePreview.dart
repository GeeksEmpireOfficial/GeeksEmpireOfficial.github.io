import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sachiel_website/cache/io/CacheIO.dart';
import 'package:sachiel_website/network/endpoints/Endpoints.dart';
import 'package:sachiel_website/private/Privates.dart';
import 'package:shaped_image/shaped_image.dart';

class ImagePreview extends StatefulWidget {

  String postId;

  ImagePreview({Key? key, required this.postId}) : super(key: key);

  @override
  State<ImagePreview> createState() => ImagePreviewState();

}
class ImagePreviewState extends State<ImagePreview> {

  CacheIO cacheIO = CacheIO();

  Endpoints endpoints = Endpoints();

  String featuredImagePath = "https://geeks-empire-website.web.app/favicon.png";

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    SystemNavigator.pop();

    return true;
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    retrieveImage(widget.postId);

  }

  @override
  void dispose() {
    super.dispose();

    BackButtonInterceptor.remove(aInterceptor);

  }

  @override
  Widget build(BuildContext context) {

    return ShapedImage(
      imageTye: ImageType.NETWORK,
      path: featuredImagePath,
      shape: Shape.Rectarcle,
      height: 310,
      width: 235,
      boxFit: BoxFit.cover,
    );
  }

  Future retrieveImage(String postId) async {

    String? cachedFeaturedImagePath = await cacheIO.retrieveImagePath(postId);

    if (cachedFeaturedImagePath == null) {

      final postResponse = await http.post(Uri.parse(endpoints.postsById(postId)),
          headers: {
            "Authorization": Privates.authenticationAPI
          });
      final postJson = jsonDecode(postResponse.body);

      int featuredMedia = postJson['featured_media'];

      final mediaResponse = await http.post(Uri.parse(endpoints.mediaUrl(featuredMedia.toString())),
          headers: {
            "Authorization": Privates.authenticationAPI
          });
      final mediaJson = jsonDecode(mediaResponse.body);

      cacheIO.storeImagePath(postId, mediaJson['guid']['rendered']);

      setState(() {

        featuredImagePath = mediaJson['guid']['rendered'];
        debugPrint('Network Image Path: $featuredImagePath');

      });

    } else {

      setState(() {

        featuredImagePath = cachedFeaturedImagePath;
        debugPrint('Cached Image Path: $featuredImagePath');

      });

    }

  }

}