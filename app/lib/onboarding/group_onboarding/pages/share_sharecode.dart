// Copyright (c) 2022 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:group_domain_models/group_domain_models.dart';
import 'package:optional/optional.dart';
import 'package:sharezone/groups/src/widgets/group_qr_code.dart';
import 'package:sharezone/groups/src/widgets/group_share.dart';
import 'package:sharezone/groups/src/widgets/sharecode_text.dart';
import 'package:sharezone/onboarding/group_onboarding/logic/group_onboarding_bloc.dart';
import 'package:sharezone/onboarding/group_onboarding/pages/group_onboarding_page_template.dart';
import 'package:sharezone/onboarding/group_onboarding/widgets/title.dart';
import 'package:sharezone/onboarding/sign_up/sign_up_page.dart';
import 'package:sharezone_widgets/additional.dart';
import 'package:sharezone_widgets/svg.dart';
import 'package:user/user.dart';

class GroupOnboardingShareSharecode extends StatelessWidget {
  const GroupOnboardingShareSharecode({Key key, @required this.schoolClassId})
      : super(key: key);

  static const tag = 'onboarding-share-sharecode-page';
  final Optional<String> schoolClassId;

  @override
  Widget build(BuildContext context) {
    return GroupOnboardingPageTemplate(
      padding: const EdgeInsets.all(16),
      top: Container(),
      topPadding: 0,
      children: [
        _Icon(),
        const SizedBox(height: 12),
        _Title(),
        const SizedBox(height: 6),
        _JoinHint(),
        const SizedBox(height: 18),
        if (schoolClassId.isPresent)
          _SchoolClassSharecodeBox(schoolClassId: schoolClassId.value)
        else
          _CoursesSharecodeBox(),
      ],
      bottomNavigationBar: OnboardingNavigationBar(action: _FinsihButton()),
    );
  }
}

class _Icon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformSvg.asset(
      'assets/icons/teamwork.svg',
      height: 120,
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GroupOnboardingTitle(getText(context));
  }

  String getText(BuildContext context) {
    final bloc = BlocProvider.of<GroupOnboardingBloc>(context);
    switch (bloc.typeOfUser) {
      case TypeOfUser.teacher:
        return 'Lade jetzt deine Schüler und Schülerinnen ein!';
        break;
      case TypeOfUser.parent:
        return 'Lade jetzt andere Schüler, Eltern oder Lehrkräfte ein!';
      case TypeOfUser.student:
      default:
        return 'Lade jetzt deine Mitschüler und deinen Lehrer / deine Lehrerin ein!';
    }
  }
}

class _CoursesSharecodeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GroupOnboardingBloc>(context);
    return StreamBuilder<List<GroupInfo>>(
      stream: bloc.courseGroupInfos(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return _LoadingSharecodeBox();

        final groupInfos = snapshot.data;
        return Column(
          children: [
            for (final groupInfo in groupInfos)
              _SharecodeBox(groupInfo: groupInfo),
          ],
        );
      },
    );
  }
}

class _SchoolClassSharecodeBox extends StatelessWidget {
  const _SchoolClassSharecodeBox({Key key, this.schoolClassId})
      : super(key: key);

  final String schoolClassId;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GroupOnboardingBloc>(context);
    return StreamBuilder<GroupInfo>(
      stream: bloc.schoolClassGroupInfo(schoolClassId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return _LoadingSharecodeBox();

        final groupInfo = snapshot.data;
        return _SharecodeBox(groupInfo: groupInfo);
      },
    );
  }
}

class _LoadingSharecodeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mockGroupInfo = GroupInfo(
      id: 'id',
      name: 'name',
      design: null,
      meetingID: null,
      abbreviation: null,
      sharecode: null,
      joinLink: null,
      groupType: GroupType.schoolclass,
    );

    return GrayShimmer(child: _SharecodeBox(groupInfo: mockGroupInfo));
  }
}

class _SharecodeBox extends StatelessWidget {
  const _SharecodeBox({
    Key key,
    @required this.groupInfo,
  }) : super(key: key);

  final GroupInfo groupInfo;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                "Zum Beitreten ${getGroupType()} (${groupInfo.name}):",
                style: TextStyle(color: Colors.grey),
              ),
              SharecodeText(groupInfo.sharecode, onCopied: () {
                BlocProvider.of<GroupOnboardingBloc>(context).logShareQrcode();
              }),
              const SizedBox(height: 12),
              Row(
                children: [
                  QRCodeButton(groupInfo, closeDialog: false),
                  const SizedBox(width: 12),
                  LinkSharingButton(groupInfo: groupInfo),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String getGroupType() {
    switch (groupInfo.groupType) {
      case GroupType.course:
        return 'des Kurses';
      case GroupType.schoolclass:
        return 'der Schulklasse';
      case GroupType.school:
        return 'der Schule';
      default:
        return '';
    }
  }
}

class _JoinHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Mitschüler, Lehrer und Eltern können über den Sharecode der Klasse beitreten. Dadurch können Infozettel, Hausausgaben, Termine, Dateien und der Stundenplan gemeinsam organisiert werden.',
      style: const TextStyle(color: Colors.grey),
      textAlign: TextAlign.center,
    );
  }
}

class _FinsihButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      child: Text("Fertig".toUpperCase(), style: TextStyle(fontSize: 20)),
      onPressed: () {
        final bloc = BlocProvider.of<GroupOnboardingBloc>(context);
        bloc.finsihOnboarding();
        Navigator.popUntil(context, ModalRoute.withName('/'));
      },
    );
  }
}
