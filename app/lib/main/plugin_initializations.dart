// Copyright (c) 2022 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:crash_analytics/crash_analytics.dart';
import 'package:dynamic_links/dynamic_links.dart';
import 'package:remote_configuration/remote_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class PluginInitializations {
  const PluginInitializations(
      {this.remoteConfiguration,
      this.crashAnalytics,
      this.dynamicLinks,
      this.sharedPreferences,
      this.streamingSharedPreferences});

  final RemoteConfiguration remoteConfiguration;
  final CrashAnalytics crashAnalytics;
  final DynamicLinks dynamicLinks;
  final SharedPreferences sharedPreferences;
  final StreamingSharedPreferences streamingSharedPreferences;

  static Future<CrashAnalytics> initializeCrashAnalytics() async {
    final crashAnalytics = getCrashAnalytics();
    crashAnalytics.enableInDevMode = true;
    return crashAnalytics;
  }

  static Future<DynamicLinks> initializeDynamicLinks() async {
    final dynamicLinks = getDynamicLinks();
    return dynamicLinks;
  }

  static Future<RemoteConfiguration> initializeRemoteConfiguration() async {
    final remoteConfiguration = getRemoteConfiguration();

    await remoteConfiguration.initialize({
      'meeting_server_url': 'https://meet.sharezone.net',
      'abgaben_bucket_name': 'sharezone-c2bd8-submissions',
      'abgaben_service_base_url': 'https://api.sharezone.net',
      'revenuecat_api_key': 'WLjPXTYvlcvxwFKOXWuHxDvKteGhqVpQ',
    });
    return remoteConfiguration;
  }

  static Future<SharedPreferences> initializeSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<StreamingSharedPreferences>
      initializeStreamingSharedPreferences() async {
    final prefs = await StreamingSharedPreferences.instance;
    return prefs;
  }
}

Future<PluginInitializations> runPluginInitializations() async {
  final futureRemoteConfiguration =
      PluginInitializations.initializeRemoteConfiguration();
  final futureSharedPrefs = PluginInitializations.initializeSharedPreferences();
  final futureStreamingSharedPrefs =
      PluginInitializations.initializeStreamingSharedPreferences();
  final futureCrashAnalytics = PluginInitializations.initializeCrashAnalytics();
  final futureDynamicLinks = PluginInitializations.initializeDynamicLinks();

  final result = await Future.wait([
    futureSharedPrefs,
    futureRemoteConfiguration,
    futureStreamingSharedPrefs,
    futureCrashAnalytics,
    futureDynamicLinks,
  ]);
  return PluginInitializations(
    sharedPreferences: result[0] as SharedPreferences,
    remoteConfiguration: result[1] as RemoteConfiguration,
    streamingSharedPreferences: result[2] as StreamingSharedPreferences,
    crashAnalytics: result[3] as CrashAnalytics,
    dynamicLinks: result[4] as DynamicLinks,
  );
}
