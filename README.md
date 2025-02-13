# 🦠 COVID-19 Mortality Analysis  

### 📊 Analyzing the Impact of Age and Gender on COVID-19 Mortality Rates  

## 📌 Overview  
This project explores the relationship between **age, gender, and COVID-19 mortality rates** using **statistical analysis and data visualization**. By leveraging **Shiny for interactive dashboards**, this study aims to provide insights that can aid in **pandemic response strategies**.  

## 🎯 Key Features  
✅ **Data Cleaning & Preprocessing** (Handling missing values, categorical encoding)  
✅ **Statistical Analysis** (T-tests, Cox Regression for survival analysis)  
✅ **Data Visualization** (Bar charts, Pie charts, Density plots, Kaplan-Meier survival curves)  
✅ **Shiny Interactive Dashboard** (Allows users to explore the data dynamically)  




## 🚀 How to Run the Project  
### **🔹 1. Clone the Repository**  
Open a terminal and run:  
```bash
git clone https://github.com/YOUR_USERNAME/covid19-mortality-analysis.git
cd covid19-mortality-analysis
```

### **🔹 2. Install Dependencies**  
Make sure you have **R** installed. Then install the required packages:  
```r
install.packages(c("shiny", "ggplot2", "dplyr", "survival", "survminer", "shinycssloaders"))
```

### **🔹 3. Run the Shiny App**  
```r
Rscript app.R
```
The application will open in your browser, displaying interactive visualizations.


## 📊 Methodology  
### **1️⃣ Data Preprocessing**  
- Replaced missing values in the **age** column with the mean age.  
- Coded missing **gender** values as `"Unknown"`.  
- Converted **reporting_date** to Date format.  
- Created **age groups** (`0-20`, `21-40`, etc.) for better analysis.  

### **2️⃣ Statistical Analysis**  
✔ **T-test**: Compares the mean ages of deceased males and females.  
✔ **Cox Regression**: Evaluates the impact of age and gender on mortality risk.  

### **3️⃣ Data Visualization**  
📊 **Bar Charts** → Show mortality rates by age group and gender.  
📊 **Pie Charts** → Visual representation of age & gender distributions.  
📊 **Density Plots** → Age distributions compared across genders.  
📊 **Kaplan-Meier Survival Curves** → Gender-based survival probability over time.  

---

## 📚 Dataset Information  
The dataset includes demographic and clinical details of COVID-19 cases.  
🔗 **Source**: [Include a dataset link here if available]  

**Key Variables:**  
- `age`: Numeric (Years)  
- `gender`: Categorical (Male, Female, Unknown)  
- `death`: Binary (1 = Yes, 0 = No)  

---

## 🔥 Results & Insights  
📌 **Mortality Risk Increases with Age**  
- Individuals **61+ years old** had the **highest** mortality rate.  
- The **0-20 age group** had the **lowest** risk of death.  

📌 **Gender-Based Differences Exist**  
- **Males had a higher mortality rate** than females, aligning with global studies.  
- Further research is needed to examine underlying health conditions.  

📌 **Cox Regression Findings**  
- **Age is a significant predictor** of mortality risk.  
- **Gender also plays a role**, though less significant than age.  

---

## 🛠️ Technologies Used  
- **Programming Language**: R  
- **Libraries**: `shiny`, `ggplot2`, `dplyr`, `survival`, `survminer`, `shinycssloaders`  
- **Framework**: Shiny (for interactive visualizations)  

---

## 📜 License  
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.  

---

## 📬 Contact & Contributions  
📩 If you have any questions or suggestions, feel free to contact me via:  
📧 **Email**: [siddhwagawad@gmail.com]  
🌐 **GitHub**: [github.com/YOUR_USERNAME](https://github.com/thesiddheshh)  

---

