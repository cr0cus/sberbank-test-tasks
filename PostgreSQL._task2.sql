SELECT
    emp.id,
    emp.name,
    COUNT(s.id) AS sales_c,
    DENSE_RANK() OVER (ORDER BY  COUNT(s.id) DESC) AS sales_rank_c,
    SUM(s.price) AS sales_s,
    DENSE_RANK() OVER (ORDER BY SUM(s.price) DESC) AS sales_rank_s
FROM employee emp
LEFT JOIN sales s ON emp.id = s.employee_id
GROUP BY emp.id