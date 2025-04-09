import '../config/translations/codegen_loader.g.dart';

enum Sport {

//   static const mt_teens = 'mt_teens';
// static const mt_ladies = 'mt_ladies';
// static const mt_101 = 'mt_101';
// static const mt_advanced = 'mt_advanced';
// static const kids_kickboxing = 'kids_kickboxing';
// static const kickboxing = 'kickboxing';
// static const kids_boxing = 'kids_boxing';
// static const boxing_teens = 'boxing_teens';
// static const boxing = 'boxing';
// static const mma = 'mma';
// static const grappling = 'grappling';
// static const burn_gain = 'burn_gain';
// static const pt = 'pt';
// static const pt_advanced = 'pt_advanced';
// static const SC = 'SC';

  mt_teens(LocaleKeys.mt_teens),
  mt_ladies(LocaleKeys.mt_ladies),
  mt_101(LocaleKeys.mt_101),
  mt_advanced(LocaleKeys.mt_advanced),
  kids_kickboxing(LocaleKeys.kids_kickboxing),
  kickboxing(LocaleKeys.kickboxing),
  kids_boxing(LocaleKeys.kids_boxing),
  boxing_teens(LocaleKeys.boxing_teens),
  boxing(LocaleKeys.boxing),
  mma(LocaleKeys.mma),
  grappling(LocaleKeys.grappling),
  burn_gain(LocaleKeys.burn_gain),
  pt(LocaleKeys.pt),
  pt_advanced(LocaleKeys.pt_advanced),
  SC(LocaleKeys.SC);

  final String localeKey;
  const Sport(this.localeKey);


  static Sport fromString(String value) =>
      Sport.values.firstWhere((sport) => sport.localeKey == value);
}
