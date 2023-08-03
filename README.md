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


```r 

# Assuming 'data' is your dataframe that includes the following:
# 'district' - the column with electoral district names
# 'seats' - the column with the number of seats available in each district
# 'party1', 'party2' - columns with the number of votes each party received in each district

# The 'threshold' argument specifies the national threshold required for a party to be eligible for seats. 
# The resulting dataframe can optionally be assigned to a global environment variable, 'election_results'.


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

## Example Dataset

The example dataset used in this package contains election data with various political parties and their corresponding votes in different districts. The columns are as follows:

- `DistrictName`: The name of the electoral district.
- `RefahVote`, `AkpVote`, `HdpVote`, `IyipVote`, `ZaferVote`, `ChpVote`, `MhpVote`, `TipVote`, `MemleketVote`, `BbpVote`: The number of votes received by each political party in the respective district.
- `NumberofSeats`: The total number of seats available in each district.

You can find this dataset in the `data` folder of this repository as `example_election_data.xlsx`. You can use this dataset to test the functionality of the `dhondt` package. Here's how you can load this data into R:

```r
# Install the readxl package if you haven't already
install.packages("readxl")

# Load the readxl package
library(readxl)

# Read the example dataset
data <- read_excel("./data/example_election_data.xlsx")

# View the first few rows of the data
head(data)

```

## Contributing

Any contributions you make are greatly appreciated.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Contact

**Ali Onur Gitmez**

- Email: alionur [at] gitmez [dot] com
- Project link: https://github.com/onurgitmez/dhondt
