--  To select everything from the telecom_customer table and telecome_zipcode_population table
SELECT * FROM dbo.telecom_customer;
SELECT * FROM dbo.telecom_zipcode_population;


--- To remove duplicates
SELECT DISTINCT * FROM dbo.telecom_customer;
SELECT DISTINCT * FROM dbo.telecom_zipcode_population;


-- To view the top 10 from telecom_customer table
Select TOP 10  * from dbo.telecom_customer;


-- To view the top 10 from telecom_zipcode population table
Select TOP 10  * from dbo.telecom_zipcode_population;


-- To merged the 2 tables  
SELECT * FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code

--To view top 20 of the merged 2 tables  
SELECT TOP 20 * FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code;


 -- To view the Telecom customers Gender 
SELECT TC.Gender, 
        COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
GROUP BY TC.Gender;

-- To view married customer  that churned the telecom?
SELECT
CASE 
WHEN  (TC.Married) = 1 THEN 'YES' ELSE 'NO' END AS Married,
		COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE  TC.Customer_Status = 'Churned' 
GROUP BY TC.Married ;


-- To view the reason why customers  decide to churned the telecom
SELECT TC.Churn_Reason,
		COUNT(DISTINCT TC.Customer_ID) AS Number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
GROUP BY TC.Churn_Reason 
ORDER BY Number_of_Customer DESC;

-- To view the category why customers churned
SELECT TC.Churn_Category,
		COUNT(TC.Churn_Category) AS Count
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE  TC.Customer_Status = 'Churned' 
GROUP BY TC.Churn_Category ;




-- To view the category why customers churned
SELECT TC.Churn_Category, TC.Churn_Reason,
		COUNT(TC.Churn_Category) AS Count
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE  TC.Customer_Status = 'Churned' 
GROUP BY TC.Churn_Category, TC.Churn_Reason;


-- To view the category why customers churned
SELECT TC.Churn_Category,
		COUNT(TC.Churn_Category) AS Count
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE TC.Churn_Category IS NOT NULL
GROUP BY TC.Churn_Category ;

-- To view  Offer rendered to customers
SELECT TC.Offer,
		COUNT(TC.Offer) AS Count_Offer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
GROUP BY TC.Offer ;


--  To view the number of customer in percentage?
SELECT TC.Gender, 
COUNT(DISTINCT TC.Customer_ID) AS Number_of_Customer,
COUNT(DISTINCT TC.Customer_ID) *100.0/ SUM(COUNT(DISTINCT TC.Customer_ID)) OVER () AS CustomerPercentage
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
GROUP BY TC.Gender;

-- What is the total charges by  Gender ?
SELECT TC.Gender, 
SUM(TC.Total_Charges) AS Total_Charges
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
GROUP BY TC.Gender;

--To view the total population of all customer

SELECT TC.Customer_ID, 
SUM(TZP.Population) AS Total_Population
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
GROUP BY TC.Customer_ID
ORDER BY Total_Population DESC;

-- To view the total population  and city of churned customers
SELECT TC.Customer_ID,
SUM(TZP.Population) AS Total_Population
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE Customer_Status = 'Churned'
GROUP BY TC.Customer_ID
ORDER BY Total_Population DESC;


-- To view the number of customer, city and grand total in descending order
SELECT TC.City,
COUNT(TC.Customer_ID) AS No_Customer, 
SUM(Total_Revenue) AS GrandTotal_Revenue
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE  TC.Customer_Status = 'Joined'
GROUP BY City
ORDER BY GrandTotal_Revenue DESC;

-- To view the number of customer, city and grand total in descending order
SELECT TC.City,
SUM(TC.Total_Charges) AS GrandTotal_Total_Charges, 
SUM(Total_Revenue) AS GrandTotal_Revenue
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
Group BY TC.City;


-- How many customers churned, stayed, joined in the Q2 2022 ?
SELECT TC.Customer_Status,
COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
WHERE TC.Customer_Status IN ( 'Churned','Stayed','Joined')
GROUP BY TC.Customer_Status;
 
-- To view the number of customers by the  internet type?
SELECT TC.Internet_Type, 
        COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
WHERE TC.Internet_Type IS NOT NULL
GROUP BY TC.Internet_Type;


-- Top 10 city by Revenue, population and number of customers?

SELECT TOP 10 TC.City,
COUNT( TC. Customer_ID) AS Count_Customer,
SUM(TZP.Population) AS Total_Population,
SUM(Total_Revenue) AS Overall_Revenue
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP
ON TC.Zip_Code = TZP.Zip_Code
GROUP BY TC.City
ORDER BY Overall_Revenue DESC;

--to view top 10 city by churned customers

SELECT TOP 10 TC.City,
COUNT( TC. Customer_ID) AS Count_Customer,
SUM(Total_Revenue) AS Overall_Revenue
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE Customer_Status = 'Churned'
GROUP BY TC.City
ORDER BY Overall_Revenue DESC;


--Top 10 city  by the average long distance charges

SELECT City,
SUM(TC.Avg_Monthly_Long_Distance_Charges) AS Total_Average_monthlyDistance
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
GROUP BY TC.City
ORDER BY Total_Average_monthlyDistance DESC;


-- To view the number of customers by contract type
SELECT TC.Contract, 
COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE TC.Contract IS NOT NULL
GROUP BY TC.Contract;

 -- To view the number of customers by phone service?
SELECT 
CASE
WHEN  (TC.Phone_Service) = 1 THEN 'YES'
ELSE 'NO' 
END AS Phone_Service,
COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE TC.Phone_Service IS NOT NULL
GROUP BY TC.Phone_Service;

-- To View  Married customers that  stayed with the telecom?
SELECT  
  CASE
WHEN  (TC.Married) = 1 THEN 'YES' 
ELSE 'NO' 
END AS Married_Stayed,
COUNT(Customer_Status) AS Number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE TC.Customer_Status = 'Stayed'
GROUP BY TC.Married;

-- Types of Married customers that  joined with the telecom?
SELECT 
CASE WHEN  (TC.Married) = 1 THEN 'YES' ELSE 'NO'
END AS Married,
COUNT(DISTINCT TC.Customer_ID) AS Number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE TC.Customer_Status = 'joined'
GROUP BY TC.Married;

-- Types of Married customers that  churned  the telecom?
SELECT 
CASE WHEN  (TC.Married) = 1 THEN 'YES' ELSE 'NO' 
END AS Married,
COUNT(DISTINCT TC.Customer_ID) AS Number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE TC.Customer_Status = 'Churned'
GROUP BY TC.Married;

 -- To view the number of customers that are married
SELECT  
CASE 
WHEN  (TC.Married) = 1 THEN 'YES' 
ELSE 'NO'
END AS Married,
COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE TC.Married IS NOT NULL
GROUP BY TC.Married;

-- To view the number of customers by the  internet Service
SELECT 
CASE WHEN  (TC.Internet_Service) = 1 THEN 'YES'
ELSE 'NO'
END AS Internet_Service,
COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
GROUP BY TC.Internet_Service;


--  View the no of churned customer  by Internet service  whose tenure in month is more than 12 months ?

SELECT 
CASE WHEN  (TC.Internet_Service) = 1 THEN 'YES' 
ELSE 'NO'
END AS Internet_Service,
count(TC.Internet_Service) as Internet_Service_Count
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
WHERE TC.Tenure_in_Months>=12 and TC.Customer_Status = 'Churned'
GROUP BY TC.Internet_Service;



-- what is the average monthlycharge of customers with internet service?

select
AVG(TC.Monthly_Charge) as Avg_Month_Charge,
CASE WHEN  (TC.Internet_Service) = 1 THEN 'YES' ELSE 'NO' END AS Internet_Service
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
GROUP BY TC.Internet_Service;

-- what is the average monthlycharge of customers by internet type?
select TC.Internet_Type, 
AVG(Monthly_Charge) as Avg_Month_Charge
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
GROUP BY TC.Internet_Type;


-- To view if paperless billing has effect on churned customers?

select 
CASE WHEN  (TC.Paperless_Billing) = 1 THEN 'YES'
ELSE 'NO' 
END AS Paperless_Billing,
count(TC.Customer_Status) As N0_of_Churned_Customer 
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
WHERE TC.Customer_Status = 'Churned'
GROUP BY TC.Customer_Status,TC.Paperless_Billing;


-- To view customer by paperless billing?

select 
CASE WHEN  (TC.Paperless_Billing) = 1 THEN 'YES'
ELSE 'NO' 
END AS Paperless_Billing,
count(TC.Paperless_Billing) As Count_Paperless_Billing
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
GROUP BY TC.Paperless_Billing;

-- To view Customers payment methods ?
select TC.Payment_Method,
count(TC.Payment_Method) As Count_Payment_Method 
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
GROUP BY Payment_Method
ORDER BY TC.Payment_Method DESC;


--To view muliple lines of customers?
SELECT
CASE 
WHEN  (TC.Multiple_Lines) = 1 THEN 'YES'
ELSE 'NO' 
END AS Multiple_Lines,
COUNT(Multiple_Lines) AS Count_Multiple_Line
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE Multiple_Lines IS NOT NULL
GROUP BY Multiple_Lines ;

--To view online security customers?
SELECT CASE 
WHEN  (TC.Online_Security) = 1 THEN 'YES'
ELSE 'NO' 
END AS Online_Security, 
COUNT(DISTINCT TC.Customer_ID) AS Count
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE  Online_Security IS NOT NULL
GROUP BY Online_Security ;


--To view the online backup customers?
SELECT 
CASE 
WHEN  (TC.Online_Backup) = 1 THEN 'YES'
ELSE 'NO' 
END AS Online_Backup,
COUNT(Online_Backup) AS Count_Online_Backup
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE  Online_Backup IS NOT NULL
GROUP BY Online_Backup;


--To view the Device protection plan?
SELECT 
CASE 
WHEN  (TC.Device_Protection_Plan) = 1 THEN 'YES'
ELSE 'NO' 
END AS Device_Protection_Plan, 
COUNT(DISTINCT TC.Customer_ID) AS Count_Device_ProtectionPlan
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE Device_Protection_Plan IS NOT NULL
GROUP BY Device_Protection_Plan ;

--To view the unlimied data of customers
SELECT CASE 
WHEN  (TC.Unlimited_Data) = 1 THEN 'YES'
ELSE 'NO' 
END AS Unlimited_Data, 
COUNT(DISTINCT TC.Customer_ID) AS Count_Unlimited_Data
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE  Unlimited_Data IS NOT NULL
GROUP BY Unlimited_Data ;

--To view the tech support of customers?
SELECT CASE 
WHEN  (TC.Premium_Tech_Support) = 1 THEN 'YES'
ELSE 'NO' 
END AS Premium_Tech_Support, 
COUNT(DISTINCT TC.Customer_ID) AS Count_Premium_TechSupport
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE  Premium_Tech_Support IS NOT NULL
GROUP BY Premium_Tech_Support ;

--To view the streaming TV of customers?
SELECT CASE 
WHEN  (TC.Streaming_TV) = 1 THEN 'YES'
ELSE 'NO' 
END AS Streaming_TV,
COUNT(DISTINCT TC.Customer_ID) AS Count_Streaming_TV
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE Streaming_TV IS NOT NULL
GROUP BY Streaming_TV;

--To view the streaming music of  customers?
SELECT CASE 
WHEN  (TC.Streaming_Music) = 1 THEN 'YES'
ELSE 'NO' 
END AS Streaming_Music,
COUNT(DISTINCT TC.Customer_ID) AS Count_Streaming_Music
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE Streaming_Music IS NOT NULL
GROUP BY Streaming_Music ;

--To view the streaming movies of  customers?
SELECT CASE 
WHEN  (TC.Streaming_Movies) = 1 THEN 'YES'
ELSE 'NO' 
END AS Streaming_Movies,
COUNT(DISTINCT TC.Customer_ID) AS Count_Streaming_Movies
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE Streaming_Movies IS NOT NULL
GROUP BY Streaming_Movies ;


--- To calcualte the Avg Tenure in Months of Customers?
SELECT 
 AVG(TC.Tenure_in_Months) As AVG_Tenure_Month
 FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code;


-- To calcualte the Tenure in Months of Customers?
SELECT  TC.Customer_Status AS Customer_Status,
Contract,
 SUM (TC.Tenure_in_Months) As Total_Tenure_Month
 FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
GROUP BY Customer_Status, Contract
ORDER BY Customer_Status;


----- To view the Average  Monthly Charges of Customers?
SELECT 
 ROUND (AVG(TC.Monthly_Charge),0) As Avg_Monthly_Charge
 FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code;

----- To view the Average  tenure churned customers spent with the telecom?
SELECT 
 AVG(TC.Tenure_in_Months) As AVG_Tenure_Months_Churned_Customer
 FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE Customer_Status = 'Churned';

-- To view the Revenue of Customers?
SELECT 
 ROUND (AVG(TC.Total_Revenue),0) As Avg_Total_Revenue
 FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code;


----- To view the Revenue lost  of churned Customers?
SELECT 
 ROUND (SUM(TC.Total_Revenue),0) As Revenue_Lost_Churned_Customers
 FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE Customer_Status = 'Churned';

--To view the number Churned customer  by contract type?
SELECT TC.Contract, 
        COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE TC.Contract IS NOT NULL AND Customer_Status = 'Churned'
GROUP BY TC.Contract; 


--To view the number  of Churned customer  by offer?
SELECT TC.Offer, 
        COUNT(DISTINCT TC.Customer_ID) AS number_of_Customer
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
WHERE TC.Contract IS NOT NULL AND Customer_Status = 'Churned'
GROUP BY TC.Offer; 


--To view the customer status by Age?
SELECT TC.Customer_Status, Age, COUNT(Age) AS Count_Age,
CASE 
    WHEN  (TC.Age) <  20 THEN 'Below 20'
    WHEN (TC.Age)  <=30 THEN '20 - 30'
    WHEN (TC.Age)  <=40 THEN '30 - 40'
    WHEN (TC.Age)  <=50 THEN '40 -50'
    WHEN (TC.Age)  <=60 THEN '50 -60'
    WHEN (TC.Age)  <=70 THEN '60 -70'
ELSE '70+' 
END AS Age_Customers
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code
GROUP BY TC.Customer_Status, Age


--To view the number of referrals?
select  Customer_Status,
SUM(Number_of_Referrals) AS Total_Referrals
FROM telecom_customer TC
INNER JOIN telecom_zipcode_population TZP 
ON TC.Zip_Code = TZP.Zip_Code 
GROUP BY Customer_Status
ORDER BY Customer_Status DESC;

