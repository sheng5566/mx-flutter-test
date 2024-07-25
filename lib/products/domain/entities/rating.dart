import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final double rate;
  final int count;
  const Rating({
    required this.rate,
    required this.count,
  });

  // Article({@required this.id, @required this.title, @required this.description, this.image, @required this.publishDate, this.tags});

  factory Rating.fromJson(Map<String, dynamic> json) {
    var rateJson = json['rate'];
    bool isInt = rateJson is int;
    double rate = isInt ? (rateJson as int).toDouble() : rateJson as double;
    return Rating(
      rate: rate,
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  @override
  List<Object?> get props => [rate, count];
}
