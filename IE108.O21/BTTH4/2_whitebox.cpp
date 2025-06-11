#include <iostream>
#include <vector>
using namespace std;

void manageInventory(int inventory, const vector<int> &orders, int threshold) {
  for (size_t i = 0; i < orders.size(); ++i) {
    if (inventory >= orders[i]) {
      inventory -= orders[i];
      cout << "Processed order " << i + 1 << "; " << inventory << " left."
           << endl;
    } else {
      cout << "Order " << i + 1 << " failed: insufficient inventory." << endl;
      break;
    }
  }
  if (inventory == 0) {
    cout << "Inventory depleted." << endl;
  } else if (inventory <= threshold) {
    cout << "Low inventory: " << inventory << " left." << endl;
  } else {
    cout << "Inventory sufficient: " << inventory << " left." << endl;
  }
}

int main() {
  // Replace the folowing values with your actual MSSV values
  vector<int> orders = {1, 2, 3, 4, 5, 6, 7, 8};
  int inventory = 26;
  int threshold = 9;

  manageInventory(inventory, orders, threshold);

  return 0;
}
