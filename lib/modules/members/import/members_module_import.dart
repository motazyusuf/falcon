import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falcon_project/modules/member_full_details/import/member_full_details_import.dart';
import 'package:falcon_project/modules/members/screen/widgets/all_members_screen_body.dart';
import 'package:falcon_project/modules/members/screen/widgets/member_brief.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/enums/sport_enum.dart';
import '../../../core/network/model/member_model.dart';
import '../../../core/network/repo/members_module_repo.dart';
import '../../../utils/helper/helper.dart';
import '../screen/widgets/search_bar.dart';

part '../bloc/members_module_bloc.dart';
part '../event/members_module_event.dart';
part '../factory/members_module_factory.dart';
part '../screen/all_members_screen.dart';
part '../state/members_module_state.dart';
