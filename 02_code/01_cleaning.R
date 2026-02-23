# ----- Setup

# Load data in
baseline <- read_csv(paste0(data_raw, "student_baseline.csv"))
schools <- read_csv(paste0(data_raw, "schools.csv"))
visit <- read_csv(paste0(data_raw, "school_visits_log.csv"))
followup <- read_csv(paste0(data_raw, "student_follow_ups.csv"))

# Removing non-valid observations
baseline <- baseline |>
    mutate(yob = ifelse(yob > 1985 & yob < 2000, yob, NA)) |># input missing
    distinct(student_id, .keep_all = TRUE) #remove duplicates

schools <- schools |>
    mutate(av_teacher_age = ifelse(av_teacher_age > 30, av_teacher_age, NA)) |>
    mutate(av_student_score = ifelse(av_student_score > 180, av_student_score, NA)) |>
    mutate(n_latrines = ifelse(n_latrines > 1, n_latrines, NA)) |>
    distinct(school_id, .keep_all = TRUE) #remove duplicates

followup <- followup |>
    mutate(across(c(died, married, pregnant, dropout, children), 
                ~ ifelse(. %in% c(0, 1), ., NA)))|>  # input missing
    distinct(student_id, year, .keep_all = TRUE) #remove duplicates

# Merging!
basefollow <- followup |> # Merging baseline and followup
  left_join(baseline, by = "student_id")

merged <- basefollow |> #merging with school data
    left_join(schools, by = "school_id")

# Saving files
write_csv(merged, paste0(data_clean, "merged.csv"))
write_csv(visit, paste0(data_clean, "visit.csv"))

