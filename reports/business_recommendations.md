## 1. Project Objective

This project analyzes supply chain operations to understand delivery risk, product profitability, discounting patterns, market performance, and monthly business trends. Python, SQL, Pandas, NumPy, Matplotlib, and Seaborn are used to explore the data and support data-driven recommendations.

## 2. Verified Findings

### Delivery Performance

The SQL analysis identified the following late-delivery-risk percentages by shipping mode:

- **First Class:** 95.32%
- **Second Class:** 76.63%
- **Same Day:** 45.74%
- **Standard Class:** 38.07%

First Class has the highest percentage of records flagged for late-delivery risk. This warrants further investigation into delivery schedules, operational processes, and service commitments. The risk flag should not be treated as proof that every flagged shipment was delivered late.

### Profitability

The dataset contains **33,784 records with negative Order Profit Per Order values**. These records should be examined by product, category, market, and discount level to identify where losses are concentrated.

### Data Quality

The initial inspection identified missing values in several columns, including customer last names, customer ZIP codes, and order ZIP codes. The Product Description column was entirely empty in the original dataset. Unnecessary customer-identifying fields should be excluded from public analytical outputs.

## 3. Recommended Business Actions

### A. Investigate High-Risk Shipping Modes

Review First Class and Second Class shipping performance, scheduled delivery commitments, and actual shipping durations. Determine whether operational changes or revised scheduling practices are justified by confirmed delivery outcomes.

### B. Investigate Loss-Making Products

Rank products by combined negative profit and examine their sales volume, discount levels, and categories. Prioritize detailed investigation of products that repeatedly generate negative profit.

### C. Evaluate Discount Policies

Compare average and total profit across discount groups. Identify transactions where higher discounts coincide with negative profit and assess whether those discounts support the business's commercial objectives.

### D. Monitor Monthly Performance

Track monthly sales, profit, and order counts together. Investigate periods where sales and profit move in different directions instead of using revenue alone to evaluate performance.

### E. Compare Markets and Product Categories

Compare total sales, total profit, and order volume across markets and categories. Use these metrics together to identify strong performers and areas requiring further analysis.

### F. Establish Delivery KPIs

Create a delivery-performance dashboard with late-delivery-risk percentage, average actual shipping days, average scheduled shipping days, and shipping-mode comparisons. Clearly distinguish risk indicators from confirmed late-delivery outcomes.

### G. Maintain Data Quality and Privacy

Validate dates, missing values, data types, and metric definitions before reporting results. Avoid publishing unnecessary customer contact details, addresses, or other identifying information.

## 4. Limitations

This project is based on historical observational data. The analysis can reveal patterns and associations but cannot independently establish the causes of delivery delays or negative profits. Business recommendations should be validated using operational policies, cost definitions, and additional business data.

## 5. Conclusion

The analysis provides a foundation for investigating delivery risk, profitability challenges, discounting practices, and differences in market performance. The findings can help prioritize further analysis and support more informed operational decisions.
