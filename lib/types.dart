class Package {
  String name;
  String scope;
  String version;
  String description;
  List<String> keywords;
  String date;
  Links links;
  Author author;
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
      this.author,
      this.publisher,
      this.maintainers});

  Package.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    scope = json['scope'];
    version = json['version'];
    description = json['description'];
    keywords = json['keywords'].cast<String>();
    date = json['date'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
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
    if (this.author != null) {
      data['author'] = this.author.toJson();
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

class Author {
  String name;

  Author({this.name});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
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
