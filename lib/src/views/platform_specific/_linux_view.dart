import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/views/platform_specific/info_tile.dart';

class LinuxView extends StatelessWidget {
  final LinuxDeviceInfo? linuxInfo;
  const LinuxView({Key? key, required this.linuxInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (linuxInfo == null) return SliverToBoxAdapter(child: SizedBox());
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          InfoTile(
            title: 'buildId',
            subTitle: linuxInfo!.buildId.toString(),
          ),
          InfoTile(
            title: 'id',
            subTitle: linuxInfo!.id,
          ),
          InfoTile(
            title: 'idLike',
            subTitle: linuxInfo!.idLike?.join(',') ?? '',
          ),
          InfoTile(
            title: 'machineId',
            subTitle: linuxInfo!.machineId ?? '',
          ),
          InfoTile(
            title: 'name',
            subTitle: linuxInfo!.name,
          ),
          InfoTile(
            title: 'prettyName',
            subTitle: linuxInfo!.prettyName,
          ),
          InfoTile(
            title: 'variant',
            subTitle: linuxInfo!.variant ?? '',
          ),
          InfoTile(
            title: 'variantId',
            subTitle: linuxInfo!.variantId ?? '',
          ),
          InfoTile(
            title: 'version',
            subTitle: linuxInfo!.version ?? '',
          ),
          InfoTile(
            title: 'versionCodename',
            subTitle: linuxInfo!.versionCodename ?? '',
          ),
          InfoTile(
            title: 'versionId',
            subTitle: linuxInfo!.versionId ?? '',
          ),
        ],
      ),
    );
  }
}
