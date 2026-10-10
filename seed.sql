-- =========================================================
-- Seed data — realistic sample company
-- =========================================================

INSERT INTO departments (department_name) VALUES
('IT'), ('Finance'), ('Sales'), ('HR'), ('Operations');

INSERT INTO roles (role_name) VALUES
('Employee'), ('Manager'), ('HR Admin');

INSERT INTO leave_types (type_name, is_paid, default_annual_days) VALUES
('Annual', TRUE, 15),
('Sick', TRUE, 10),
('Family Responsibility', TRUE, 3),
('Unpaid', FALSE, 0);

-- Managers first (manager_id NULL initially)
INSERT INTO employees (first_name, last_name, email, password_hash, role_id, department_id, manager_id, hire_date) VALUES
('Thandiwe', 'Nkosi', 'thandiwe.nkosi@company.co.za', 'hashed_pw_1', 2, 1, NULL, '2019-03-01'),   -- IT Manager
('Pieter', 'van Wyk', 'pieter.vanwyk@company.co.za', 'hashed_pw_2', 2, 3, NULL, '2018-06-15'),    -- Sales Manager
('Naledi', 'Dube', 'naledi.dube@company.co.za', 'hashed_pw_3', 3, 4, NULL, '2017-01-10');         -- HR Admin

-- Employees reporting to the managers above
INSERT INTO employees (first_name, last_name, email, password_hash, role_id, department_id, manager_id, hire_date) VALUES
('Sipho', 'Mahlangu', 'sipho.mahlangu@company.co.za', 'hashed_pw_4', 1, 1, 1, '2022-02-01'),
('Aisha', 'Patel', 'aisha.patel@company.co.za', 'hashed_pw_5', 1, 1, 1, '2021-09-12'),
('Johan', 'Botha', 'johan.botha@company.co.za', 'hashed_pw_6', 1, 3, 2, '2020-11-03'),
('Lerato', 'Molefe', 'lerato.molefe@company.co.za', 'hashed_pw_7', 1, 3, 2, '2023-01-20');

-- Leave balances for 2026
INSERT INTO leave_balances (employee_id, leave_type_id, year, days_accrued, days_used) VALUES
(4, 1, 2026, 15, 4), (4, 2, 2026, 10, 1),
(5, 1, 2026, 15, 6), (5, 2, 2026, 10, 0),
(6, 1, 2026, 15, 2), (6, 2, 2026, 10, 3),
(7, 1, 2026, 15, 0), (7, 2, 2026, 10, 0);

-- Sample leave requests
INSERT INTO leave_requests (employee_id, leave_type_id, start_date, end_date, days_requested, reason, status, decided_by, decided_at, manager_comment) VALUES
(4, 1, '2026-03-10', '2026-03-14', 5, 'Family trip', 'Approved', 1, '2026-02-20 09:15:00', 'Approved, team coverage fine'),
(5, 2, '2026-01-05', '2026-01-05', 1, 'Not feeling well', 'Approved', 1, '2026-01-05 08:00:00', NULL),
(6, 1, '2026-04-01', '2026-04-02', 2, 'Personal', 'Rejected', 2, '2026-03-25 10:00:00', 'Clashes with month-end reporting'),
(7, 1, '2026-05-15', '2026-05-20', 4, 'Vacation', 'Pending', NULL, NULL, NULL);

INSERT INTO audit_log (request_id, actor_id, action, details) VALUES
(1, 4, 'Submitted', 'Employee submitted annual leave request'),
(1, 1, 'Approved', 'Manager approved request'),
(3, 6, 'Submitted', 'Employee submitted annual leave request'),
(3, 2, 'Rejected', 'Manager rejected due to month-end reporting clash'),
(4, 7, 'Submitted', 'Employee submitted annual leave request, awaiting decision');
