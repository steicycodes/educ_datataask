#-----Set up

plot_data_1 <- merged %>%
  filter(!is.na(dropout)) %>%
  group_by(year, treatment) %>%
  summarize(mean_dropout = mean(dropout) * 100, .groups = 'drop')

# Create the plot
ggplot(plot_data_1, aes(x = factor(year), y = mean_dropout, fill = factor(treatment))) +
  geom_col(position = "dodge", width = 0.6) +
  scale_fill_manual(values = c("0" = "#cfd8dc", "1" = "#1976d2"), 
                    labels = c("Control", "Treatment")) +
  labs(
    title = "Figure 1: Student Dropout Rates by Year",
    subtitle = "Treatment schools maintained lower dropout rates through Year 5",
    x = "Survey Year",
    y = "Dropout Rate (%)",
    fill = "Group"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave(filename = paste0(tabfig_out, "fig1_dropout_time.png"), 
width = 6, height = 4)

# Calculate averages by sex and treatment
plot_data_2 <- merged %>%
  filter(!is.na(dropout), !is.na(sex)) %>%
  mutate(Gender = ifelse(sex == 1, "Male", "Female")) %>%
  group_by(Gender, treatment) %>%
  summarize(mean_dropout = mean(dropout) * 100, .groups = 'drop')

ggplot(plot_data_2, aes(x = Gender, y = mean_dropout, fill = factor(treatment))) +
  geom_col(position = "dodge", width = 0.6) +
  scale_fill_manual(values = c("0" = "#cfd8dc", "1" = "#00954d"), 
                    labels = c("Control", "Treatment")) +
  labs(
    title = "Figure 2: Dropout Rates by Gender and Treatment",
    subtitle = "The gender gap persists despite treatment impact",
    x = "Student Gender",
    y = "Dropout Rate (%)",
    fill = "Group"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave(filename = paste0(tabfig_out, "fig2_dropout_gender.png"), 
width = 6, height = 4)