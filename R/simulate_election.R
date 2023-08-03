#' Simulate an Election Using the D'Hondt Method
#'
#' This function simulates an election using the D'Hondt method. Given a dataframe
#' containing election data, the names of the columns containing district names,
#' number of seats in each district, the votes for each party, and a threshold,
#' it computes the number of seats each party won in the election. The resulting dataframe
#' can optionally be assigned to a variable in the global environment.
#'
#' @param df Dataframe containing the election data. It must have a column for each party,
#' with the number of votes that party received in each district. It also must have a column
#' for district names and a column for the number of seats in each district.
#' @param district_col The name of the column in df that contains the district names.
#' @param seats_col The name of the column in df that contains the number of seats in each district.
#' @param parties A vector of strings, each one the name of a column in df that contains the votes for a party.
#' @param threshold The minimum vote share a party needs to be eligible for seats. Default is 0.
#' @param assign_to_env Logical, whether to assign the resulting dataframe to a variable in the global environment. Default is FALSE.
#' @param env_var_name The name of the variable in the global environment to which the resulting dataframe will be assigned, if assign_to_env is TRUE.
#'
#' @return A list where the first item is a named vector with the total seats for each party, and the second item is the dataframe
#' with the number of seats each party won in each district (including a total row), optionally assigned to a variable in the global environment.
#' @export
#' @importFrom stats setNames
#'
#' @examples
#' \dontrun{
#' # Assuming 'data' is your dataframe, 'district' is your district column,
#' # 'seats' is your seats column, and 'party1', 'party2' are your party columns.
#' # The last argument 0.1 represents the national threshold.
#' # The resulting dataframe will be assigned to the variable 'election_results' in the global environment.
#' simulate_election(data, "district", "seats", c("party1", "party2"), 0.1, assign_to_env = TRUE, env_var_name = "election_results")
#' }
simulate_election <- function(df, district_col, seats_col, parties, threshold = 0, assign_to_env = FALSE, env_var_name = "df_with_seats") {
  total_votes <- colSums(df[parties], na.rm = TRUE)
  vote_share <- total_votes / sum(total_votes)

  eligible_parties <- names(vote_share)[vote_share >= threshold]

  df_with_seats <- df
  df_with_seats[, paste0(parties, '_seats')] <- 0

  for (district in unique(df[[district_col]])) {
    district_data <- df[df[[district_col]] == district,]

    votes <- district_data[eligible_parties]
    seats <- district_data[[seats_col]]

    if (is.na(seats) || seats <= 0) {
      next
    }

    parties_eligible <- names(votes)
    results <- setNames(rep(0, length(parties_eligible)), parties_eligible)

    for (i in 1:seats) {
      max_votes <- 0
      winner <- ''
      for (party in parties_eligible) {
        party_votes <- votes[[party]]
        party_seats <- results[names(results) == party]
        quotient <- party_votes / (party_seats + 1)
        if (quotient > max_votes) {
          max_votes <- quotient
          winner <- party
        }
      }
      results[[winner]] <- results[[winner]] + 1
    }

    df_with_seats[df_with_seats[[district_col]] == district, paste0(eligible_parties, '_seats')] <- as.list(results)
  }

  df_with_seats[, paste0(eligible_parties, '_seats')] <- apply(df_with_seats[, paste0(eligible_parties, '_seats')], 2, as.numeric)

  total_row <- setNames(rep(NA, ncol(df_with_seats)), names(df_with_seats))
  total_row[district_col] <- "Total"
  total_row[seats_col] <- sum(df_with_seats[[seats_col]])
  total_row[parties] <- colSums(df_with_seats[parties], na.rm = TRUE)
  total_row[paste0(parties, '_seats')] <- colSums(df_with_seats[, paste0(parties, '_seats')], na.rm = TRUE)

  df_with_seats <- rbind(df_with_seats, total_row)

  total_seats <- total_row[paste0(parties, '_seats')]

  results <- list()
  for (party in parties) {
    results[[party]] <- total_seats[[paste0(party, '_seats')]]
  }

  # Assign the df_with_seats dataframe to a variable in the global environment if desired
  if (assign_to_env) {
    assign(env_var_name, df_with_seats, envir = .GlobalEnv)
  }

  return(list("totals" = results, "df_with_seats" = df_with_seats))
}

