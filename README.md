# TfDataStreamer

This provides you with a streamer of data, which you can listen to.
Useful when you want to listen to the changes in certain data,
coming from a source e.g., API, Files, or from somewhere within the code and has probability of changes with time,
or requires reloading after certain events.
Provides useful data to alter data, filter data, add errors to the stream.

e.g., This data-streamer can be used to implement a filterable list, listen to the auth changes etc.>

## Supported Dart Versions

**Dart SDK version ">=2.12.0 <3.0.0"**

## Installation

Add the Package

```yaml
dependencies:
  tf_data_streamer: ^1.0.0
```

## How to use

Import the package in your dart file

```dart
import 'package:tf_photo_avatar/tf_photo_avatar.dart';
```

To create a photo avatar with image caching support.

```dart
     TfPhotoAvatar.cached(
        imageUrl: 'www.images.com/img1.png',
        onErrorImageAssetPath: 'assets/images/error.png',
        onLoadingImageAssetPath: 'assets/images/loading.png',
        radius: 90,
        memoryCacheHeight: 100,
        memoryCacheWidth: 100,
        imageFit: BoxFit.fill,
    ),
```

To create a photo avatar without image caching support.

```dart
    TfPhotoAvatar.noncached(
        imageUrl: 'www.images.com/img1.png',
        onLoadingImageAssetPath: 'assets/images/loading.png',
        onErrorImageAssetPath: 'assets/images/error.png',
        radius: 90,
        imageCacheHeight: 100,
        imageCacheWidth: 100,
        imageFit: BoxFit.fill,
    ),
```
