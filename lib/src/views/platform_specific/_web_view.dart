import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:power_logger/src/views/platform_specific/info_tile.dart';

class WebDeviceView extends StatelessWidget {
  final WebBrowserInfo? webInfo;
  const WebDeviceView({Key? key, required this.webInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (webInfo == null) return SliverToBoxAdapter(child: SizedBox());
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          InfoTile(
            title: 'appCodeName',
            subTitle: webInfo!.appCodeName,
          ),
          InfoTile(
            title: 'appName',
            subTitle: webInfo!.appName,
          ),
          InfoTile(
            title: 'appVersion',
            subTitle: webInfo!.appVersion,
          ),
          InfoTile(
            title: 'browserName',
            subTitle: webInfo!.browserName.index.toString(),
          ),
          InfoTile(
            title: 'deviceMemory',
            subTitle: webInfo!.deviceMemory.toString(),
          ),
          InfoTile(
            title: 'hardwareConcurrency',
            subTitle: webInfo!.hardwareConcurrency.toString(),
          ),
          InfoTile(
            title: 'language',
            subTitle: webInfo!.language,
          ),
          InfoTile(
            title: 'languages',
            subTitle: webInfo!.languages.join(','),
          ),
          InfoTile(
            title: 'maxTouchPoints',
            subTitle: webInfo!.maxTouchPoints.toString(),
          ),
          InfoTile(
            title: 'platform',
            subTitle: webInfo!.platform,
          ),
          InfoTile(
            title: 'product',
            subTitle: webInfo!.product,
          ),
          InfoTile(
            title: 'productSub',
            subTitle: webInfo!.productSub,
          ),
          InfoTile(
            title: 'userAgent',
            subTitle: webInfo!.userAgent,
          ),
          InfoTile(
            title: 'vendor',
            subTitle: webInfo!.vendor,
          ),
          InfoTile(
            title: 'vendorSub',
            subTitle: webInfo!.vendorSub,
          ),
        ],
      ),
    );
  }
}
