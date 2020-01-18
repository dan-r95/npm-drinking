class Result {
  List<Objects> objects;

  Result({this.objects});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['objects'] != null) {
      objects = new List<Objects>();
      json['objects'].forEach((v) {
        objects.add(new Objects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.objects != null) {
      data['objects'] = this.objects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Objects {
  Package package;
  Score score;
  double searchScore;

  Objects({this.package, this.score, this.searchScore});

  Objects.fromJson(Map<String, dynamic> json) {
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
    searchScore = json['searchScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['package'] = this.package.toJson();
    }
    if (this.score != null) {
      data['score'] = this.score.toJson();
    }
    data['searchScore'] = this.searchScore;
    return data;
  }
}

class Package {
  String name;
  String scope;
  String version;
  String description;
  List<String> keywords;
  String date;
  Links links;
  Publisher publisher;
  List<Maintainers> maintainers;

  Package(
      {this.name,
      this.scope,
      this.version,
      this.description,
      this.keywords,
      this.date,
      this.links,
      this.publisher,
      this.maintainers});

  Package.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    scope = json['scope'];
    version = json['version'];
    description = json['description'];
    keywords =
        json['keywords'] != null ? json['keywords'].cast<String>() : null;
    date = json['date'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    publisher = json['publisher'] != null
        ? new Publisher.fromJson(json['publisher'])
        : null;
    if (json['maintainers'] != null) {
      maintainers = new List<Maintainers>();
      json['maintainers'].forEach((v) {
        maintainers.add(new Maintainers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['scope'] = this.scope;
    data['version'] = this.version;
    data['description'] = this.description;
    data['keywords'] = this.keywords;
    data['date'] = this.date;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.publisher != null) {
      data['publisher'] = this.publisher.toJson();
    }
    if (this.maintainers != null) {
      data['maintainers'] = this.maintainers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String npm;
  String homepage;
  String repository;
  String bugs;

  Links({this.npm, this.homepage, this.repository, this.bugs});

  Links.fromJson(Map<String, dynamic> json) {
    npm = json['npm'];
    homepage = json['homepage'];
    repository = json['repository'];
    bugs = json['bugs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['npm'] = this.npm;
    data['homepage'] = this.homepage;
    data['repository'] = this.repository;
    data['bugs'] = this.bugs;
    return data;
  }
}

class Publisher {
  String username;
  String email;

  Publisher({this.username, this.email});

  Publisher.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}

class Score {
  double finalScore;
  Detail detail;

  Score({this.finalScore, this.detail});

  Score.fromJson(Map<String, dynamic> json) {
    finalScore = json['final'];
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['final'] = this.finalScore;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    return data;
  }
}

class Detail {
  double quality;
  double popularity;
  double maintenance;

  Detail({this.quality, this.popularity, this.maintenance});

  Detail.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    popularity = json['popularity'];
    maintenance = json['maintenance'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quality'] = this.quality;
    data['popularity'] = this.popularity;
    data['maintenance'] = this.maintenance;
    return data;
  }
}

class Maintainers {
  String username;
  String email;

  Maintainers({this.username, this.email});

  Maintainers.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}
