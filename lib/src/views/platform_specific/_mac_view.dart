import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/views/platform_specific/info_tile.dart';

class MacView extends StatelessWidget {
  final MacOsDeviceInfo? macInfo;
  const MacView({Key? key, required this.macInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (macInfo == null) return SliverToBoxAdapter(child: SizedBox());
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          InfoTile(
            title: 'activeCPUs',
            subTitle: macInfo!.activeCPUs.toString(),
          ),
          InfoTile(
            title: 'arch',
            subTitle: macInfo!.arch,
          ),
          InfoTile(
            title: 'model',
            subTitle: macInfo!.model,
          ),
          InfoTile(
            title: 'computerName',
            subTitle: macInfo!.computerName,
          ),
          InfoTile(
            title: 'cpuFrequency',
            subTitle: macInfo!.cpuFrequency.toString(),
          ),
          InfoTile(
            title: 'hostName',
            subTitle: macInfo!.hostName,
          ),
          InfoTile(title: 'kernelVersion', subTitle: macInfo!.kernelVersion),
          InfoTile(
            title: 'memorySize',
            subTitle: macInfo!.memorySize.toString(),
          ),
          InfoTile(
            title: 'osRelease',
            subTitle: macInfo!.osRelease,
          ),
        ],
      ),
    );
  }
}
