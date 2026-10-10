-- =========================================================
-- Reporting & operational queries
-- =========================================================

-- 1. Current leave balance per employee (all types)
SELECT e.first_name, e.last_name, lt.type_name, lb.days_accrued, lb.days_used, lb.days_available
FROM leave_balances lb
JOIN employees e ON e.employee_id = lb.employee_id
JOIN leave_types lt ON lt.leave_type_id = lb.leave_type_id
WHERE lb.year = 2026
ORDER BY e.last_name;

-- 2. All pending requests for a given manager's direct reports
SELECT lr.request_id, e.first_name, e.last_name, lt.type_name, lr.start_date, lr.end_date, lr.days_requested
FROM leave_requests lr
JOIN employees e ON e.employee_id = lr.employee_id
JOIN leave_types lt ON lt.leave_type_id = lr.leave_type_id
WHERE lr.status = 'Pending' AND e.manager_id = 1;   -- manager_id parameter

-- 3. Department-level leave usage report
SELECT d.department_name, lt.type_name, SUM(lr.days_requested) AS total_days_taken
FROM leave_requests lr
JOIN employees e ON e.employee_id = lr.employee_id
JOIN departments d ON d.department_id = e.department_id
JOIN leave_types lt ON lt.leave_type_id = lr.leave_type_id
WHERE lr.status = 'Approved'
GROUP BY d.department_name, lt.type_name
ORDER BY d.department_name;

-- 4. Average approval turnaround time (in hours)
SELECT ROUND(AVG(EXTRACT(EPOCH FROM (decided_at - submitted_at)) / 3600), 1) AS avg_hours_to_decide
FROM leave_requests
WHERE status IN ('Approved', 'Rejected');

-- 5. Employees with low remaining annual leave (< 3 days)
SELECT e.first_name, e.last_name, lb.days_available
FROM leave_balances lb
JOIN employees e ON e.employee_id = lb.employee_id
JOIN leave_types lt ON lt.leave_type_id = lb.leave_type_id
WHERE lt.type_name = 'Annual' AND lb.days_available < 3 AND lb.year = 2026;

-- 6. Monthly leave requests trend
SELECT DATE_TRUNC('month', submitted_at) AS month, COUNT(*) AS requests_submitted
FROM leave_requests
GROUP BY 1
ORDER BY 1;

-- 7. Rejection rate by manager
SELECT m.first_name, m.last_name,
       COUNT(*) FILTER (WHERE lr.status = 'Rejected') AS rejected,
       COUNT(*) AS total_decided,
       ROUND(100.0 * COUNT(*) FILTER (WHERE lr.status = 'Rejected') / NULLIF(COUNT(*), 0), 1) AS rejection_pct
FROM leave_requests lr
JOIN employees m ON m.employee_id = lr.decided_by
WHERE lr.status IN ('Approved','Rejected')
GROUP BY m.first_name, m.last_name;

-- 8. Full audit trail for a specific request
SELECT al.action, al.action_at, e.first_name, e.last_name, al.details
FROM audit_log al
JOIN employees e ON e.employee_id = al.actor_id
WHERE al.request_id = 1
ORDER BY al.action_at;

-- 9. Team calendar: who is on approved leave in a date range
SELECT e.first_name, e.last_name, lr.start_date, lr.end_date, lt.type_name
FROM leave_requests lr
JOIN employees e ON e.employee_id = lr.employee_id
JOIN leave_types lt ON lt.leave_type_id = lr.leave_type_id
WHERE lr.status = 'Approved'
  AND lr.start_date <= '2026-06-30' AND lr.end_date >= '2026-01-01'
ORDER BY lr.start_date;

-- 10. Headcount-adjusted leave liability (paid leave days outstanding, valued conceptually)
SELECT d.department_name, SUM(lb.days_available) AS outstanding_paid_leave_days
FROM leave_balances lb
JOIN employees e ON e.employee_id = lb.employee_id
JOIN departments d ON d.department_id = e.department_id
JOIN leave_types lt ON lt.leave_type_id = lb.leave_type_id
WHERE lt.is_paid = TRUE AND lb.year = 2026
GROUP BY d.department_name;
