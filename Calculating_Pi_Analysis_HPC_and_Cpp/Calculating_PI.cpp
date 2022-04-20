#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <vector>
#include <sys/time.h>

using namespace std;

int main (){
  srand (time(NULL));
  int size = 100000;
  double size_in_double = 100000;
  double sumnum = 0;
  int count = 0;
  struct timeval start, end;
  float delta;

  vector<double> xvalues(size);
  vector<double> yvalues(size);

  for (int i = 0; i < size; i++) { // step 1: assigns random value to each e\
lement
    xvalues[i] = double(rand())/double(RAND_MAX);
    yvalues[i] = double(rand())/double(RAND_MAX);
  }
  // gettimeofday(&start, NULL);

  vector<double> xvalues_squared(size);
  vector<double> yvalues_squared(size);

  for (int i = 0; i < size; i++) { // squares each element
    xvalues_squared[i] = xvalues[i] * xvalues[i];
    yvalues_squared[i] = yvalues[i] * yvalues[i];
  }

  vector<double> added_values(size);

  for (int i = 0; i < size; i++) { // add x and y
    added_values[i] = xvalues_squared[i] +  yvalues_squared[i];
  }


  for (int i = 0; i < size; i++) { // sums all values <= 1
    if (added_values[i] <= 1) {
      sumnum += 1;
    }
  }
  //cout << sumnum << endl;

  double final_value = (4*sumnum) /size_in_double;

  //cout << final_value << endl;

  gettimeofday(&end, NULL);
  delta = ((end.tv_sec-start.tv_sec)*1000000u + end.tv_usec-start.tv_usec)/\
    1.e6;
  double memorie = (64*8*size)/(1024*1024);
  cout << "Precision: Double"  << endl;
  cout << "Sample Size: 10000" << endl;
  cout << "Total Memory footprint (MB): " << memorie << "MB"  << endl;
  cout << "Total Memory footprint (GB): " <<  memorie/1025 << " GB" << endl;
  cout << " " << endl;
  cout << "Pi: " << final_value << endl;
  cout << "time: " << delta << endl;

  return 0;
}
