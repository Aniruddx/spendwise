//convert DateTimeobject to a string yyymmdd

String convertDateTimeToString(DateTime dateTime){
  //year format->yyyy
  String year = dateTime.year.toString();
  //month format->mm
  String month = dateTime.month.toString();
  if (month.length==1){
    month = '0$month';
  }

  String day = dateTime.day.toString();
  if (day.length==1){
    day = '0$day';
  }
  //finalformat->yyyymmdd
  String yyyymmdd = year+month+day;
  return yyyymmdd;
}