# Supply Chain & Delivery Operations Analysis

An end-to-end data analytics project investigating supply chain delivery performance, product profitability, discount patterns, and operational trends using Python and MySQL.

## Project Overview

This project explores historical supply chain and order data to identify operational risks and potential profitability issues. It combines data cleaning, exploratory data analysis, SQL-based business analysis, and Python visualizations to turn raw data into actionable business insights.

## Business Objectives

- Evaluate late-delivery risk across shipping modes.
- Identify products and categories requiring profitability investigation.
- Examine the relationship between discount levels and profit.
- Track monthly sales and profit trends.
- Compare sales and profitability across markets and customer segments.
- Develop data-driven recommendations for operational improvement.

## Tools and Technologies

- **Python:** Data analysis and preprocessing
- **Pandas and NumPy:** Data manipulation and numerical analysis
- **Matplotlib and Seaborn:** Data visualization
- **MySQL:** Business queries and aggregation
- **Jupyter Notebook:** Exploratory analysis and documentation
- **Git and GitHub:** Version control and project sharing

## Project Structure

```text
ecommerce-delivery-operations-analysis/
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── notebooks/
│   ├── 01_Data_Inspection.ipynb
│   ├── 02_Data_Cleaning.ipynb
│   ├── 03_EDA.ipynb
│   └── 04_Business_Insights.ipynb
│
├── sql/
│   └── supply_chain_analysis.sql
│
├── visualizations/
│   ├── 01_shipping_mode_risk.png
│   ├── 02_monthly_sales_profit.png
│   ├── 03_category_profitability.png
│   ├── 04_discount_vs_profit.png
│   └── 05_loss_making_products.png
│
├── reports/
│   └── business_recommendations.md
│
├── requirements.txt
├── .gitignore
└── README.md
```

## Dataset

The project uses the DataCo Smart Supply Chain dataset, containing order, product, sales, profit, shipping, and customer-related information.

The original dataset contains approximately 180,519 records and 53 columns.

The data was inspected and cleaned before analysis. Unnecessary identifying fields were removed from the cleaned analytical dataset where appropriate.

**Privacy note:** Before publishing the dataset, verify its redistribution terms and confirm that no unnecessary personal or identifying information is included.

## Project Workflow

### 1. Data Inspection

- Reviewed dataset dimensions and column types.
- Checked missing values and duplicate records.
- Examined date ranges and key business metrics.
- Identified data-quality issues requiring attention.

### 2. Data Cleaning

- Removed unnecessary columns from the analytical dataset.
- Prepared date fields for analysis.
- Checked data quality and missing values.
- Saved the cleaned dataset for subsequent analysis.

### 3. Exploratory Data Analysis

- Examined distributions and key numerical metrics.
- Investigated delivery-risk patterns.
- Explored profitability and business trends.
- Used Python libraries to summarize the data.

### 4. SQL Business Analysis

Ten SQL analyses were prepared to investigate:

1. Shipping performance
2. Category profitability
3. Loss-making products
4. Discount analysis
5. Market performance
6. Monthly sales and profit
7. Customer segment performance
8. Order status analysis
9. Actual versus scheduled shipping duration
10. Overall business KPIs

### 5. Data Visualization

Python visualizations were created to examine:

- Late-delivery risk by shipping mode
- Monthly sales and profit trends
- Profit by product category
- Average profit by discount group
- Products with the lowest combined profit

## Key Findings

### Shipping Performance

| Shipping Mode | Late-Delivery-Risk Percentage |
|---|---:|
| First Class | 95.32% |
| Second Class | 76.63% |
| Same Day | 45.74% |
| Standard Class | 38.07% |

First Class recorded the highest late-delivery-risk percentage in the SQL analysis. This is a priority for further investigation, but the risk flag should not be interpreted as a confirmed late-delivery rate.

### Profitability

The initial analysis identified **33,784 records with negative Order Profit Per Order values**. Further analysis by product, category, discount level, and market can help identify where profitability issues are concentrated.

## Business Recommendations

- Investigate delivery processes and scheduling for high-risk shipping modes.
- Review products with recurring or substantial negative profit.
- Evaluate whether discount policies support profitability objectives.
- Monitor monthly profit alongside sales and order volume.
- Compare market and category performance using both sales and profit.
- Maintain clear KPI definitions and protect unnecessary customer-identifying information.

See [`reports/business_recommendations.md`](reports/business_recommendations.md) for the detailed recommendations and limitations.

## How to Run the Project

### Prerequisites

Install Python and MySQL if you want to reproduce both the Python and SQL analyses.

### Install Python dependencies

```bash
python -m pip install -r requirements.txt
```

### Run the notebooks

Open the `notebooks` folder in Jupyter Notebook or VS Code and run the notebooks in numerical order, from data inspection through business insights.

### Generate visualizations

From the project root, run:

```bash
python visualizations/visualizations.py
```

The script reads the cleaned dataset and saves the chart images in the `visualizations` folder.

### Run the SQL analysis

1. Open MySQL Workbench.
2. Connect to your local MySQL server.
3. Select the `supply_chain_analysis` database.
4. Open `sql/supply_chain_analysis.sql`.
5. Execute the queries against the imported analytical table.

The SQL scripts use the `supply_chain_python_import` table. Adjust the table name if your local setup differs.

## Limitations

- The dataset represents historical observations and does not establish causation.
- Late-delivery-risk flags are not necessarily equivalent to confirmed late deliveries.
- Profit metrics should be interpreted according to the dataset's definitions.
- Recommendations require validation against actual business policies and operational costs.

## Conclusion

This project demonstrates an end-to-end analytics workflow combining Python, SQL, exploratory analysis, visualization, and business recommendations. It focuses on turning operational data into questions that decision-makers can investigate to improve delivery performance and profitability.

