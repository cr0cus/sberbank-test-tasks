WITH RECURSIVE random_dates AS (
    SELECT CURRENT_DATE AS check_date, 1 AS n
    UNION ALL
    SELECT check_date + (floor(random() * 6 + 2))::int, n + 1
    FROM random_dates
    WHERE n < 100
)
SELECT check_date
FROM random_dates;