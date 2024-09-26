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
#' # The argument threshold = 0.1 represents the national threshold.
#' # The resulting dataframe will be assigned to the variable 'election_results' in the global environment.
#' simulate_election(data, "district", "seats", c("party1", "party2"), threshold = 0.1, assign_to_env = TRUE, env_var_name = "election_results")
#' }
simulate_election <- function(df, district_col, seats_col, parties, threshold = 0) {
  required_columns <- c(district_col, seats_col, parties)
  missing_columns <- setdiff(required_columns, names(df))
  if (length(missing_columns) > 0) {
    stop(paste("The following required columns are missing from the dataframe:",
               paste(missing_columns, collapse = ", ")))
  }
  if (!is.numeric(df[[seats_col]])) {
    stop(paste("The", seats_col, "column must be numeric."))
  }
  if (anyNA(df[[district_col]])) {
    stop("The district column contains NA values.")
  }
  if (anyNA(df[[seats_col]])) {
    warning("The seats column contains NA values.")
  }
  df[[seats_col]] <- as.numeric(df[[seats_col]])
  total_votes_all_parties <- colSums(df[parties], na.rm = TRUE)
  total_votes_in_country <- sum(total_votes_all_parties)
  national_vote_share <- total_votes_all_parties / total_votes_in_country
  eligible_parties <- names(national_vote_share)[national_vote_share > threshold]
  if (length(eligible_parties) == 0) {
    stop(paste("No parties meet the national threshold of", threshold * 100, "%"))
  }
  df_with_seats <- df
  seat_cols <- paste0(eligible_parties, '_seats')
  df_with_seats[seat_cols] <- 0
  districts <- unique(df[[district_col]])
  for (district in districts) {
    district_data <- df_with_seats[df_with_seats[[district_col]] == district, ]
    seats <- district_data[[seats_col]]
    if (is.na(seats) || seats <= 0) {
      next
    }
    votes <- district_data[eligible_parties]
    votes_vector <- as.numeric(votes)
    names(votes_vector) <- eligible_parties
    if (anyNA(votes_vector)) {
      warning(paste("NA values found in votes for district", district, "- skipping this district"))
      next
    }
    seat_allocations <- integer(length(votes_vector))
    names(seat_allocations) <- eligible_parties
    party_votes <- votes_vector
    for (i in seq_len(seats)) {
      current_quotients <- party_votes / (seat_allocations + 1)
      winner <- which.max(current_quotients)
      seat_allocations[winner] <- seat_allocations[winner] + 1
    }
    df_with_seats[df_with_seats[[district_col]] == district, seat_cols] <- as.list(seat_allocations)
  }
  df_with_seats[seat_cols] <- lapply(df_with_seats[seat_cols], as.numeric)
  total_row <- data.frame(matrix(NA, nrow = 1, ncol = ncol(df_with_seats)))
  names(total_row) <- names(df_with_seats)
  total_row[[district_col]] <- "Total"
  total_row[[seats_col]] <- sum(df_with_seats[[seats_col]], na.rm = TRUE)
  total_row[parties] <- colSums(df_with_seats[parties], na.rm = TRUE)
  total_row[seat_cols] <- colSums(df_with_seats[seat_cols], na.rm = TRUE)
  df_with_seats <- rbind(df_with_seats, total_row)
  total_seats <- as.numeric(total_row[seat_cols])
  names(total_seats) <- eligible_parties
  results <- list("totals" = as.list(total_seats), "df_with_seats" = df_with_seats)
  class(results) <- "election_result"
  return(results)
}
