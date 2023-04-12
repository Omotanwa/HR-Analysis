Use hr;

describe hr;


select * from hr;


Alter table hr
change column id emp_id Varchar(225);


/**Clean date and time**/
SELECT 
    birthdate
FROM
    hr;
    

update hr
set birthdate= replace(birthdate, '06-04-91', '06-04-1991');

select birthdate from hr
where str_to_date(birthdate,'%m/%d/%Y') 
is null
;

update hr 
set birthdate = CASE
when birthdate like'%/%' then date_format(str_to_date( birthdate, '%m/%d/%Y'), '%Y-%m-%d')
when birthdate like'%-%' then date_format(str_to_date( birthdate, '%d-%m-%Y'), '%Y-%m-%d')
when birthdate like'%/%' then date_format(str_to_date( birthdate, '%d/%m/%Y'), '%Y-%m-%d')
else null
end;

update hr 
set termdate = date (str_to_date( termdate, '%Y-%m-%d %H:%i:%s UTC'));

/** adding age column**/

alter table hr
add column Age int;

/** changing data type from text to date **/

alter table hr
modify column birthdate Date;

alter table hr
modify column termdate Date;

alter table hr
modify column hire_date Date;

update hr 
set age= timestampdiff(year,birthdate, curdate());

/**aggregate**/

select min(age), max(age)
from hr
where age >= 18 and termdate='0000-00-00' ;

select distinct(gender), count(gender) from hr
where age >= 18 and termdate='0000-00-00'
Group by gender ;

select distinct(race), count(race) Race from  hr
where age >= 18 and termdate='0000-00-00'
Group by race
order by Race;


/** Age Distribution**/

select  
 Case
when age>= 20 and age<= 29 then '20-29'
when age>= 30 and age<= 40 then '30-39'
when age>= 40 and age<= 50 then '40-50'
else 'above 50'
end as age_group,  gender, count(*)
from  hr
where age >= 18 and termdate='0000-00-00'
Group by age_group,gender
order by age;

/** office location**/

select location, COUNT(location) from  hr
where age >= 18 and termdate='0000-00-00'
Group by location
order by location;

select 
 avg (datediff(termdate,hire_date))/356
from  hr
where termdate <= curdate() and termdate ='0000-00-00' and age >= 18
;

select gender,department, COUNT(jobtitle) as job_distribution from  hr
where age >= 18 and termdate='0000-00-00'
Group by department,gender
order by department;







