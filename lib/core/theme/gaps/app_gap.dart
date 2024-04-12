import 'package:gap/gap.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/theme/gaps/i_app_gap.dart';
import 'package:sizer/sizer.dart';

@Singleton(as: IAppGap)
class AppGap implements IAppGap {
  @override
  Gap get extra => Gap(24.sp);

  @override
  Gap get large => Gap(16.sp);

  @override
  Gap get small => Gap(10.sp);
}
