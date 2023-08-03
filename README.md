# D'Hondt Simulator for R (dhondt)

This package, `dhondt`, provides an easy-to-use and powerful simulation tool to conduct elections using the D'Hondt method in R.

## Installation

You can install this package directly from GitHub. First, you'll need to install the `devtools` package in R, if you haven't already:


```r

install.packages("devtools")

```

Then, you can use devtools to install the dhondt package:


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

# 'data' - your dataframe that includes the following:
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

The example dataset used in this package, `election_data`, contains election data with various political parties and their corresponding votes in different districts. The columns are as follows:

- `DistrictName`: The name of the electoral district.
- `RefahVote`: The number of votes received by the Refah Party in the respective district.
- `AkpVote`: The number of votes received by the AKP in the respective district.
- `HdpVote`: The number of votes received by the HDP in the respective district.
- `IyipVote`: The number of votes received by the IYIP in the respective district.
- `ZaferVote`: The number of votes received by the Zafer Party in the respective district.
- `ChpVote`: The number of votes received by the CHP in the respective district.
- `MhpVote`: The number of votes received by the MHP in the respective district.
- `TipVote`: The number of votes received by the TIP in the respective district.
- `MemleketVote`: The number of votes received by the Memleket Party in the respective district.
- `BbpVote`: The number of votes received by the BBP in the respective district.
- `NumberofSeats`: The total number of seats available in each district.

You can load this dataset into R using:


```r
# Load the dataset
data("election_data", package = "dhondt")

# Note: Loading data using the data() function will overwrite any existing objects with the same name in the global environment. If you want to avoid potential conflicts, you can load the dataset with a different name like so:

assign("new_dataset_name", get("election_data", envir = data(package = "dhondt")))

# This will load the dataset under the new name new_dataset_name.

# View the first few rows of the data
head(election_data)
```

If you are using the dataset shipped with the package an example usage will be like this:

```r

# In this case, AKP's, MHP's, CHP's, IYIP's, and HDP's vote shares are used to calculate the seat distribution without an electoral threshold. The results aren't saved to the environment.

simulate_election(election_data, "DistrictName", "NumberofSeats", c("AkpVote", "MhpVote", "ChpVote", "IyipVote", "HdpVote"), threshold = 0, assign_to_env = FALSE)
```



## Contributing

Any contributions you make are greatly appreciated.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Contact

**Ali Onur Gitmez**

- Email: alionur [at] gitmez [dot] com
- Project link: https://github.com/onurgitmez/dhondt
