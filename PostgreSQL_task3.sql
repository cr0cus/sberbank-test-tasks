WITH transactions AS (
    SELECT 
  		from_account AS acc,
  		-amount AS change,
  		tdate
    FROM transfers
    UNION ALL
    SELECT 
  		to_account AS acc,
  		amount AS change,
  		tdate
    FROM transfers
),
cumulative_balance AS (
    SELECT 
        acc, 
        tdate, 
        SUM(change) OVER (PARTITION BY acc ORDER BY tdate) AS balance
    FROM transactions
),
all_balances AS (
    SELECT 
  		DISTINCT acc,
  		'1970-01-01'::date AS tdate,
  		0 AS balance
    FROM cumulative_balance
    UNION ALL
    SELECT acc, tdate, balance
    FROM cumulative_balance
),
periods AS (
    SELECT 
        acc, 
        tdate AS dt_from, 
        LEAD(tdate, 1, '3000-01-01'::date) OVER (PARTITION BY acc ORDER BY tdate) AS dt_to, 
        balance
    FROM all_balances
)

SELECT acc, dt_from, dt_to, balance
FROM periods
WHERE balance != 0
ORDER BY acc, dt_from