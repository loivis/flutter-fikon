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
      wordCount;
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
  );
}
