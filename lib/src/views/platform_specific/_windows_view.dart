import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/views/platform_specific/info_tile.dart';

class WindowsView extends StatelessWidget {
  final WindowsDeviceInfo? windowsInfo;
  const WindowsView({Key? key, required this.windowsInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (windowsInfo == null) return SliverToBoxAdapter(child: SizedBox());
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          InfoTile(
            title: 'computerName',
            subTitle: windowsInfo!.computerName,
          ),
          InfoTile(
            title: 'numberOfCores',
            subTitle: windowsInfo!.numberOfCores.toString(),
          ),
          InfoTile(
            title: 'systemMemoryInMegabytes',
            subTitle: windowsInfo!.systemMemoryInMegabytes.toString(),
          ),
        ],
      ),
    );
  }
}
