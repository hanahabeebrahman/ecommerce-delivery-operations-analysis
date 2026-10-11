
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path

# Project paths
BASE_DIR = Path(__file__).resolve().parent.parent
DATA_PATH = BASE_DIR / "data" / "cleaned" / "supply_chain_cleaned.csv"
OUTPUT_DIR = BASE_DIR / "visualizations"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Load data
df = pd.read_csv(DATA_PATH)

sns.set_theme(style="whitegrid", palette="pastel")

# 1. Delivery risk by shipping mode
shipping = (
    df.groupby("Shipping Mode")
    .agg(
        Late_Risk_Percentage=("Late_delivery_risk", "mean"),
        Actual_Days=("Days for shipping (real)", "mean"),
        Scheduled_Days=("Days for shipment (scheduled)", "mean")
    )
    .reset_index()
)

shipping["Late_Risk_Percentage"] *= 100
shipping = shipping.sort_values("Late_Risk_Percentage", ascending=False)

plt.figure(figsize=(10, 6))
ax = sns.barplot(
    data=shipping,
    x="Shipping Mode",
    y="Late_Risk_Percentage"
)
ax.bar_label(ax.containers[0], fmt="%.1f%%", padding=3)
plt.title("Late-Delivery Risk by Shipping Mode")
plt.ylabel("Records Flagged as Late-Delivery Risk (%)")
plt.xticks(rotation=15)
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "01_shipping_mode_risk.png", dpi=300)
plt.close()

# 2. Monthly sales and profit trends
df["order date (DateOrders)"] = pd.to_datetime(
    df["order date (DateOrders)"], errors="coerce"
)
df["Order_Month"] = df["order date (DateOrders)"].dt.to_period("M")

monthly = (
    df.groupby("Order_Month")
    .agg(
        Total_Sales=("Sales", "sum"),
        Total_Profit=("Order Profit Per Order", "sum")
    )
    .reset_index()
)
monthly["Order_Month"] = monthly["Order_Month"].astype(str)

fig, axes = plt.subplots(2, 1, figsize=(14, 9), sharex=True)

sns.lineplot(
    data=monthly, x="Order_Month", y="Total_Sales",
    marker="o", ax=axes[0]
)
axes[0].set_title("Monthly Sales Trend")
axes[0].set_ylabel("Total Sales")

sns.lineplot(
    data=monthly, x="Order_Month", y="Total_Profit",
    marker="o", ax=axes[1]
)
axes[1].axhline(0, linestyle="--", linewidth=1)
axes[1].set_title("Monthly Profit Trend")
axes[1].set_ylabel("Total Profit")
axes[1].set_xlabel("Month")

for ax in axes:
    ax.tick_params(axis="x", rotation=60)

plt.tight_layout()
plt.savefig(OUTPUT_DIR / "02_monthly_sales_profit.png", dpi=300)
plt.close()

# 3. Profit by product category
category = (
    df.groupby("Category Name")
    .agg(Total_Profit=("Order Profit Per Order", "sum"))
    .reset_index()
    .sort_values("Total_Profit", ascending=False)
)

plt.figure(figsize=(12, 9))
sns.barplot(data=category, y="Category Name", x="Total_Profit")
plt.axvline(0, linestyle="--", linewidth=1)
plt.title("Total Profit by Product Category")
plt.xlabel("Total Profit")
plt.ylabel("Product Category")
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "03_category_profitability.png", dpi=300)
plt.close()

# 4. Discount levels vs. average profit
df["Discount_Group"] = pd.cut(
    df["Order Item Discount Rate"],
    bins=[-float("inf"), 0.10, 0.20, 0.30, float("inf")],
    labels=[
        "Below 10%",
        "10% to below 20%",
        "20% to below 30%",
        "30% and above"
    ],
    right=False
)

discount = (
    df.groupby("Discount_Group", observed=False)
    .agg(Avg_Profit=("Order Profit Per Order", "mean"))
    .reset_index()
)

plt.figure(figsize=(10, 6))
ax = sns.barplot(data=discount, x="Discount_Group", y="Avg_Profit")
ax.axhline(0, linestyle="--", linewidth=1)
plt.title("Average Profit by Discount Group")
plt.xlabel("Discount Group")
plt.ylabel("Average Profit per Record")
plt.xticks(rotation=15)
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "04_discount_vs_profit.png", dpi=300)
plt.close()

# 5. Top 10 products with the lowest combined profit
products = (
    df.groupby(["Product Name", "Category Name"])
    .agg(Total_Profit=("Order Profit Per Order", "sum"))
    .reset_index()
)

loss_products = (
    products[products["Total_Profit"] < 0]
    .nsmallest(10, "Total_Profit")
)

plt.figure(figsize=(12, 7))
sns.barplot(
    data=loss_products,
    y="Product Name",
    x="Total_Profit"
)
plt.axvline(0, linestyle="--", linewidth=1)
plt.title("Top 10 Products by Combined Negative Profit")
plt.xlabel("Total Profit")
plt.ylabel("Product")
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "05_loss_making_products.png", dpi=300)
plt.close()

print("All visualizations generated successfully!")
print("Saved to:", OUTPUT_DIR)
print("Files generated:", len(list(OUTPUT_DIR.glob("*.png"))))
