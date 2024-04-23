import 'package:intl/intl.dart';

extension YouAppDate on DateTime {

  String format(){
    return DateFormat('dd MM yyyy').format(this);
  }
}