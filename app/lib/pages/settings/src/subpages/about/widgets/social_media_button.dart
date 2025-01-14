// Copyright (c) 2022 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter/material.dart';
import 'package:sharezone/util/launch_link.dart';
import 'package:sharezone_widgets/snackbars.dart';
import 'package:sharezone_widgets/svg.dart';
import 'package:url_launcher/url_launcher.dart';

enum SocialButtonTypes {
  linkedIn,
  instagram,
  twitter,
  discord,
  email,
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    @required this.svgPath,
    this.tooltipp,
    this.link,
    this.socialButtonTypes,
  });

  const SocialButton.instagram(this.link)
      : tooltipp = 'Instagram',
        svgPath = 'assets/icons/instagram.svg',
        socialButtonTypes = SocialButtonTypes.instagram;

  const SocialButton.twitter(this.link)
      : tooltipp = 'Twitter',
        svgPath = 'assets/icons/twitter.svg',
        socialButtonTypes = SocialButtonTypes.twitter;

  const SocialButton.linkedIn(this.link)
      : tooltipp = 'LinkedIn',
        svgPath = 'assets/icons/linkedin.svg',
        socialButtonTypes = SocialButtonTypes.linkedIn;

  const SocialButton.discord(this.link)
      : tooltipp = 'Discord',
        svgPath = 'assets/icons/discord.svg',
        socialButtonTypes = SocialButtonTypes.linkedIn;

  const SocialButton.email(this.link)
      : tooltipp = 'E-Mail',
        svgPath = 'assets/icons/email.svg',
        socialButtonTypes = SocialButtonTypes.email;

  final String link, tooltipp, svgPath;
  final SocialButtonTypes socialButtonTypes;
  static const double _svgSize = 28;

  Future<void> onPressed(BuildContext context) async {
    if (socialButtonTypes != SocialButtonTypes.email)
      launchURL(link);
    else {
      final url = Uri.parse(Uri.encodeFull("mailto:$link"));
      if (await canLaunchUrl(url)) {
        launchUrl(url);
      } else {
        showSnackSec(
          text: "E-Mail: $link",
          context: context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltipp,
      onPressed: () => onPressed(context),
      icon: PlatformSvg.asset(
        svgPath,
        width: _svgSize,
        height: _svgSize,
        color: Theme.of(context).primaryColor,
      ),
      iconSize: _svgSize,
    );
  }
}
