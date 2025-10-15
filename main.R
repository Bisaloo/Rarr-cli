#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

# simple --key=val parser
options <- args |>
  grepv(pattern = "^--", x = _) |>
  strsplit("=") |>
  do.call(rbind, args = _) |>
  as.data.frame() |>
  setNames(c("arg", "val"))

opt_list <- setNames(options$val, gsub("^--", "", options$arg))

dims <- Rarr::zarr_overview(
  zarr_array_path = opt_list[["array_name"]],
  as_data_frame = TRUE
)$dim[[1]]

# index <- vector("list", length(dims))
# index[[as.integer(opt_list[["dim"]])]] <- seq(
#   as.integer(opt_list[["start"]]),
#   as.integer(opt_list[["stop"]]),
#   by = as.integer(opt_list[["step"]])
# )

res <- Rarr::read_zarr_array(
  zarr_array_path = opt_list[["array_name"]]
)

# writeLines(
#   apply(res, 1, paste, collapse = " ")
# )
