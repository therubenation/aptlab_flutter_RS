// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:simple_line_chart/simple_line_chart.dart';

import 'settings_service.dart';

enum WorkingElectrode {
  /// Use working electrode 0
  we0,

  /// Use working electrode 1
  we1,

  /// Use working electrode 2
  we2,
}

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  late int _freqHz;
  int get freqHz => _freqHz;
  late int _ep;
  int get ep => _ep;
  late int _es;
  int get es => _es;
  late int _t0;
  int get t0 => _t0;
  late int _maxi;
  int get maxi => _maxi;
  late RangeValues _range;
  RangeValues get range => _range;
  late WorkingElectrode _workingElectrode;
  WorkingElectrode get workingElectrode => _workingElectrode;

  late List<DataPoint> _dataPoints;
  List<DataPoint> get dataPoints => _dataPoints;

  late String _cmdString;

  String get cmdString => _cmdString;

  late String _dataString;
  String get dataString => _dataString;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _cmdString = await _settingsService.cmdString();
    _dataString = await _settingsService.dataString();
    _freqHz = await _settingsService.freqHz();
    _ep = await _settingsService.ep();
    _es = await _settingsService.es();
    _t0 = await _settingsService.t0();
    _maxi = await _settingsService.maxi();
    _range = await _settingsService.range();
    _workingElectrode = await _settingsService.workingElectrode();
    _dataPoints = await _settingsService.dataPoints();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
    updateCmdString();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }

  /// Update and persist the cmdString based on the user's selection.
  Future<void> updateCmdString() async {
    //if (newCmdString == null) return;
    int es1 = es * (-1);
    int e1 = range.start.round() * (-1) - ep;
    int e2 = range.end.round() * (-1) - ep;

    String newCmdString =
        'swvlp  --freq=$freqHz --ep=$ep --es=$es1 --we=${workingElectrode.index.toString()} --e1=$e1 --e2=$e2 --maxi=${maxi.toString()} \n';

    // Do not perform any work if new and old ThemeMode are identical
    if (newCmdString == _cmdString) return;

    // Otherwise, store the new ThemeMode in memory
    _cmdString = newCmdString;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateCmdString(newCmdString);
  }

  /// Update and persist the  dataString
  Future<void> updateDataString(String? newDataString) async {
    if (newDataString == null) return;
    if (newDataString == _dataString) return;
    _dataString = newDataString;
    notifyListeners();
    await _settingsService.updateDataString(newDataString);
  }

  /// Update and persist the  freqHz
  Future<void> updateFreqHz(int newFreqHz) async {
    // if (newFreqHz == null) return;
    if (newFreqHz == _freqHz) return;
    _freqHz = newFreqHz;
    notifyListeners();
    updateCmdString();
    await _settingsService.updateFreqHz(newFreqHz);
  }

  /// Update and persist the maxi
  Future<void> updateMaxi(int newMaxi) async {
    // if (newFreqHz == null) return;
    if (newMaxi == _maxi) return;
    _maxi = newMaxi;
    notifyListeners();
    updateCmdString();
    await _settingsService.updateMaxi(newMaxi);
  }

  /// Update and persist the EP
  Future<void> updateEp(int newEp) async {
    // if (newFreqHz == null) return;
    if (newEp == _ep) return;
    _ep = newEp;
    notifyListeners();
    updateCmdString();
    await _settingsService.updateEp(newEp);
  }

  /// Update and persist the ES
  Future<void> updateEs(int newEs) async {
    // if (newFreqHz == null) return;
    if (newEs == _es) return;
    _es = newEs;
    notifyListeners();
    updateCmdString();
    await _settingsService.updateEs(newEs);
  }

  /// Update and persist the T0
  Future<void> updateT0(int newT0) async {
    // if (newFreqHz == null) return;
    if (newT0 == _t0) return;
    _t0 = newT0;
    notifyListeners();
    updateCmdString();
    await _settingsService.updateT0(newT0);
  }

  /// Update and persist the range
  Future<void> updateRange(RangeValues newRange) async {
    // if (newRange == null) return;
    if (newRange == _range) return;
    _range = newRange;
    notifyListeners();
    updateCmdString();
    await _settingsService.updateRange(newRange);
  }

  /// Update and persist the range
  Future<void> updateWorkingElectrode(
      WorkingElectrode? newWorkingElectrode) async {
    if (newWorkingElectrode == null) return;
    if (newWorkingElectrode == _workingElectrode) return;
    _workingElectrode = newWorkingElectrode;
    notifyListeners();
    updateCmdString();
    await _settingsService.updateWorkingElectrode(newWorkingElectrode);
  }

  // Update and persist chart data
  Future<void> updateDataPoints(List<DataPoint> newDataPoints) async {
    // if (newDataPoints == null) return;
    // if (newDataPoint == _workingElectrode) return;
    _dataPoints = newDataPoints;
    notifyListeners();
    // updateCmdString();
    await _settingsService.updateDataPoints(newDataPoints);
  }
}
