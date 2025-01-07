# [Santa takes on Site Analytics](https://adventofsql.com/challenges/20)

## Description

This Christmas, Santa wants to ensure his elves' marketing efforts reach every corner of the world. By analyzing web traffic, Santa uses a magical query to check how many people visited their site through the "utm_source=advent-of-sql" campaign. He aims to determine which gifts spark the most joy and which regions need extra cheer. It's crucial to match the right toys with eager children!

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-20/blob/main/advent_of_sql_day_20.sql)

+ Parse out all the query parameters from the urls.
+ A query param is a list of key value pairs that follow this syntax ?item=toy&id=1
+ Note the & is how to list multiple key value pairs.
+ Once you extract all the query params filter them so only the urls with utm_source=advent-of-sql are returned.

## Dataset
This dataset contains 1 table. 
### Using PostgreSQL
**input**

```sql
SELECT *
FROM web_requests ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-20/blob/main/web.PNG)

### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-20/blob/main/advent_answer_day20.sql)

**input**
```sql

WITH CTE AS (SELECT request_id, url,
				split_part(UNNEST(string_to_array(split_part(url,'?', 2), '&')), '=', 1) AS key,
				split_part(UNNEST(string_to_array(split_part(url,'?', 2), '&')), '=', 2) AS value
			FROM web_requests
			WHERE url LIKE '%utm%source%advent%of%sql%')
	SELECT url, json_object_agg(key, value) as query_parameters, COUNT(DISTINCT key) AS count_query_params
	FROM CTE
	GROUP BY url
	ORDER BY count_query_params DESC, url ASC ;

```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-20/blob/main/d20.PNG)
