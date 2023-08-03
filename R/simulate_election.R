#' Simulate an Election Using the D'Hondt Method
#'
#' This function simulates an election using the D'Hondt method. Given a dataframe
#' containing election data, the names of the columns containing district names,
#' number of seats in each district, the votes for each party, and a threshold,
#' it computes the number of seats each party won in the election.
#'
#' @param df Dataframe containing the election data. It must have a column for each party,
#' with the number of votes that party received in each district. It also must have a column
#' for district names and a column for the number of seats in each district.
#' @param district_col The name of the column in df that contains the district names
#' @param seats_col The name of the column in df that contains the number of seats in each district
#' @param parties A vector of strings, each one the name of a column in df that contains the votes for a party
#' @param threshold The minimum vote share a party needs to be eligible for seats. Default is 0.
#'
#' @return A list where each item is the name of a party and its corresponding number of seats
#' @export
#' @importFrom stats setNames

#'
#' @examples
#' \dontrun{
#' # Assuming 'data' is your dataframe, 'district' is your district column,
#' # 'seats' is your seats column, and 'party1', 'party2' are your party columns
#' # The last argument 0.1 represents the national threshold.
#' simulate_election(data, "district", "seats", c("party1", "party2"), 0.1)
#' }
simulate_election <- function(df, district_col, seats_col, parties, threshold = 0) {
  total_votes <- colSums(df[parties], na.rm = TRUE)
  vote_share <- total_votes / sum(total_votes)

  eligible_parties <- names(vote_share)[vote_share >= threshold]

  for (district in unique(df[[district_col]])) {
    district_data <- df[df[[district_col]] == district,]

    votes <- district_data[eligible_parties]
    seats <- district_data[[seats_col]]

    if (is.na(seats) || seats <= 0) {
      next
    }

    parties <- names(votes)
    results <- setNames(rep(0, length(parties)), parties)

    for (i in 1:seats) {
      max_votes <- 0
      winner <- ''
      for (party in parties) {
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

    seat_winners <- as.data.frame(t(results))
    seat_winners$district <- district
    df[df[[district_col]] == district, paste0(eligible_parties, '_seats')] <- as.list(seat_winners[,eligible_parties])
  }

  df[, paste0(eligible_parties, '_seats')] <- apply(df[, paste0(eligible_parties, '_seats')], 2, as.numeric)

  total_seats <- colSums(df[, paste0(eligible_parties, '_seats')], na.rm = TRUE)

  results <- list()
  for (party in eligible_parties) {
    results[[party]] <- total_seats[[paste0(party, '_seats')]]
  }

  return(results)
}
