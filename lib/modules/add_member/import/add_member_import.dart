import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opticore/opticore.dart';

import '../../../core/config/translations/codegen_loader.g.dart';
import '../../../core/enums/sport_enum.dart';
import '../../../core/network/model/member_model.dart';
import '../../../core/network/repo/members_module_repo.dart';
import '../../../utils/helper/helper.dart';
import '../widgets/subscription_item.dart';

part '../bloc/add_member_bloc.dart';
part '../event/add_member_event.dart';
part '../factory/add_member_state_factory.dart';
part '../screen/add_member_screen.dart';
part '../state/add_member_state.dart';
