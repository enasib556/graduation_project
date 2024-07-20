class GetCountryModel {
  GetCountryModel({
    required this.success,
    required this.result,
  });
  late final int success;
  late final List<Result> result;

  GetCountryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = List.from(json['result']).map((e) => Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['result'] = result.map((e) => e.toJson()).toList();
    return data;
  }
}

class Result {
  Result({
    required this.countryKey,
    required this.countryName,
    this.countryIso2,
    this.countryLogo,
  });
  late final int? countryKey;
  late final String countryName;
  late final String? countryIso2;
  late final String? countryLogo;

  Result.fromJson(Map<String, dynamic> json) {
    countryKey = json['country_key'];
    countryName = json['country_name'];
    countryIso2 = json['country_iso2'];
    countryLogo = json['country_logo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['country_key'] = countryKey;
    data['country_name'] = countryName;
    data['country_iso2'] = countryIso2;
    data['country_logo'] = countryLogo;
    return data;
  }
}
