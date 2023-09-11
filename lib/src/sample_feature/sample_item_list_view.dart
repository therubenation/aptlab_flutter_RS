import 'package:aptlabgui/src/serial/sericalcom.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import '../settings/settings_controller.dart';
import 'sample_item.dart';
// import 'sample_item_details_view.dart';
import '../line_chart/line_chart_content.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView(
      {super.key,
      this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
      required this.controller});

  static const routeName = '/';
  final SettingsController controller;

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AptLabGUI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'new measurement1',
        onPressed: () {
          // print('Test' + controller.cmdString);
          // Navigate to the settings page. If the user leaves and returns
          // to the app after it has been killed while running in the
          // background, the navigation stack is restored.
          // Navigator.restorablePushNamed(context, SettingsView.routeName);
          //selectSerialPort(controller: this.controller).ListPorts();
          SelectSerialPort(controller: controller).sendToPort();
        },
        child: const Icon(Icons.add_task),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportContraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportContraints.maxHeight,
                    ),
                    child: LineChartContent(controller: controller)),
              );
            })),
      ),
    );
  }
}
