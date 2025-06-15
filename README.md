# 🦠 COVID-19 Mortality Analysis

### Analyzing the Impact of Age and Gender on COVID-19 Mortality Rates Using Statistical Methods and Shiny Dashboards

---

## Overview

This project investigates the relationship between **age**, **gender**, and **COVID-19 mortality rates** using statistical analysis and data visualization techniques. An interactive **Shiny dashboard** enables dynamic exploration of demographic trends and survival outcomes, providing valuable insights for public health strategies and epidemiological studies.

---

## Key Features

- **Data Cleaning & Preprocessing**
  - Handling missing values
  - Categorical encoding
  - Feature engineering (age groups, date conversion)

- **Statistical Analysis**
  - T-tests to compare gender-based mortality age distributions
  - Cox Proportional Hazards model for survival analysis

- **Data Visualization**
  - Bar charts, pie charts, and density plots
  - Kaplan-Meier survival curves

- **Shiny Dashboard**
  - Interactive visualizations and filters for user-driven analysis

---

## Project Structure

```
covid19-mortality-analysis/
│
├── app.R                   # Shiny application entry point
├── data/                   # Raw and preprocessed dataset files
├── scripts/                # Data cleaning and statistical analysis scripts
├── plots/                  # Exported visualizations
├── README.md               # Project documentation
└── LICENSE                 # MIT License
```

---

## How to Run the Project

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/covid19-mortality-analysis.git
cd covid19-mortality-analysis
```

### 2. Install Required Packages

Ensure you have **R** installed. Then install the necessary dependencies:

```r
install.packages(c("shiny", "ggplot2", "dplyr", "survival", "survminer", "shinycssloaders"))
```

### 3. Launch the Shiny App

```r
Rscript app.R
```

This will open a browser window with the interactive COVID-19 mortality dashboard.

---

## Methodology

### 1. Data Preprocessing

- Imputed missing `age` values using the column mean.
- Re-coded missing `gender` entries as `"Unknown"`.
- Converted `reporting_date` to `Date` format.
- Derived categorical **age groups** for stratified analysis.

### 2. Statistical Analysis

- **T-Test**: Evaluated whether the mean age of deceased individuals differs between genders.
- **Cox Proportional Hazards Model**: Assessed the impact of age and gender on mortality risk.

### 3. Data Visualization

- **Bar Charts**: Show mortality distribution across age groups and gender.
- **Pie Charts**: Display gender and age group composition.
- **Density Plots**: Visualize age distribution by gender.
- **Kaplan-Meier Survival Curves**: Estimate survival probabilities over time.

---

## Dataset

The dataset comprises demographic and clinical attributes of confirmed COVID-19 cases.

- **Source**: *[Insert dataset link if publicly available]*
- **Key Variables**:
  - `age`: Patient age (numeric)
  - `gender`: Gender category (`Male`, `Female`, `Unknown`)
  - `death`: Mortality outcome (`1` = deceased, `0` = survived)
  - `reporting_date`: Date of case reporting

---

## Results and Insights

- **Age is the strongest predictor** of COVID-19 mortality risk. Mortality is significantly higher in individuals aged **61+**, while those under 20 experienced minimal risk.
- **Males exhibited a higher mortality rate** than females, consistent with broader global patterns. However, the gender effect was weaker than that of age.
- **Survival analysis (Cox regression and Kaplan-Meier curves)** reinforces that both age and gender influence survival probability, with age having a more substantial statistical impact.

---

## Technologies Used

- **Language**: R
- **Libraries**:
  - `shiny` – Interactive dashboard development
  - `ggplot2`, `dplyr` – Visualization and data manipulation
  - `survival`, `survminer` – Survival analysis
  - `shinycssloaders` – UI enhancements

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for full details.

---

## Contact

For questions, collaboration, or contributions:

- **Email**: siddhwagawad@gmail.com
- **GitHub**: [https://github.com/thesiddheshh](https://github.com/thesiddheshh)

