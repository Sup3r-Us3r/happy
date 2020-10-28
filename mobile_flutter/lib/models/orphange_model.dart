class Orphanage {
  int id;
  String name;
  double latitude;
  double longitude;
  String about;
  String instructions;
  String openingHours;
  bool openOnWeekends;
  List<OrphanageImages> images;

  Orphanage({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.about,
    this.instructions,
    this.openingHours,
    this.openOnWeekends,
    this.images,
  });

  Orphanage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    about = json['about'];
    instructions = json['instructions'];
    openingHours = json['opening_hours'];
    openOnWeekends = json['open_on_weekends'];
    if (json['images'] != null) {
      images = new List<OrphanageImages>();
      json['images'].forEach((v) {
        images.add(new OrphanageImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['about'] = this.about;
    data['instructions'] = this.instructions;
    data['opening_hours'] = this.openingHours;
    data['open_on_weekends'] = this.openOnWeekends;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrphanageImages {
  int id;
  String url;

  OrphanageImages({
    this.id,
    this.url,
  });

  OrphanageImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
