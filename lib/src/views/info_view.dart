import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide AndroidView;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:power_logger/src/views/platform_specific/_android_view.dart';
import 'package:power_logger/src/views/platform_specific/_ios_view.dart';
import 'package:power_logger/src/views/platform_specific/_linux_view.dart';
import 'package:power_logger/src/views/platform_specific/_mac_view.dart';
import 'package:power_logger/src/views/platform_specific/_web_view.dart';
import 'package:power_logger/src/views/platform_specific/_windows_view.dart';
import 'package:power_logger/src/views/platform_specific/info_tile.dart';

class InfoView extends StatefulWidget {
  InfoView({Key? key}) : super(key: key);

  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView>
    with AutomaticKeepAliveClientMixin {
  PackageInfo? packageInfo;
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  MacOsDeviceInfo? macInfo;
  WebBrowserInfo? webInfo;
  WindowsDeviceInfo? windowsInfo;
  LinuxDeviceInfo? linuxInfo;

  Future getAllInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    packageInfo = await PackageInfo.fromPlatform();
    if (kIsWeb) webInfo = await deviceInfo.webBrowserInfo;
    if (Platform.isAndroid) androidInfo = await deviceInfo.androidInfo;
    if (Platform.isIOS) iosInfo = await deviceInfo.iosInfo;
    if (Platform.isMacOS) macInfo = await deviceInfo.macOsInfo;
    if (Platform.isWindows) windowsInfo = await deviceInfo.windowsInfo;
    if (Platform.isLinux) linuxInfo = await deviceInfo.linuxInfo;
  }

  bool get infoWell =>
      packageInfo != null &&
      (androidInfo != null || iosInfo != null || macInfo != null);

  _buildView() {
    if (kIsWeb) return WebDeviceView(webInfo: webInfo);
    if (Platform.isAndroid) return AndroidView(androidInfo: androidInfo);
    if (Platform.isIOS) return IOSView(iosInfo: iosInfo);
    if (Platform.isMacOS) return MacView(macInfo: macInfo);
    if (Platform.isLinux) return LinuxView(linuxInfo: linuxInfo);
    if (Platform.isWindows)
      return WindowsView(windowsInfo: windowsInfo);
    else
      return SliverToBoxAdapter(child: Text('不支持的平台'));
  }

  @override
  void initState() {
    super.initState();
    getAllInfo().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return infoWell
        ? CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                ListTile(
                  title: Text('Package Info'),
                  tileColor: Theme.of(context).accentColor.withOpacity(0.2),
                ),
                InfoTile(title: 'appName', subTitle: packageInfo!.appName),
                InfoTile(
                    title: 'buildNumber', subTitle: packageInfo!.buildNumber),
                InfoTile(
                    title: 'packageName', subTitle: packageInfo!.packageName),
                InfoTile(title: 'version', subTitle: packageInfo!.version),
                ListTile(
                  title: Text('Device Info'),
                  tileColor: Theme.of(context).accentColor.withOpacity(0.1),
                ),
              ])),
              _buildView(),
            ],
          )
        : ListView();
  }

  @override
  bool get wantKeepAlive => true;
}
