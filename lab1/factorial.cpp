#include <iostream>
using namespace std;

int factorial(int n){
    return (n > 1) ? n * factorial(n - 1) : 1;
}

int main(){
    int num = 7;
    cout << "factorial of " << num << " is " << factorial(num) << endl;
}