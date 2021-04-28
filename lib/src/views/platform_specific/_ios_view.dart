import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/views/platform_specific/info_tile.dart';

class IOSView extends StatelessWidget {
  final IosDeviceInfo? iosInfo;
  const IOSView({Key? key, required this.iosInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iosInfo == null) return SliverToBoxAdapter(child: SizedBox());
    return SliverList(
        delegate: SliverChildListDelegate([
      InfoTile(
        title: 'identifierForVendor',
        subTitle: iosInfo!.identifierForVendor ?? '',
      ),
      InfoTile(
        title: 'localizedModel',
        subTitle: iosInfo!.localizedModel ?? '',
      ),
      InfoTile(
        title: 'model',
        subTitle: iosInfo!.model ?? '',
      ),
      InfoTile(
        title: 'name',
        subTitle: iosInfo!.name ?? '',
      ),
      InfoTile(
        title: 'systemName',
        subTitle: iosInfo!.systemName ?? '',
      ),
      InfoTile(
        title: 'systemVersion',
        subTitle: iosInfo!.systemVersion ?? '',
      ),
      InfoTile(
          title: 'isPhysicalDevice',
          subTitle: iosInfo!.isPhysicalDevice.toString()),
      InfoTile(
        title: 'machine',
        subTitle: iosInfo!.utsname.machine ?? '',
      ),
      InfoTile(
        title: 'nodename',
        subTitle: iosInfo!.utsname.nodename ?? '',
      ),
      InfoTile(
        title: 'release',
        subTitle: iosInfo!.utsname.release ?? '',
      ),
      InfoTile(
        title: 'sysname',
        subTitle: iosInfo!.utsname.sysname ?? '',
      ),
      InfoTile(
        title: 'version',
        subTitle: iosInfo!.utsname.version ?? '',
      ),
    ]));
  }
}
