WITH CTE AS (SELECT request_id, url,
				split_part(UNNEST(string_to_array(split_part(url,'?', 2), '&')), '=', 1) AS key,
				split_part(UNNEST(string_to_array(split_part(url,'?', 2), '&')), '=', 2) AS value
			FROM web_requests
			WHERE url LIKE '%utm%source%advent%of%sql%')
	SELECT url, json_object_agg(key, value) as query_parameters, COUNT(DISTINCT key) AS count_query_params
	FROM CTE
	GROUP BY url
	ORDER BY count_query_params DESC, url ASC
	LIMIT 1 ;