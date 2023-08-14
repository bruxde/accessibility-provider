class Movie {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final double rating;
  final int duration;
  final int price;

  Movie({
    this.id = "",
    this.price = 0,
    required this.photoUrl,
    required this.name,
    required this.description,
    this.rating = 0.0,
    this.duration = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "rating": rating,
      "duration": duration,
      "photoUrl": photoUrl,
      "price": price
    };
  }

// String get hourlyDuration => Datet

  static Movie fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      photoUrl: json["photoUrl"] ?? "",
      rating: json["rating"] ?? 0,
      duration: json["duration"] ?? 0,
      price: json["price"] ?? 0,
    );
  }

  Movie copyWith({
    String? id,
    String? name,
    String? description,
    String? photoUrl,
    double? rating,
    int? duration,
    int? price,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      duration: duration ?? this.duration,
      price: price ?? this.price,
    );
  }
}
