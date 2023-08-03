#' Election Data
#'
#' A dataset containing election data with various political parties and their
#' corresponding votes in different districts.
#'
#' @format A data frame with 12 variables:
#'   \describe{
#'     \item{DistrictName}{The name of the electoral district}
#'     \item{RefahVote}{The number of votes received by the YRP in the respective district.}
#'     \item{AkpVote}{The number of votes received by the AKP in the respective district.}
#'     \item{HdpVote}{The number of votes received by the HHP party in the respective district.}
#'     \item{IyipVote}{The number of votes received by the IYIP in the respective district.}
#'     \item{ZaferVote}{The number of votes received by the ZAFER in the respective district.}
#'     \item{ChpVote}{The number of votes received by the CHP party in the respective district.}
#'     \item{MhpVote}{The number of votes received by the MHP party in the respective district.}
#'     \item{TipVote}{The number of votes received by the TIP party in the respective district.}
#'     \item{MemleketVote}{The number of votes received by the MEMLEKET in the respective district.}
#'     \item{BbpVote}{The number of votes received by the BBP in the respective district.}
#'     \item{NumberofSeats}{The total number of seats available in each district.}
#' }
#'
#' @examples
#' \dontrun{
#' # Load the election data
#' data("election_data")
#' # Explore the dataset
#' head(election_data)
#' }
#' @note Loading data using the `data()` function will overwrite any existing objects with the same name in the global environment. If you want to avoid potential conflicts, you can load the dataset with a different name using the `assign()` function:
#' \dontrun{
#' assign("new_dataset_name", get("election_data", envir = data(package = "dhondt")))
#' }
#' @source Higher Election Council of Turkey
"election_data"
