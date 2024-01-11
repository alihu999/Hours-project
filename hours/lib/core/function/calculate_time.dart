import 'time_format.dart';

differenceTime(String starAt, String finishAt) {
  int hourStrat = int.parse(starAt.substring(0, 2));
  int minuStart = int.parse(starAt.substring(3, 5));
  int hourFinish = int.parse(finishAt.substring(0, 2));
  int minuFinish = int.parse(finishAt.substring(3, 5));
  int hoursDifference = 0;
  int minuDifference = 0;
  if (hourFinish < hourStrat) {
    hoursDifference = (24 - hourStrat) + hourFinish;
  } else {
    hoursDifference = hourFinish - hourStrat;
  }
  if (minuStart <= minuFinish) {
    minuDifference = minuFinish - minuStart;
  } else {
    minuDifference = (60 - minuStart) + minuFinish;
    hoursDifference = hoursDifference - 1;
  }

  return "${hoursDifference.toString().padLeft(2, '0')}:${minuDifference.toString().padLeft(2, '0')}";
}

addTime(String time1, String time2) {
  int hour1 = int.parse(time1.substring(0, 2));
  int hour2 = int.parse(time2.substring(0, 2));

  int minu1 = int.parse(time1.substring(3, 5));
  int minu2 = int.parse(time2.substring(3, 5));

  int sumHour = hour1 + hour2;
  int sumMinu = 0;
  if (minu1 + minu2 >= 60) {
    sumHour = sumHour + 1;
  } else {
    sumMinu = minu1 + minu2;
  }
  return timeFormat(sumHour, sumMinu);
}

subTime(String time1, String time2) {
  int hour1 = int.parse(time1.substring(0, 2));
  int hour2 = int.parse(time2.substring(0, 2));

  int minu1 = int.parse(time1.substring(3, 5));
  int minu2 = int.parse(time2.substring(3, 5));

  int subHour = hour1 - hour2;
  int subminu = 0;

  if (minu1 - minu2 < 0) {
    subHour = subHour - 1;
    subminu = 60 + (minu1 - minu2);
  } else {
    subminu = minu1 - minu2;
  }
  return timeFormat(subHour, subminu);
}
