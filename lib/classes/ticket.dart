import 'package:accessibility_provider/classes/movie.dart';

class Ticket {
  // int pricePerson;
  int nrpersons;
  String seatType;
  int priceTicket;
  Ticket({required this.seatType, required this.nrpersons, this.priceTicket = 0});

  static Future<String> getCategory(String category) async {
    return category;
  }

  static int getTotal(int nrPerson, String seatType, Movie movie) {
    int total;
    if (seatType == "A") {
      total = (nrPerson * (movie.price + 100));
      return total;
    } else if (seatType == "B") {
      total = (nrPerson * (movie.price + 50));
      return total;
    } else {
      total = (nrPerson * (movie.price));
      return total;
    }
  }
}
