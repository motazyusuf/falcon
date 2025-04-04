import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falcon_project/modules/members/screen/widgets/all_members_screen_body.dart';
import 'package:falcon_project/modules/members/screen/widgets/dialogues/critical_action_dialogue.dart';
import 'package:falcon_project/modules/members/screen/widgets/dialogues/edit_member_dialogue.dart';
import 'package:falcon_project/modules/members/screen/widgets/member_brief.dart';
import 'package:falcon_project/modules/members/screen/widgets/member_full_details/member_full_details.dart';
import 'package:falcon_project/network/members_module_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/enums/sport_enum.dart';
import '../../../network/member_model.dart';
import '../screen/widgets/dialogues/add_subscription_dialogue.dart';
import '../screen/widgets/search_bar.dart';

part '../bloc/members_module_bloc.dart';
part '../event/members_module_event.dart';
part '../factory/members_module_factory.dart';
part '../screen/all_members_screen.dart';
part '../state/members_module_state.dart';
