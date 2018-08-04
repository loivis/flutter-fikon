import 'dart:convert';

class Book {
  String id,
      name,
      site,
      url,
      author,
      introduction,
      image,
      category,
      progress,
      wordCount,
      chapterLink,
      latestChapter;
  DateTime latestUpdate;

  String get key => this.site + this.name + this.id;

  Book(
    this.id,
    this.name,
    this.site,
    this.url,
    this.author,
    this.introduction,
    this.image,
    this.category,
    this.progress,
    this.wordCount,
    this.chapterLink,
  );

  Book.fromFavorite(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        site = json['site'],
        image = json['image'],
        chapterLink = json['chapterLink'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'site': site,
        'url': url,
        'author': author,
        'introduction': introduction,
        'image': image,
        'category': category,
        'progress': progress,
        'wordCount': wordCount,
        'chapterLink': chapterLink,
        'latestChapter': latestChapter,
        'latestUpdate': latestUpdate,
      };

  @override
  String toString() {
    return json.encode(this.toJson());
  }

  // factory Book.fromJson(Map<String, dynamic> json) {
  //   return Book(id, name, site, url, author, introduction, image, category, progress, wordCount)
  // }
  //      name = json['name'],
  //       email = json['email'];

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'email': email,
  //     };

  // var userJson = '''{
  //     "name": "John Smith",
  //     "email": "john@example.com"
  //   } ''';
  // Map userMap = json.decode(userJson);
  // var user = new User.fromJson(userMap);

  // print('Howdy, ${user.name}!');
  // print('We sent the verification link to ${user.email}.');
  // print(user);
  // print(json.encode(user));

}
