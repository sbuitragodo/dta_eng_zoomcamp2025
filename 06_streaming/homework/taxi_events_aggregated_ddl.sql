DROP TABLE taxi_events_aggregated;

CREATE TABLE IF NOT EXISTS taxi_events_aggregated (
	event_hour TIMESTAMP(3),
	PULocationID INTEGER,
	DOLocationID INTEGER,
	num_hits BIGINT
);

ALTER TABLE taxi_events_aggregated ADD CONSTRAINT taxi_events_pk PRIMARY KEY (event_hour, PULocationID, DOLocationID);

SELECT count(1) cnt FROM taxi_events_aggregated;

select event_hour, PULocationID, DOLocationID, count(1) cnt
from taxi_events_aggregated
group by 1, 2, 3
having count(1) > 1;

SELECT PULocationID, DOLocationID, SUM(num_hits) total
FROM taxi_events_aggregated
GROUP BY 1, 2
ORDER BY total DESC;