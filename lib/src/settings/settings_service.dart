// import 'dart:ffi';
import 'package:simple_line_chart/simple_line_chart.dart';

import 'package:aptlabgui/src/settings/settings_controller.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }

  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<String> cmdString() async => "swv ";

  Future<int> freqHz() async => 100;

  Future<int> ep() async => 100;
  Future<int> es() async => 5;
  Future<int> t0() async => 100;
  Future<int> maxi() async => 100;
  Future<RangeValues> range() async => const RangeValues(-400, 0);
  Future<WorkingElectrode> workingElectrode() async => WorkingElectrode.we0;
  Future<List<DataPoint>> dataPoints() async => [];

  Future<void> updateFreqHz(int freqHz) async {}
  Future<void> updateEp(int ep) async {}
  Future<void> updateEs(int es) async {}
  Future<void> updateT0(int t0) async {}
  Future<void> updateMaxi(int maxi) async {}
  Future<void> updateRange(RangeValues range) async {}
  Future<void> updateDataPoints(List<DataPoint> dataPoints) async {}
  Future<void> updateWorkingElectrode(
      WorkingElectrode workingElectrode) async {}

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateCmdString(String cmdString) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }

  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<String> dataString() async => "swv=[[1.0,2.0,4.0,5.0]]";

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateDataString(String dataString) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }
}
