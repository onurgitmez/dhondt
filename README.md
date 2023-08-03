# D'Hondt Simulator for R (dhondt)

This package, `dhondt`, provides an easy-to-use and powerful simulation tool to conduct elections using the D'Hondt method in R.

## Installation

You can install this package directly from GitHub with the `devtools` package in R:

```r

devtools::install_github("onurgitmez/dhondt")

```

## Usage

Load the `dhondt` package:

```r

library(dhondt)

```

## Simulate an election:

 ### Assuming 'data' is your dataframe, 'district' is your district column,
 
###  'seats' is your seats column, and 'party1', 'party2' are your party columns.

### The argument threshold = 0.1 represents the national threshold.

### The resulting dataframe can optionally be assigned to a variable 'election_results' in the global environment.

```r 

election_results <- simulate_election(data, "district", "seats", c("party1", "party2"), threshold = 0.1, assign_to_env = TRUE, env_var_name = "election_results")

```

## Functions

The `dhondt` package currently has one main function, `simulate_election`.

### simulate_election()

**This function simulates an election using the D'Hondt method.**

**Usage:**

```r

simulate_election(df, district_col, seats_col, parties, threshold = 0, assign_to_env = FALSE, env_var_name = "df_with_seats")

```

**Arguments:**

- `df`: A dataframe containing the election data. It must have a column for each party, with the number of votes that party received in each district. It also must have a column for district names and a column for the number of seats in each district.
- `district_col`: The name of the column in df that contains the district names.
- `seats_col`: The name of the column in df that contains the number of seats in each district.
- `parties`: A vector of strings, each one the name of a column in df that contains the votes for a party.
- `threshold`: The minimum vote share a party needs to be eligible for seats. Default is 0.
- `assign_to_env`: Logical, whether to assign the resulting dataframe to a variable in the global environment. Default is FALSE.
- `env_var_name`: The name of the variable in the global environment to which the resulting dataframe will be assigned, if assign_to_env is TRUE.

**Value:**

A list where the first item is a named vector with the total seats for each party, and the second item is the dataframe with the number of seats each party won in each district (including a total row), optionally assigned to a variable in the global environment.

## Features

- Simulates an election using the D'Hondt method.
- Computes the number of seats each party won in the election, given a dataframe with election data and parameters.
- The resulting dataframe can optionally be assigned to a variable in the global environment.

## Contributing

Any contributions you make are greatly appreciated.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Contact

**Ali Onur Gitmez**

- Project link: https://github.com/onurgitmez/dhondt
