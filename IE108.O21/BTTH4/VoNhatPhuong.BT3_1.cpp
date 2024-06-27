#include "tddStringTest.h"
#include <string>
#include <sstream>
#include <vector>
#include <iostream>

using namespace std;

int add(const string &numbers) {
    if (numbers.empty()) return 0;
    string delimiters = ",\n";
    string nums = numbers;
    if (numbers.substr(0, 2) == "//") {
        size_t newline_pos = numbers.find('\n');
        if (newline_pos != string::npos) {
            delimiters = numbers.substr(2, newline_pos - 2);
            nums = numbers.substr(newline_pos + 1);
        } 
        else {
            return -1;
        }
    }
    vector<string> tokens;
    size_t start = 0, end;
    bool has_error = false;
    while ((end = nums.find_first_of(delimiters, start)) != string::npos) {
        if (end == start) {
            has_error = true;
            break;
        }
        tokens.push_back(nums.substr(start, end - start));
        start = end + 1;
    }
    if (start < nums.size()) {
        tokens.push_back(nums.substr(start));
    } else if (!tokens.empty() && delimiters.find(nums[start - 1]) != string::npos) {
        has_error = true;
    }
    if (has_error) return -1;
    int sum = 0;
    for (size_t i = 0; i < tokens.size(); ++i) {
        stringstream ss(tokens[i]);
        int number;
        if (!(ss >> number)) {
            return -1; 
        }
        sum += number;
    }
    for (size_t i = 0; i < nums.size(); ++i) {
        if (delimiters.find(nums[i]) == string::npos && !isdigit(nums[i]) && nums[i] != '-' && nums[i] != '+') {
            return -1; 
        }
    }

    return sum;
}

int main() {
    tdd_run_test(1, add("//;\n1;2"), 3);
    tdd_run_test(2, add("1,2\n3"), 6);
    tdd_run_test(3, add("1,2,"), -1);
    tdd_run_test(4, add(""), 0);
    tdd_run_test(5, add("1,2,3"), 6); 
    tdd_run_test(6, add("1"), 1); 
    tdd_run_test(7, add("1\n2\n3"), 6); 
    tdd_run_test(8, add("-1,2,-3"), -2); 
    tdd_run_test(9, add("//|\n1|2,3"), -1); 
    tdd_run_test(10, add("2,\n3"), -1);

    return 0;
}
