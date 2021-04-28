import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/views/platform_specific/info_tile.dart';

class AndroidView extends StatelessWidget {
  final AndroidDeviceInfo? androidInfo;
  AndroidView({Key? key, required this.androidInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      InfoTile(title: 'androidId', subTitle: androidInfo!.androidId ?? ''),
      InfoTile(title: 'board', subTitle: androidInfo!.board ?? ''),
      InfoTile(title: 'bootloader', subTitle: androidInfo!.bootloader ?? ''),
      InfoTile(title: 'brand', subTitle: androidInfo!.brand ?? ''),
      InfoTile(title: 'device', subTitle: androidInfo!.device ?? ''),
      InfoTile(title: 'display', subTitle: androidInfo!.display ?? ''),
      InfoTile(title: 'fingerprint', subTitle: androidInfo!.fingerprint ?? ''),
      InfoTile(title: 'hardware', subTitle: androidInfo!.hardware ?? ''),
      InfoTile(title: 'host', subTitle: androidInfo!.host ?? ''),
      InfoTile(title: 'id', subTitle: androidInfo!.id ?? ''),
      InfoTile(
          title: 'manufacturer', subTitle: androidInfo!.manufacturer ?? ''),
      InfoTile(title: 'model', subTitle: androidInfo!.model ?? ''),
      InfoTile(title: 'product', subTitle: androidInfo!.product ?? ''),
      InfoTile(title: 'tags', subTitle: androidInfo!.tags ?? ''),
      InfoTile(title: 'type', subTitle: androidInfo!.type ?? ''),
      InfoTile(
          title: 'isPhysicalDevice',
          subTitle: androidInfo!.isPhysicalDevice.toString()),
      InfoTile(
          title: 'supported32BitAbis',
          subTitle: androidInfo!.supported32BitAbis.join(',')),
      InfoTile(
          title: 'supported64BitAbis',
          subTitle: androidInfo!.supported64BitAbis.join(',')),
      InfoTile(
          title: 'supportedAbis',
          subTitle: androidInfo!.supportedAbis.join(',')),
      InfoTile(title: 'baseOS', subTitle: androidInfo!.version.baseOS ?? ''),
      InfoTile(
          title: 'codename', subTitle: androidInfo!.version.codename ?? ''),
      InfoTile(
          title: 'incremental',
          subTitle: androidInfo!.version.incremental ?? ''),
      InfoTile(title: 'release', subTitle: androidInfo!.version.release ?? ''),
      InfoTile(
          title: 'securityPatch',
          subTitle: androidInfo!.version.securityPatch ?? ''),
      InfoTile(
          title: 'previewSdkInt',
          subTitle: androidInfo!.version.previewSdkInt.toString()),
      InfoTile(
          title: 'sdkInt', subTitle: androidInfo!.version.sdkInt.toString()),
      InfoTile(
          title: 'systemFeatures',
          subTitle: androidInfo!.systemFeatures.join('\n')),
    ]));
  }
}
