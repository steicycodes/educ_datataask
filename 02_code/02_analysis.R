#------- Analysis and visualizations

#-- Balance check
vars <- c("location", 
          "n_teachers", 
          "av_student_score", 
          "n_latrines", 
          "n_students_fem")

balance_results <- map_dfr(vars, function(v) {
  
  model <- feols(as.formula(paste0(v, " ~ treatment")), 
                 data = schools)
  
  tibble(
    variable = v,
    control_mean = mean(schools[[v]][schools$treatment == 0], na.rm = TRUE),
    treatment_mean = mean(schools[[v]][schools$treatment == 1], na.rm = TRUE),
    diff = coef(model)["treatment"],
    se = se(model)["treatment"],
    p_value = pvalue(model)["treatment"]
  )
})

balance_results %>%
  mutate(
    variable = case_when(
      variable == "location" ~ "Urban Location",
      variable == "n_teachers" ~ "Number of Teachers",
      variable == "av_student_score" ~ "Average Baseline Score",
      variable == "n_latrines" ~ "Number of School Latrines",
      variable == "n_students_fem" ~ "Number of Female Students",
      TRUE ~ variable
    ),
    diff = paste0(
      sprintf("%.3f", diff),
      ifelse(p_value < 0.01, "***",
             ifelse(p_value < 0.05, "**",
                    ifelse(p_value < 0.10, "*", "")))
    ),
    # Optional: wrapping SE in parentheses
    se = paste0("(", sprintf("%.3f", se), ")")
  ) %>%
  arrange(variable) %>%
  gt() %>%
  cols_label(
    variable = "Characteristic",
    control_mean = "Control Mean",
    treatment_mean = "Treatment Mean",
    diff = "Difference",
    se = "Std. Error",
    p_value = "p-value"
  ) %>%
  fmt_number(
    columns = c(control_mean, treatment_mean, p_value),
    decimals = 3
  ) %>%
  cols_align(
    align = "center",
    columns = -variable
  ) %>%
  tab_header(
    title = md("**Table 1: Baseline Balance**"),
    subtitle = "School-Level Characteristics"
  ) %>%
  tab_source_note(
    source_note = md("*Note: Standard errors in parentheses. Significance levels: * p < 0.10, ** p < 0.05, *** p < 0.01*")
  ) %>%
  gtsave(filename = paste0(tabfig_out, "table1_balance.tex"))

#-- Main analysis

m1 <-feols(dropout ~ treatment | year + stratum, 
data = merged, cluster = ~student_id)

#Control
m2 <- feols(dropout ~ treatment + sex | year + stratum, 
                  data = merged, cluster = ~student_id)

# Heterogeniety
m3 <- feols(dropout ~ treatment*sex | year + stratum, 
                  data = merged, cluster = ~student_id)

# putting this all together 
modelsummary(
  list("Base ITT" = m1, "Controlled ITT" = m2, "Heterogeneity" = m3),
  stars = TRUE,
  gof_omit = "AIC|BIC|Log|RMSE",
  title = "Table 2: Impact of Intervention on Student Dropout",
  output = paste0(tabfig_out, "table2_results.tex") # Save directly to output
)
# Pregnancy
m4 <- feols(pregnant ~ treatment | year + stratum,
    data = filter(merged, sex == 2), 
    cluster = ~student_id 
)
# Marriage 
m5 <- feols(married ~ treatment + sex | year + stratum, 
            data = merged, 
            cluster = ~student_id)

# Putting these together
modelsummary(
  list(
    "Dropout (All)" = m2, 
    "Married (All)" = m5, 
    "Pregnant (Women Only)" = m4
  ),
  stars = TRUE,
  gof_omit = "AIC|BIC|Log|RMSE",
  title = "Table 3: Impact on Secondary Life Outcomes",
  output = paste0(tabfig_out, "table3_secondary.tex")
)
