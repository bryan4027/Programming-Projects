# Pandemic Simulation

The purpose of this project is to generate a code that simulates a pandemic. It requests how big the population is, how contagious the population is, how many people are infected, and how many people dont social distance. Then, it shows how many days it takes for the disease to dissepate. The coolest part about it is seeing how fast or how slow the disease spreads.


<details>
  <summary>Show C++ code </summary>

```cpp:

#include <iostream>
#include <string>
#include <memory>
#include <stdio.h>
#include <stdlib.h>
#include <ctime>
#include <vector>
#include <math.h>
#include <iomanip>
using namespace std;

class person {
    protected: // members
    int state;
    string status;
    public: // methods
    person() { int state = 0 ;};
    string status_string() {
        if (state == 0) {
            status = ("susceptible");
        }
        if (state > 0) {
            status = ("sick");
        }
        if (state == -1) {
            status = ("recovered");
        }
        if (state  == -2) {
            status = ("vaccinated");
        }
        return status;
    }
    void update() {
            if (state == 1 ) {
                state =-1;
            } else 
            if (state > 0) {
                state = state -1 ; 
            } else {}

        }
    void infect(int n) {
            if (state==0)
            state = n;
            }
    bool is_stable() {
            if (state ==-1) {
                return true;
            } else {
                return false;
            }
        }
    void set_vaccinated() { 
        state = -2;
    }
    bool is_infected() {
         if (state >0) {
                return true;
            } else {
                return false;
            }
    }
    bool is_vaccinated() {
         if (state ==-2) {
                return true;
            } else {
                return false;
            }
    }
    bool is_succectible() {
         if (state ==0) {
                return true;
            } else {
                return false;
            }
    }
};
class population {
    private:
    double random_person,prob,vaccinated,random_vaccinated,contact;
    
    int counted = 0;
    vector <person> populationn;
    public:
    population(int ppl) { 
        populationn = vector<person>(ppl); 
    };
    // int npeople inside ()
    void random_infection() {
        int randomindex = ( rand() * 100 ) ;
        randomindex = floor(randomindex % populationn.size()) ;
        populationn.at(randomindex).infect(5);
    }

    int count_infected() {
		int total = 0;
		for (auto& x : populationn) {
			if (x.is_infected()) {
				total++;
			}
		}
		return total;
	}
	int count_vaccinated() {
		int count = 0;
		for (auto& x : populationn) {
			if (x.is_vaccinated()) {
				count++;
				
			}
		}
		return count;
	}
    void update2() {
            for (int i = 0; i < populationn.size(); i++) {
                populationn.at(i).update();
            }
            for (int i = 0; i < contact * count_infected(); i++) {
			float luck = (float)rand() / (float)RAND_MAX;
			if (luck <= prob) {
				double bad_luck = rand() % populationn.size();
				int position = floor(bad_luck);
				populationn.at(position).infect(5);
				
			}
        }
        }
    void printme() {
        for (int i = 0; i< populationn.size(); i++ ) { 
            if (populationn.at(i).is_stable()) {
                cout << " -" ;
            } else if (populationn.at(i).is_succectible()) { 
                cout << " ?" ;
            } else if (populationn.at(i).is_infected()) { 
                cout << " +" ;
            } else if (populationn.at(i).is_vaccinated())
                {
                     cout << " v";
                     }
            }
    }
    void contagion() {
        float bad_luck;
        int j = 1;
        for (int i = 0; i < populationn.size(); i++) {
            if (populationn.at(i).is_infected()&& j == 1) {
                bad_luck = (rand() % 100)*0.01;
                if (bad_luck<=prob && i != 0) {
                    populationn.at(i-1).infect(5);
                }
                bad_luck = (rand() % 100)*0.01;
                if (bad_luck<=prob && i != (populationn.size()-1)) {
                    if (populationn.at(i+1).is_succectible()) {
                        j = 0;
                    } else { j=1;}
                    populationn.at(i+1).infect(5);\
                    
                    
                    
                }
        }
    }
    }
    void give_vaccine() {
        while (0 < 1) {
			    int ppl_vaccinated = populationn.size()*vaccinated;
				if (count_vaccinated() == ppl_vaccinated) {
					break;
				}
				double bad_luck = rand() % populationn.size();
				int position = floor(bad_luck);
					
				if (!populationn.at(position).is_infected()) {
					populationn.at(position).set_vaccinated();
				}
						
        }
    }
    void set_probability_of_transfer(double probability) {
        prob = probability;
    }
    void set_vaccinated_people(double amount) {
        vaccinated = amount;
    }
    void contact_create(int num) {
        contact = num;
    }
    };
int main() {
    srand(time(NULL));
    int inppl, contactnum;
    double vaccine,probability;
    cout << "how many ppl" << endl;
        cin >> inppl;
    population populationyuh(inppl);
    int step = 1;
    populationyuh.random_infection();
    cout << "probability of contagion?" << endl;
        cin >> probability;
    populationyuh.set_probability_of_transfer(probability);
    cout << "percent vaccinated in decimal form" << endl;
        cin >> vaccine;
    populationyuh.set_vaccinated_people(vaccine);
    populationyuh.give_vaccine();
    cout << "contact" << endl;
    cin >> contactnum;
    populationyuh.contact_create(contactnum);
    for ( ; ; step++) {   
            cout << "current population at day" << step << " ";
        populationyuh.printme();
        cout << endl;
        populationyuh.contagion();
        populationyuh.update2();
        if (populationyuh.count_infected() == 0) {
            break;
    }
    }    
return 0;
}   
```
</details>






