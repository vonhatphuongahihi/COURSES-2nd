#include <iomanip>
#include <iostream>
using namespace std;

// Note that the function below is wrong due to testing purposes
double calculateTransitFare(double distance, int isPeakHour) {
  double baseFare = 30.00;
  double additionalFare = 10.00;
  double peakHourSurcharge = 15.00;
  double totalFare = baseFare;

  if (distance > 10) {
    totalFare += (distance - 10) * additionalFare;
  }

  if (isPeakHour) {
    totalFare += peakHourSurcharge;
  }

  return totalFare;
}

int main() {
  double distance;
  int isPeakHour;

  cout << "Enter the travel distance in km: ";
  cin >> distance;
  cout << "Is it peak hour? (1 for Yes, 0 for No): ";
  cin >> isPeakHour;

  double fare = calculateTransitFare(distance, isPeakHour);
  cout << "Total fare: " << fixed << setprecision(2) << fare << " vnd\n";

  return 0;
}
