#Project: What Predicts Early Career Salary?
#Dataset: 2022-2023 College Scorecard

setwd("~/Downloads/DS/CollegeScorecardData")

#required libraries.
install.packages("stringr")

library(stringr)
library(tidyverse)
library(readr)
library(ggplot2)

#load datasets.
institutes = read.csv("InstitutionalData_2022-2023.csv")
field_of_study = read.csv("FieldOfStudyData_2022-2023.csv")

#before i clean, i need useful variables.
colnames(institutes)
colnames(field_of_study)

#clean instituional data.
institutes = institutes |>
  rename(
    institution_id = UNITID,
    school = INSTNM,
    admission_rate = ADM_RATE,
    sat_avg = SAT_AVG,
    school_type = CONTROL, 
    tuition = TUITIONFEE_IN
) |>
  select(
    institution_id, school, admission_rate, sat_avg, school_type, tuition
  ) |>
  drop_na()

#clean field of study data.
field_of_study = field_of_study |>
  rename(
    institution_id = UNITID,
    major = CIPDESC,
    earnings = EARN_MDN_4YR
  ) |>
  select(
    institution_id, major, earnings
  ) |>
  drop_na()

#merge the datasets.
df = institutes |>
  inner_join(field_of_study, by = "institution_id")

#create major group categories, since major contains many detailed study names
#STEM: Engineering, CS, Math, Physics. Business: Finance, Accounting, Marketing. 
#Health: Bio, Nursing, Medicine. Humanities: History, English, Philosophy, Arts
#Social sciences and public service: Political, Government, Public Policy, Social Work
#Other: Any majors not listed above.

df = df |>
  mutate(
    major_group = case_when(
      str_detect(major, "Engineering|Computer|Math|Physics") ~ "STEM",
      str_detect(major, "Business|Finance|Accounting|Marketing") ~ "Business",
      str_detect(major, "Biology|Health|Nursing|Medicine") ~"Health",
      str_detect(major, "History|English|Philosophy|Art|Music|Humanities") ~ "Humanities",
      str_detect(major, "Political|Government|Public Policy|Social Work") ~ "Social Science & Public Service",
      TRUE ~ "Other" 
    )
  )

#clean the earnings data.
df = df |>
  mutate(
    earnings = as.numeric(earnings)  
  ) |>
  filter(
    !is.na(earnings),
    earnings > 0,
    !is.na(major_group),
    !is.na(sat_avg)
  )

df = df|>
  filter(earnings < 200000)

#visualize earnings by major category.
#do certain majors lead to higher salaries than others?
earnings_by_major = ggplot(df, aes(x = reorder(major_group, earnings, median), y = earnings, fill = major_group)) +
  geom_boxplot(alpha = 0.7, outlier.alpha = 0.2) +
  labs(
    title = "Early-Career Earnings by Major Category",
    x = "Major Category",
    y = "Median Earnings"
  ) + 
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    legend.position = "none",
    plot.title = element_text(size = 16, face = "bold"),
    axis.text.x = element_text(angle = 20, hjust = 1)
  )
ggsave("earnings_by_major.png", width = 8, height = 5)

#visualize relationship between sat(school selectivity) vs earnings.
#do more selective schools lead to higher earnings?
earnings_by_sat_range = ggplot(df, aes(
  x = cut(
    sat_avg,
    breaks = seq(800, 1600, by = 100),
    labels = paste(seq(800, 1500, by = 100), "–", seq(900, 1600, by = 100))
  ),
  y = earnings,
  fill = after_stat(y)
)) +
  stat_summary(fun = mean, geom = "col", width = 0.8) +
  scale_fill_gradient(low = "#E3F2FD", high = "#1565C0", labels = scales::dollar) +
  labs(
    title = "Average Earnings by SAT Score Range",
    x = "SAT Score Range",
    y = "Average Earnings",
    fill = "Earnings"
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1)
)
ggsave("earnings_by_sat_range.png", width = 8, height = 5)

#visualize earnings by SAT and major category
earnings_sat_major = ggplot(df, aes(x = sat_avg, y = earnings, color = major_group)) +
  geom_point(alpha = 0.15, size = 0.7) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 1.3) +
  scale_color_brewer(palette = "Set2") +
  labs(
    title = "Earnings vs SAT Scores by Major Category",
    subtitle = "Correlation between SAT scores and earnings varies across majors",
    x = "Average SAT Score",
    y = "Median Earnings",
    color = "Major Category"
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12),
    legend.position = "right"
  )
ggsave("earnings_sat_major.png", width = 8, height = 5)

#this table summarize key variables used in the analysis. 
#we calculate mean, median, standard deviation, minimun, and maximum for earnings
#and SAT scores across major categories.
summary_table = df |>
  group_by(major_group) |>
  summarise(
    mean_earnings = mean(earnings, na.rm = TRUE),
    median_earnings = median(earnings, na.rm = TRUE),
    sd_earnings = sd(earnings, na.rm = TRUE),
    min_earnings = min(earnings, na.rm = TRUE),
    max_earnings = max(earnings, na.rm = TRUE),
    
    mean_sat = mean(sat_avg, na.rm = TRUE),
    median_sat = median(sat_avg, na.rm = TRUE),
    sd_sat = sd(sat_avg, na.rm = TRUE)
  )

write.csv(summary_table, "summary_statistics_by_major.csv", row.names = FALSE)




































    
    
    
