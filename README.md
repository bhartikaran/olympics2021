# ETL Pipeline for Tokyo 2021 Olympics Data

## Project Overview
This project demonstrates an ETL (Extract, Transform, Load) pipeline for processing Tokyo 2021 Olympics data. The pipeline involves multiple stages, including fetching data from Kaggle using the Kaggle API, transforming the data using Azure Databricks, and loading the transformed data into Azure Data Lake. Finally, the data is queried using Azure Synapse Analytics to perform some basic analysis.

### Project Workflow
The overall flow of this project is as follows:
1. **Extract**: Fetch data from Kaggle (Olympics Tokyo 2021 data) using the Kaggle API.
2. **Transform**: Perform basic data transformations using Databricks notebooks.
3. **Load**: Store the transformed data in Azure Data Lake.
4. **Analyze**: Create a database in Azure Synapse and run SQL queries on the transformed data.

## Project Structure
The repository is organized as follows:

Data - (Raw data fetched from Kaggle API)
Olympicsdata_transformation.ipynb (Databricks notebook for data transformation) 
olympics_DataAnalysis.sql (Basic queries for analysis in Azure Synapse)

## Steps to Run the Project

### 1. Fetch Data from Kaggle API
The data for the Tokyo 2021 Olympics is fetched from Kaggle using the Kaggle API. 

To fetch the data:
- Install the Kaggle API: `pip install kaggle`
- Make sure you have your `kaggle.json` API key file from your Kaggle account placed in the appropriate directory.
- Run the script to fetch the data:

The raw data can be found in /Data folder of the repository.

2. Transform Data Using Azure Databricks
Once the data is stored in the Azure Data Lake, we use Azure Databricks for basic transformations. The notebook Olympicsdata_transformation.ipynb contains the logic for transforming the raw data.

Launch Azure Databricks and open the notebook Olympicsdata_transformation.ipynb.
Run the transformations as per the requirements (e.g., cleaning data, handling missing values, feature engineering).
After transforming the data, save the transformed data back into Azure Data Lake.
3. Load Transformed Data into Azure Data Lake
The transformed data will be stored in Azure Data Lake, allowing you to process large amounts of data in a scalable way.

Use Azure Data Factory to orchestrate the movement of data from the raw storage to the transformed storage.
4. Set Up Azure Synapse and Query the Data
In Azure Synapse Analytics, you can query the transformed data using SQL.

Create a database in Azure Synapse that points to the transformed data stored in Azure Data Lake.
Use the file path to connect to the data and create tables/views within Synapse.


Technologies Used
Azure Data Factory: For orchestrating data pipelines.
Azure Data Lake: For storing raw and transformed data.
Azure Databricks: For data transformation using Python and Spark.
Azure Synapse Analytics: For querying and analyzing the data using SQL.
Kaggle API: For fetching the Olympics dataset.
Conclusion
This project demonstrates how to integrate several Azure services to create an ETL pipeline for processing and analyzing large datasets. By using Azure Data Factory, Databricks, Data Lake, and Synapse Analytics, this solution can handle large-scale data processing and provide valuable insights for the Tokyo 2021 Olympics dataset.
