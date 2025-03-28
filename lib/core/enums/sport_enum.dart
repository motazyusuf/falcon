enum Sport {
  muayThaiTeens("Muay Thai Teens"),
  muayThaiLadies("Muay Thai Ladies"),
  muayThai101("Muay Thai 101"),
  muayThaiAdvanced("Muay Thai Adv"),
  kickboxingKids("Kids Kickboxing"),
  kickboxing("Kickboxing"),
  boxingKids("Kids Boxing"),
  boxingTeens("Boxing Teens"),
  boxing("Boxing"),
  mma("MMA"),
  grappling("Grappling"),
  burnAndGain("Burn and Gain"),
  pt("PT"),
  ptAdvanced("PT Advanced"),
  strengthAndConditioning("S&C");

  final String displayName;

  const Sport(this.displayName);

  @override
  String toString() => name;

  static Sport fromString(String value) =>
      Sport.values.firstWhere((sport) => sport.displayName == value);
}
