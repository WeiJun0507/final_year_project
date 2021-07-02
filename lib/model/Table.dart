import 'package:final_year_project/model/availableTime.dart';

class TableSet {
  String id;
  TableSet({this.id});

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  TableSet.fromJson(Map<String, dynamic> json) :
    id = json['id'];
}

///Reservation Collection => document (From Everyday) => Table Collection (Five)
///=> Document for everySection (Five) => Each Reservation Info
///_cloud.collection(Table).document(Table${index}).set(
///
///Table Collection and Document is in one place
///So when the document(Everyday) create => generate five collection for table in different id : 1,2,3,4,5
///Each table should generate five object with different available time and store it as a document.
///
/// FirebaseReference ref = reference.instance.collection('Reservation');
/// Generate DatabaseReference dReference: .document(DateTime.todayDate());
/// Create/Set new data = dReference.collection('tableId').document(Table(tableId, availableTimeSection1)).add(Reservation(...));
