class Activity {
  late int id;
  late String title;
  late String subTitle;
  late String description;
  late String detailedDescription;
  late String extraNotes;
  late String externalUrl;
  late String videoUrl;
  late String specialAnnouncement;
  late List<Languages> languages;
  late List<Categories> categories;
  late List<Tags> tags;
  late int? minAge;
  late int? maxAge;
  late int creatorId;
  late String creatorName;
  late String? organization;
  late bool isVirtual;
  late bool occurringLive;
  late String nextDate;
  late String startDate;
  late String startDateEastern;
  late String startTime;
  late String startTimeEastern;
  late String endDate;
  late String endDateEastern;
  late String endTime;
  late String endTimeEastern;
  late String timeZone;
  late double duration;
  late int activityLengthInDays;
  late bool recurring;
  late String recurringDays;
  late String price;
  late String priceMax;
  late Currency currency;
  late String mainImage;
  late String mainImageThumbPath;
  late List<NeedToKnow> needToKnow;
  late List<BenefitsOfActivity> benefitsOfActivity;
  late List<FacilitiesAndAmenities> facilitiesAndAmenities;
  late String streetAddress;
  late String? additionalStreetAddress;
  late String? suiteNumber;
  late String province;
  late String city;
  late String postalCode;
  late String countryCode;
  late String longitude;
  late String latitude;
  late String? isHandicapFriendly;
  late String slug;
  late String webUrl;
  late bool expired;
  late String createdAt;

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    description = json['description'];
    detailedDescription = json['detailed_description'];
    extraNotes = json['extra_notes'];
    externalUrl = json['external_url'];
    videoUrl = json['video_url'];
    specialAnnouncement = json['special_announcement'];
    if (json['languages'] != null) {
      languages = [];
      json['languages'].forEach((v) {
        languages.add(new Languages.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    minAge = json['min_age'];
    maxAge = json['max_age'];
    creatorId = json['creator_id'];
    creatorName = json['creator_name'];
    organization = json['organization'];
    isVirtual = json['is_virtual'];
    occurringLive = json['occurring_live'];
    nextDate = json['next_date'];
    startDate = json['start_date'];
    startDateEastern = json['start_date_eastern'];
    startTime = json['start_time'];
    startTimeEastern = json['start_time_eastern'];
    endDate = json['end_date'];
    endDateEastern = json['end_date_eastern'];
    endTime = json['end_time'];
    endTimeEastern = json['end_time_eastern'];
    timeZone = json['time_zone'];
    duration = json['duration'];
    activityLengthInDays = json['activity_length_in_days'];
    recurring = json['recurring'];
    recurringDays = json['recurring_days'];
    price = json['price'];
    priceMax = json['price_max'];
    currency = (json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null)!;

    mainImage = json['main_image'];
    mainImageThumbPath = json['main_image_thumb_path'];
    if (json['need_to_know'] != null) {
      List<NeedToKnow> needToKnow = [];
      json['need_to_know'].forEach((v) {
        needToKnow.add(new NeedToKnow.fromJson(v));
      });
    }
    if (json['benefits_of_activity'] != null) {
      List<BenefitsOfActivity> benefitsOfActivity = [];
      json['benefits_of_activity'].forEach((v) {
        benefitsOfActivity.add(new BenefitsOfActivity.fromJson(v));
      });
    }
    if (json['facilities_and_amenities'] != null) {
      List<FacilitiesAndAmenities> facilitiesAndAmenities = [];
      json['facilities_and_amenities'].forEach((v) {
        facilitiesAndAmenities.add(new FacilitiesAndAmenities.fromJson(v));
      });
    }
    streetAddress = json['street_address'];
    additionalStreetAddress = json['additional_street_address'];
    suiteNumber = json['suite_number'];
    province = json['province'];
    city = json['city'];
    postalCode = json['postal_code'];
    countryCode = json['country_code'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    isHandicapFriendly = json['is_handicap_friendly'];
    slug = json['slug'];
    webUrl = json['web_url'];
    expired = json['expired'];
    createdAt = json['created_at'];
  }
}

class Languages {
  late int id;
  late String short;
  late String friendly;

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    short = json['short'];
    friendly = json['friendly'];
  }
}

class Categories {
  late int id;
  late String friendly;
  late String? defaultImage;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    friendly = json['friendly'];

    defaultImage = json['default_image'];
  }
}

class Currency {
  late int id;
  late String name;
  late String isoCode;
  late String symbol;
  late String friendly;

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isoCode = json['iso_code'];
    symbol = json['symbol'];
    friendly = json['friendly'];
  }
}

class FacilitiesAndAmenities {
  FacilitiesAndAmenities.fromJson(v);
}

class BenefitsOfActivity {
  BenefitsOfActivity.fromJson(v);
}

class NeedToKnow {
  NeedToKnow.fromJson(v);
}

class Tags {
  late int id;
  late String friendly;

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    friendly = json['friendly'];
  }
}

class ActivityImages {
  late int count;
  late String? next;
  late String? previous;
  late List<Results> results;
  ActivityImages.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  late int id;
  late String title;
  late String description;
  late String image;
  late String imageThumbPath;
  late String createdAt;
  late String updatedAt;
  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    imageThumbPath = json['image_thumb_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
