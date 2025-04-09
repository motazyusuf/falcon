import 'package:falcon_project/modules/member_full_details/import/member_full_details_import.dart';
import 'package:falcon_project/widgets/member_brief.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/network/model/member_model.dart';
import '../../../core/network/repo/members_module_repo.dart';
import '../../../utils/helper/helper.dart';
import '../widgets/members_overview.dart';
import '../widgets/revenue_report.dart';
import '../widgets/upcoming_expiry.dart';

part '../bloc/analytics_module_bloc.dart';
part '../event/analytics_module_event.dart';
part '../factory/analytics_module_state_factory.dart';
part '../screen/analytics_module_screen.dart';
part '../state/analytics_module_state.dart';
