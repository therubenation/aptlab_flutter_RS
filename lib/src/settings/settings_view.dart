import 'package:flutter/material.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body:
            //Padding(
            // padding: const EdgeInsets.all(16),
            // Glue the SettingsController to the theme selection DropdownButton.
            //
            // When a user selects a theme from the dropdown list, the
            // SettingsController is updated, which rebuilds the MaterialApp.
            ListView(children: [
          DropdownButton<ThemeMode>(
            // Read the selected themeMode from the controller
            value: controller.themeMode,
            // Call the updateThemeMode method any time the user selects a theme.
            onChanged: controller.updateThemeMode,
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('System Theme'),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Light Theme'),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Dark Theme'),
              )
            ],
          ),
          const Text(
            'Square Wave Voltammetry parameters',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 30,
            ),
          ),
          SliderSettingsHz(
            controller: controller,
          ),
          SliderSettingsEP(
            controller: controller,
          ),

          SliderSettingsES(
            controller: controller,
          ),
          SliderSettingsT0(
            controller: controller,
          ),
          SliderSettingsMaxi(
            controller: controller,
          ),
          SliderSettingsRange(
            controller: controller,
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<WorkingElectrode>(
                // Read the selected themeMode from the controller
                value: controller.workingElectrode,
                // Call the updateThemeMode method any time the user selects a theme.
                onChanged: controller.updateWorkingElectrode,
                items: const [
                  DropdownMenuItem(
                    value: WorkingElectrode.we0,
                    child: Text(
                      'WE0',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: WorkingElectrode.we1,
                    child: Text(
                      'WE1',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: WorkingElectrode.we2,
                    child: Text(
                      'WE2',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              )),
          Text(controller.cmdString)

          //print(' Text field: $text d');
          //controller.updateCmdString(text);

          //decoration: InputDecoration(
          //    hintStyle: TextStyle(color: Colors.blue),
          //    hintText: "Enter your name"),
          // ),
        ]));
  }
}

class SliderSettingsHz extends StatelessWidget {
  const SliderSettingsHz({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Frequency:  ${controller.freqHz} Hz',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ))),
      ),
      Expanded(
        flex: 2,
        child: Slider(
          value: controller.freqHz.toDouble(),
          min: 10,
          max: 500,
          divisions: 49,
          label: controller.freqHz.toString(),
          onChanged: (double value) {
            controller.updateFreqHz(value.round());
          },
        ),
      )
    ]);
  }
}

class SliderSettingsEP extends StatelessWidget {
  const SliderSettingsEP({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Pulse height EP: ${controller.ep.toString()} mV',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ))),
      ),
      Expanded(
        flex: 2,
        child: Slider(
          value: controller.ep.toDouble(),
          min: 5,
          max: 100,
          divisions: 19,
          label: controller.ep.toString(),
          onChanged: (double value) {
            controller.updateEp(value.round());
          },
        ),
      ),
    ]);
  }
}

class SliderSettingsES extends StatelessWidget {
  const SliderSettingsES({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Pulse step size ES: ${controller.es.toString()} mV',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ))),
      ),
      Expanded(
        flex: 2,
        child: Slider(
          value: controller.es.toDouble(),
          min: 1,
          max: 20,
          divisions: 19,
          label: controller.es.toString(),
          onChanged: (double value) {
            controller.updateEs(value.round());
          },
        ),
      ),
    ]);
  }
}

class SliderSettingsT0 extends StatelessWidget {
  const SliderSettingsT0({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Start delay: ${controller.t0.toString()} ms',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ))),
      ),
      Expanded(
        flex: 2,
        child: Slider(
          value: controller.t0.toDouble(),
          min: 0,
          max: 500,
          divisions: 20,
          label: controller.t0.toString(),
          onChanged: (double value) {
            controller.updateT0(value.round());
          },
        ),
      ),
    ]);
  }
}

class SliderSettingsMaxi extends StatelessWidget {
  const SliderSettingsMaxi({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Max. current: ${controller.maxi.toString()} uA',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ))),
      ),
      Expanded(
        flex: 2,
        child: Slider(
          value: controller.maxi.toDouble(),
          min: 0,
          max: 5000,
          divisions: 20,
          label: controller.maxi.toString(),
          onChanged: (double value) {
            controller.updateMaxi(value.round());
          },
        ),
      ),
    ]);
  }
}

class SliderSettingsRange extends StatelessWidget {
  const SliderSettingsRange({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'Scan range: ${controller.range.start.round().toString()}..${controller.range.end.round().toString()} mV',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ))),
      ),
      Expanded(
        flex: 2,
        child: RangeSlider(
          values: controller.range,
          min: -600,
          max: 600,
          divisions: 24,
          labels: RangeLabels(controller.range.start.round().toString(),
              controller.range.end.round().toString()),
          onChanged: (RangeValues range) {
            controller.updateRange(range);
          },
        ),
      ),
      // Text(controller.range.end.round().toString() + " mv"),
    ]);
  }
}
