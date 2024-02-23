/*===================================================================================
          SQL FINAL GROUP PROJECT
=====================================================================================
Script Date: 02/02/2024
Authors : Hemalatha Bhaskar				Marian Rangika Pavithrini Salgadoe
Saranya Varadharajan				    Zaida Yarely Borja Bueno
Description: The HR Manager of VivaK, a successful fashion retail chain based in Southlake, Texas, has recruited a team of analysts to develop an Online Analytical Processing (OLAP) 
Database for enhancing their HR analytics. Due to the current management's data being stored in multiple formats and containing anomalies, the team is tasked with 
analyzing the data, creating a schema, and executing specific queries. */ 

/* Importing Data to vivakdump from Mutlitple Sources */
-- Importing employee.json file via vivakdump / Tables / Right Click / Table Data Import Wizard.
-- Importing locations.csv file via vivakdump / Tables / Right Click / Table Data Import Wizard.
-- Importing departments.csv file via vivakdump / Tables / Right Click / Table Data Import Wizard.
-- Importing orgstructure.csv file via vivakdump / Tables / Right Click / Table Data Import Wizard.
-- Importing dependent.csv file via vivakdump / Tables / Right Click / Table Data Import Wizard.
-- Importing countries table via hr database directly
-- Importing regions table via hr database directly

/*		As part of our strategic initiative to create a comprehensive OLAP database including all aspects of VivaK, we employed a systematic approach. We established a schema named 'vivakdump' 
to serve as a staging ground for importing and harmonizing data from various sources. This initiative allowed us to gain a complete view and perform in-depth analysis on the diverse datasets 
across the company.
The process unfolded in three main steps:
	** SQL File Upload: We started the process by uploading the SQL file (HR), containing essential data. (countries, locations and regions). This served as our opening layer, arranging the base for subsequent integration.
	** Importing Diverse Data Formats: afterward, we systematically imported data from JSON (employees), CSV(dependent), and Excel(orgstructure) files into the 'vivakdump' schema. This approach 
		ensured that data from different sources effortlessly coexisted, facilitating a unified view.
	** Creation of Final 'vivakhr' Schema: once all data was consolidated within the 'vivakdump' schema, we initiated the creation of the final 'vivakhr' schema. This schema is structured with 
		clean and organized data, reflecting our commitment to achieving a well-designed OLAP database for VivaKhr. 	*/

/***************   BEGINNNING OF VIVAKHR SCHEMA CREATION     *****************/
-- Drop Schema vivakhr if it already exists.
DROP SCHEMA IF EXISTS vivakhr;

-- Create schema vivakhr.
CREATE SCHEMA IF NOT EXISTS vivakhr;

-- Select the 'vivakhr' database for subsequent operations.
USE vivakhr;

/* Task 2: Create a Schema based on VivaK_Data_Model and call it VivaKHR. You must include all the statements in your SQL file and only the important statements/ outputs in your presentation. */

-- Create a new table 'regions' if it does not already exist.
CREATE TABLE IF NOT EXISTS regions (
     region_id   INT,						--  Defines 'region_id' column as integer data type.
     region_name VARCHAR(200) NOT NULL,		--  Defines 'region_name' column as variable character string with maximum length of 200 characters. This column cannot be empty.
	 
     PRIMARY KEY (region_id)				--  Sets 'region_id' as the primary key for the 'regions' table.
  ); 

-- Create a new table 'countries' if it does not already exist.
CREATE TABLE IF NOT EXISTS countries (
     country_id INT AUTO_INCREMENT,			--  Defines 'country_id' column as variable character string with maximum length of 3 characters. 
     country_code VARCHAR(3),				-- Defines 'country_code' column as variable character string with maximum length of 3 characters.						
     country_name VARCHAR(150) NOT NULL,	--  Defines 'country_name' column as variable character string with maximum length of 150 characters. This column cannot be empty.
     region_id    INT,						--  Defines 'region_id' column as integer data type.
	 
     PRIMARY KEY (country_id),				--  Sets 'country_id' as the primary key for the 'countries' table.
     CONSTRAINT countries_region_fk
		FOREIGN KEY (region_id) REFERENCES regions (region_id)    -- Establish a foreign key relationship between 'region_id' in the 'countries' table and 'region_id' in the 'regions' table.
			ON UPDATE RESTRICT 					-- 'ON UPDATE RESTRICT' prevents 'region_id' updates in 'regions'.
			ON DELETE CASCADE				    -- 'ON DELETE CASCADE' auto deletes related child 'countries' table observations. 
  ); 

-- Create a new table 'locations' if it does not already exist.
CREATE TABLE IF NOT EXISTS locations (
     location_id    INT,					--  Defines 'location_id' column as integer data type.	
     location_code  INT,					--  Defines 'location_code' column as integer data type.	
     street_address VARCHAR(300),			--  Defines 'street_address' column as variable character string with maximum length of 300 characters.
     postal_code    VARCHAR(8),				--  Defines 'postal_code' column as variable character string with maximum length of 8 characters.
     city           VARCHAR(30),			--  Defines 'city' column as variable character string with maximum length of 30 characters.
     state_province VARCHAR(30),			--  Defines 'state_province' column as variable character string with maximum length of 30 characters.
     country_id     INT,					--  Defines 'country_id' column as integer data type.	
	 
     PRIMARY KEY (location_id),				--  Sets 'location_id' as the primary key for the 'locations' table.
     CONSTRAINT locations_country_fk
		FOREIGN KEY (country_id) REFERENCES COUNTRIES (country_id)	 -- Establish a foreign key relationship between 'country_id' in the 'locations' table and 'country_id' in the 'countries' table.
			ON UPDATE RESTRICT 					-- 'ON UPDATE RESTRICT' prevents 'country_id' updates in 'countries'.
			ON DELETE CASCADE					-- 'ON DELETE CASCADE' auto deletes related child 'locations' table observations. 
  ); 

-- Create a new table 'departments' if it does not already exist.
CREATE TABLE IF NOT EXISTS departments (
     department_id   INT,					--  Defines 'department_id' column as integer data type.
     department_name VARCHAR(50),			--  Defines 'department_name' column as variable character string with maximum length of 50 characters.
       
     PRIMARY KEY (department_id)			--  Sets 'department_id' as the primary key for the 'departments' table.
  ); 

-- Create a new table 'jobs' if it does not already exist.
CREATE TABLE IF NOT EXISTS jobs (
     job_id        INT,						--  Defines 'job_id' column as integer data type.
     job_title     VARCHAR(100),			--  Defines 'job_title' column as variable character string with maximum length of 50 characters.
     min_salary    DOUBLE(10,2),			--  Defines 'min_salary' column as double precision floating point number.
     max_salary    DOUBLE(10,2),			--  Defines 'max_salary' column as double precision floating point number.
     department_id INT,						--  Defines 'department_id' column as integer data type.
	 
     PRIMARY KEY (job_id),					--  Sets 'job_id' as the primary key for the 'jobs' table.
     CONSTRAINT jobs_dep_fk
		FOREIGN KEY (department_id) REFERENCES departments(department_id) 	-- Establish a foreign key relationship between 'department_id' in the 'jobs' table and 'department_id' in the 'departments' table.
			ON UPDATE RESTRICT 					-- 'ON UPDATE RESTRICT' prevents 'department_id' updates in 'departments'.			
			ON DELETE CASCADE					-- 'ON DELETE CASCADE' auto deletes related child 'jobs' table observations. 		
  ); 

-- Create a new table 'employees' if it does not already exist.
CREATE TABLE IF NOT EXISTS employees (
     employee_id INT,						-- Defines 'employee_id' column as integer data type.
     first_name VARCHAR(50) NOT NULL,		--  Defines 'first_name' column as variable character string with maximum length of 50 characters. This column cannot be empty.
     last_name VARCHAR(50) NOT NULL,		--  Defines 'last_name' column as variable character string with maximum length of 50 characters. This column cannot be empty.
     email VARCHAR(100) NOT NULL,			--  Defines 'email' column as variable character string with maximum length of 100 characters. This column cannot be empty.
     phone_number VARCHAR(17),				--  Defines 'phone_number' column as variable character string with maximum length of 17 characters.
     job_id INT,							-- Defines 'job_id' column as integer data type.
     location_id INT,						-- Defines 'location_id' column as integer data type.
     salary DOUBLE(10,2),					--  Defines 'salary' column as double precision floating point number.
     report_to INT,							-- Defines 'report_to' column as integer data type.
     hire_date DATE,						-- Defines 'hire_date' column as date data type.
     experience_at_vivak INT,				-- Defines 'experience_at_vivak' column as integer data type.
     last_performance_rating DOUBLE,		--  Defines 'last_performance_rating' column as double precision floating point number.
     salary_after_increment DOUBLE(10,2),	--  Defines 'salary_after_increment' column as double precision floating point number.				
     annual_dependent_benefit DOUBLE(10,2),	--  Defines 'annual_dependent_benefit' column as double precision floating point number.
     
     PRIMARY KEY (employee_id),				--  Sets 'employee_id' as the primary key for the 'employees' table.
     CONSTRAINT employees_job_fk 
		FOREIGN KEY (job_id) REFERENCES jobs (job_id)	-- Establish a foreign key relationship between 'job_id' in the 'employees' table and 'job_id' in the 'jobs' table.
			ON UPDATE RESTRICT					-- 'ON UPDATE RESTRICT' prevents 'job_id' updates in 'jobs'.  
			ON DELETE CASCADE,					-- 'ON DELETE CASCADE' auto deletes related child 'employees' table observations. 		
     CONSTRAINT employees_loc_fk 
		FOREIGN KEY (location_id) REFERENCES locations (location_id)	-- Establish a foreign key relationship between 'location_id' in the 'employees' table and 'location_id' in the 'locations' table. 
			ON UPDATE RESTRICT					-- 'ON UPDATE RESTRICT' prevents 'location_id' updates in 'locations'.
			ON DELETE CASCADE, 					-- 'ON DELETE CASCADE' auto deletes related child 'employees' table observations. 		
     CONSTRAINT employees_emp_fk 
		FOREIGN KEY (report_to) REFERENCES employees (employee_id)	-- Establish a foreign key relationship between 'employee_id' in the 'employees' table and 'employee_id' in the 'employees' table.
			ON UPDATE RESTRICT 					-- 'ON UPDATE RESTRICT' prevents 'employee_id' updates in 'employees'.
			ON DELETE CASCADE,					-- 'ON DELETE CASCADE' auto deletes related 'employees' table observations. 		
     CONSTRAINT CHECK(last_performance_rating between 0 and 10)		-- Check constraint to enforces last_performance_rating values are between 0 and 10.
);

-- Create a new table 'dependents' if it does not already exist.
CREATE TABLE IF NOT EXISTS dependents (
     dependent_id INT auto_increment,		-- Defines 'dependent_id' column as integer data type.
     first_name   VARCHAR(50) NOT NULL,		--  Defines 'first_name' column as variable character string with maximum length of 50 characters. This column cannot be empty.
     last_name    VARCHAR(50) NOT NULL,		--  Defines 'last_name' column as variable character string with maximum length of 50 characters. This column cannot be empty.
     relationship VARCHAR(10) NOT NULL,		--  Defines 'relationship' column as variable character string with maximum length of 10 characters. This column cannot be empty.
     employee_id  INT,						-- Defines 'employee_id' column as integer data type.
	 
     PRIMARY KEY (dependent_id),			--  Sets 'dependent_id' as the primary key for the 'dependents' table.
     CONSTRAINT dependents_emp_fk
		FOREIGN KEY (employee_id) REFERENCES employees(employee_id)	-- Establish a foreign key relationship between 'employee_id' in the 'dependents' table and 'employee_id' in the 'employees' table.
			ON UPDATE RESTRICT					-- 'ON UPDATE RESTRICT' prevents 'employee_id' updates in 'employees'.
			ON DELETE CASCADE					-- 'ON DELETE CASCADE' auto deletes related child 'dependents' table observations. 	
  ); 
 
 /*
2.1. All salary-related columns must be double. Data must be recorded in 2 decimals.
2.2. All ID columns and their related foreign keys must be Integer.
2.3. The employee table MUST contain the report_to column to record the ID of the employee’s manager.
2.4. The data type of All the date columns MUST be DATE.
2.5. Include a column called experience_at_VivaK in the appropriate table to include the number of months that each employee has worked at VivaK.
2.6. Include a column called last_performance_rating in the appropriate table to include the performance rating (0-10) of each employee after the annual performance appraisal.
2.7. Include a column called salary_after_increment in the appropriate table to record the salary anticipated after the annual performance appraisal.
2.8. Include a column called annual_dependent_benefit in the appropriate table to record the dependent bonus that each employee receives per dependent.
		********  ALL THE ABOVE MENTIONED REQUESTS HAVE BEEN PERFORMED TOGETHER ALONG WITH THE TABLE CREATION.  *********
*/

/* Task 3: Import and clean the data. Import the sample data to test the integrity and efficiency of your OLAP schema. You must include all the statements/outputs in your SQL file and only the important statements in your presentation. */
/*
-- 3.1. (3 Marks) Handle Duplicates: All tables must be in the full-normalized form, meaning that there should not be any data redundancy. Check for duplicates in each table using qualifying candidate keys.
-- 3.2. (12 Marks) Format the data according to the designated data types.
-- 3.2.a. Ensure the floating-point data is represented as double.
-- 3.2.b. Ensure that the phone numbers are all recorded in the format: ‘+000-000-000-0000’, where the first four characters refer to the country code.
-- 3.2.c. Ensure the dates are recorded in the format: ‘yyyy-mm-dd’.
*************		 ABOVE TASKS HAVE BEEN PERFORMED ALONG WITH DATA INSERTION INTO THE RESPECTIVE TABLES.	 ****************/

-- Inserting Data into vivakhr schema tables.
USE vivakhr;
-- Insert data into the 'regions' table by selecting records from the 'vivakdump.regions' table.
INSERT INTO regions(region_id, region_name)
      SELECT region_id, region_name FROM vivakdump.regions; 

-- Insert data into the 'countries' table by selecting records from the 'vivakdump.countries' table.       
INSERT INTO countries(country_code, country_name,region_id)
      SELECT country_id, country_name, region_id FROM vivakdump.countries;
      
-- Insert data into the 'locations' table by selecting records from the 'vivakdump.locations' table, 'countries' table.      
INSERT INTO locations(location_id, location_code, street_address, postal_code, city, state_province, country_id)
      SELECT location_id, location_code, street_address, postal_code, city, state_province, c.country_id	
		FROM vivakdump.locations AS l inner join countries AS c on (c.country_code = l.country_id);

-- Insert data into the 'departments' table by selecting records from the 'vivakdump.departments' table.
INSERT INTO departments(department_id, department_name)
      SELECT department_id, department_name FROM vivakdump.departments;

-- Insert distinct data into the 'jobs' table by selecting records from the 'vivakdump.jobs' table, 'vivakdump.ORGSTRUCTURE' table, 'vivakdump.DEPARTMENTS' table.
INSERT INTO jobs(job_id, job_title, min_salary, max_salary, department_id)		-- Task 3.1 Handle duplicates with distinct clause.
	SELECT DISTINCT o.job_id, o.job_title, o.min_salary, o.max_salary, d.department_id 
    FROM vivakdump.ORGSTRUCTURE AS o                                 			-- Right join on orgstructure table to import missing job id's. 
		INNER JOIN vivakdump.DEPARTMENTS AS d USING (department_name);   		-- Inner join on departments table to retrieve department_id. 

-- Insert distinct data into the 'employees' table by selecting records from the 'vivakdump.employees', 'jobs' table, 'locations' table, 'countries' table.
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, job_id, salary, report_to, hire_date, location_id)
      SELECT DISTINCT e.employee_id, e.first_name, e.last_name, e.email,
                      concat(CASE														-- Task 3.2.b Format phone numbers according to country code.
                               WHEN country_code IN ( 'US', 'CAN' ) THEN '+001-'    	-- Task 3.2.b Handle phone number format as +000-000-000-0000.
                               WHEN country_code = 'UK' THEN '+044-'
                               WHEN country_code = 'DE' THEN '+045-'
                               ELSE '+000-'
                             END, replace(e.phone_number, '.', '-')) AS phone_number,   -- Task 3.2.b Replace periods with hyphens in phone numbers.
                      e.job_id,
                      e.salary,
                      NULL,
                      date(e.hire_date) AS hire_date,                                   -- Task 3.2.c Hire Date formatted as 'yyyy-mm-dd'.
                      e.department_id   AS location_id                                  -- Convert department id as location id that has been erroneously designed.
        FROM vivakdump.employees AS e
             INNER JOIN jobs AS j using (job_id)										-- Inner join with 'jobs' table using common column 'job_id'.
             INNER JOIN locations AS l													-- Inner join with 'locations' table using common column 'location_id'.
                     ON ( e.department_id = l.location_id )                             -- Treat department_id as location_id using the join appropriately.
             INNER JOIN countries AS c using (country_id); 								-- Inner join with 'countries' table using common column 'country_id'.

-- Insert data into the 'dependents' table by selecting records from the 'vivakdump.dependent' table, 'employees' table.      
INSERT INTO dependents(first_name, last_name, relationship, employee_id)
      SELECT d.first_name, d.last_name, d.relationship, d.employee_id
        FROM vivakdump.dependent AS d
             INNER JOIN employees AS e using (employee_id);       -- Inner join with 'employees' table to ignore the orphan records from 'dependents' tables.

-- Retaining Select queries consistently across the SQL script for convenient querying.              
select * from regions; 
select * from countries; 
select * from locations;
select * from departments;
select * from jobs;
select * from employees;
select * from dependents;
 
-- 3.3. (10 Marks) Treat Missing Values:
-- 3.3.a. Fill up the report_to column by analyzing the available data.
update employees e
	join vivakdump.orgstructure j using (job_id) 
	join employees mgr on (reports_to = mgr.job_id
	and case 
			when j.reports_to = 1 then e.location_id 
            else mgr.location_id  end  = e.location_id)
	set e.report_to = mgr.employee_id;
    
/*We're refining the 'report_to' information in our 'employees' table to establish a more accurate reporting structure. To achieve this, we're using data from the 'orgstructure' table, where 
	manager information is stored alongside job positions. The update is made by linking the two tables through the 'job_id.'

We're performing a join between the 'employees' table and the 'orgstructure' table using the common 'job_id' column. This connection allows us to correlate each employee with their 
	respective job position and, consequently, their manager's details.

The 'reports_to' column in the 'employees' table indicates the direct supervisor for each employee. By comparing the 'job_id' of an employee's reporting structure in the 'orgstructure' table, 
	we pinpoint the corresponding 'employee_id' of the manager.
    
The 'report_to' column in the 'employees' table is then updated with the 'employee_id' of the identified manager. This dynamic update reflects the latest organizational hierarchy, ensuring 
	that each employee is linked to the correct supervisor based on their job position.

This approach not only refines reporting relationships but also promotes accuracy and consistency within the 'employees' table, aligning it with the hierarchical structure outlined in the 
	'orgstructure' table. It's a strategic update that enhances the organizational view within our employee data.*/

-- 3.3.b. Devise a strategy to fill in the missing entries in the salary column. Justify your answers and state your assumptions.
UPDATE employees as e
	JOIN jobs as j using (job_id)
	SET e.salary = (j.min_salary + j.max_salary) / 2
	WHERE e.salary = 0;
    
/*	Strategy: "In order to derive a more representative estimate of the salary for each job position, we opted to utilize the average value, considering both 'min_salary' and 'max_salary.' 

This approach acknowledges that both values contribute to the overall salary range and assumes an equal weight for each. Consequently, we populated the 'salary' column in the 'employees' 
	table by calculating the average of 'min_salary' and 'max_salary' corresponding to the respective 'job_id' in the 'jobs' table. 

This methodology ensures a more balanced and better representation of the salary information for each job."		*/



/* Task 4: Perform the following calculations and updates. You must include all the statements in your SQL file and only the important statements/outputs in your presentation. */
-- 4.1 experience_at_VivaK: calculate the time difference (in months) between the hire date and the current date for each employee and update the column.
-- Updating experience_at_VivaK for all records in 'employees' table.
UPDATE employees
	SET experience_at_VivaK = TIMESTAMPDIFF(month, hire_date, CURRENT_DATE);	-- Calculating the difference in months between hire date and current date.
select * from employees;

-- 4.2 last_performance_rating: to test the system, generate a random performance rating figure (a decimal number with two decimal points between 0 and 10) for each employee and update the column.
-- Updating last_performance_rating for all records in 'employees' table.
UPDATE employees
	SET last_performance_rating = ROUND(RAND() * 10, 2);	-- Generating a random number between 0 and 10, rounding to two decimal places.
select * from employees;

-- 4.3 salary_after_increment: calculate the salary after the performance appraisal and update the column by using the following formulas:
		/*			salary_after_increment = salary * increment
					increment = 1 + (0.01 * experience_at_VivaK) + rating_increment
					last_performance_rating    rating_increment
						>= 9						0.15
						>= 8						0.12
						>= 7						0.10
						>= 6						0.08
						>= 5						0.05
						< 5							0.02
					* Salary caps at max_salary. */ 

/****************  OUR CALCULATION   ************/
UPDATE employees e			-- -- Update 'salary_after_increment' for each employee in the 'employees' table.
	LEFT JOIN jobs j ON e.job_id = j.job_id
	SET e.salary_after_increment = LEAST(e.salary + ((1 + (0.01 * e.experience_at_VivaK) + 
		CASE										
            WHEN e.last_performance_rating >= 9 THEN 0.15
            WHEN e.last_performance_rating >= 8 THEN 0.12
            WHEN e.last_performance_rating >= 7 THEN 0.10
            WHEN e.last_performance_rating >= 6 THEN 0.08
            WHEN e.last_performance_rating >= 5 THEN 0.05
            ELSE 0.02
        END
    ) * e.salary) / 100,
    j.max_salary
);

select * from employees;

/****************  ORIGINAL MADDY REQUESTED CODE    ************/
UPDATE employees e
left JOIN jobs j ON e.job_id = j.job_id
SET e.salary_after_increment = greatest(e.salary * (1 + (0.01 * e.experience_at_VivaK) + 
        CASE
            WHEN e.last_performance_rating >= 9 THEN 0.15
            WHEN e.last_performance_rating >= 8 THEN 0.12
            WHEN e.last_performance_rating >= 7 THEN 0.10
            WHEN e.last_performance_rating >= 6 THEN 0.08
            WHEN e.last_performance_rating >= 5 THEN 0.05
            ELSE 0.02
        END
    ), j.max_salary); 
-- Calculate the 'salary_after_increment' based on the last_performance_rating, rating_increment, experience_at_VivaK, increment and salary

/* 	salary_after_increment calculation explanation:
	** last_performance_rating - which is a random value generated by RAND() betwene 0 to 10.
    ** rating_increment - calculated by using CASE flow which has various levels based on last_performance_rating
    ** increment - 1 + (0.01 * experience_at_VivaK) + rating_increment 
    ** salary_after_increment = salary + (increment * salary)/100". 	(Our version modified)
    ** salary_after_increment = salary * increment		 				(Maddy's requested version)
		We perform a join operation on 'jobs' table from the 'employee' table to pull necessary records using 'job_id' as the common column.
*/
/*
	** For this query we have provided two suggestions as we feel the formula "salary_after_increment = salary * increment" is having a discrepancy at some level. 
		The values also seems to represent the same as every single value in 'salary_after_increment' populated by the above formula is way above the maximum salary level for an employee.
        Since the salary is capped at 'max_salary', all the values would just be same as 'max_salary'.
        
        Instead we have used the formula "salary_after_increment = salary + (increment * salary)/100". 
        This reflects that if an employee has an increment of 5% on a salary of 100%, their 'salary_after_increment' would be 100 + 5 = 105$. This reflects reasonable values in our 'salary_after_increment'
			column based on the increment calculated.
            
		However we have provided the code as per Maddy's requested calculation too below so that it can be executed and compared accordingly.		*/


    
-- 4.4 annual_dependent_benefit: Calculate the annual dependent benefit per dependent (in USD) and update the column as per the table below:
		/*				Title				Dependent benefit per dependent
						Executives				0.2 * annual salary
						Managers				0.15 * annual salary
						Other Employees			0.05 * annual salary		*/

UPDATE employees AS e		-- Update 'annual_dependent_benefit' for each employee in the 'employees' table.
SET e.annual_dependent_benefit = (
    SELECT 				 
        CASE			-- Calculate the annual_dependent_benefit' based on the employees role and number of dependents.
            WHEN dp.department_name LIKE '%Executive%' THEN e.salary * 0.2 * (SELECT COUNT(d.dependent_id) FROM dependents AS d WHERE d.employee_id = e.employee_id)
            WHEN j.job_title LIKE '%Manager%' THEN e.salary * 0.15 * (SELECT COUNT(d.dependent_id) FROM dependents AS d WHERE d.employee_id = e.employee_id)
            ELSE e.salary * 0.05 * (SELECT COUNT(d.dependent_id) FROM dependents AS d WHERE d.employee_id = e.employee_id)
        END
    FROM jobs AS j
    LEFT JOIN departments AS dp ON j.department_id = dp.department_id
    WHERE e.job_id = j.job_id
);
/*	To calculate the annual_dependent_benefit' for each employee we use the following calculation:
    ** We retrieve the count of dependents for each employee by performing a join operation on the 'dependents' table using 'employee_id' as the common column.
	** We use the 'department_name' from 'department' table for each employee to identify 'Executive' level employees.  
			annual_dependent_benefit = salary * 0.2 * count_of_dependents
    ** We use the 'job_title' for each employee from the 'jobs' table to identify 'Manager' level employees
			annual_dependent_benefit = salary * 0.15 * count_of_dependents
    ** Remaining employees will fall under 'Other' category
			annual_dependent_benefit = salary * 0.05 * count_of_dependents		*/


-- 4.5 email: Until recently, the employees were using their private email addresses, and the company has recently bought the domain VivaK.com. Replace employee email addressed to ‘<emailID>@vivaK.com’. emailID is the part of the current employee email before the @ sign.
-- Updating email field for all records in 'employees' table.
UPDATE employees
	SET email = CONCAT(SUBSTRING_INDEX(email, '@', 1), '@vivaK.com');	-- Extracting the part of email before @ symbol and appending the domain '@vivak.com' to the extracted username.



