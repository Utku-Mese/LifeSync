class BodyMeasurementController {
  double calculateBMI(double weight, int height) {
    double dHeight = height / 100;
    return (weight / (dHeight * dHeight));
  }

  double calculateBodyFatPercentage(
      double weight, int height, int age, bool isMale) {
    double heightInMeters = height / 100.0;

    double bmi = weight / (heightInMeters * heightInMeters);

    double bodyFatPercentage;

    if (isMale) {
      bodyFatPercentage =
          0.73288 * bmi - 0.0005 * bmi * bmi + 0.0000123 * age - 0.0004338;
    } else {
      bodyFatPercentage =
          0.73669 * bmi - 0.00043 * bmi * bmi + 0.0000121 * age + 0.0003101;
    }

    return bodyFatPercentage;
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}
