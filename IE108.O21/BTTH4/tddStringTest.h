#include <iomanip>
#include <iostream>
using namespace std;

void tdd_run_test(int no, int result, int expected_result) {
  cout << "No." << setw(2) << no << ": ";
  if (result == expected_result) {
    cout << "PASS\n";
  } else {
    cout << "*** FAIL! ***: result = " << result
         << " (expected result = " << expected_result << ")\n";
  }
}
