-- =========================================================
-- Employee Leave & Approval Management System
-- Database Schema (PostgreSQL syntax)
-- =========================================================

CREATE TABLE departments (
    department_id   SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE roles (
    role_id   SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE  -- Employee, Manager, HR Admin
);

CREATE TABLE employees (
    employee_id     SERIAL PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    role_id         INT NOT NULL REFERENCES roles(role_id),
    department_id   INT NOT NULL REFERENCES departments(department_id),
    manager_id      INT REFERENCES employees(employee_id),  -- self-referencing
    hire_date       DATE NOT NULL,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE leave_types (
    leave_type_id   SERIAL PRIMARY KEY,
    type_name       VARCHAR(50) NOT NULL UNIQUE,  -- Annual, Sick, Family Responsibility, Unpaid
    is_paid         BOOLEAN NOT NULL DEFAULT TRUE,
    default_annual_days NUMERIC(5,2) NOT NULL
);

CREATE TABLE leave_balances (
    balance_id      SERIAL PRIMARY KEY,
    employee_id     INT NOT NULL REFERENCES employees(employee_id),
    leave_type_id   INT NOT NULL REFERENCES leave_types(leave_type_id),
    year            INT NOT NULL,
    days_accrued    NUMERIC(5,2) NOT NULL DEFAULT 0,
    days_used       NUMERIC(5,2) NOT NULL DEFAULT 0,
    days_available  NUMERIC(5,2) GENERATED ALWAYS AS (days_accrued - days_used) STORED,
    UNIQUE (employee_id, leave_type_id, year)
);

CREATE TABLE leave_requests (
    request_id      SERIAL PRIMARY KEY,
    employee_id     INT NOT NULL REFERENCES employees(employee_id),
    leave_type_id   INT NOT NULL REFERENCES leave_types(leave_type_id),
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    days_requested  NUMERIC(5,2) NOT NULL,
    reason          TEXT,
    status          VARCHAR(20) NOT NULL DEFAULT 'Pending'
                    CHECK (status IN ('Pending','Approved','Rejected','Cancelled')),
    submitted_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    decided_by      INT REFERENCES employees(employee_id),
    decided_at      TIMESTAMP,
    manager_comment TEXT
);

CREATE TABLE audit_log (
    audit_id        SERIAL PRIMARY KEY,
    request_id      INT REFERENCES leave_requests(request_id),
    actor_id        INT NOT NULL REFERENCES employees(employee_id),
    action          VARCHAR(50) NOT NULL,  -- Submitted, Approved, Rejected, Cancelled, BalanceAdjusted
    action_at       TIMESTAMP NOT NULL DEFAULT NOW(),
    details         TEXT
);

CREATE TABLE notifications (
    notification_id SERIAL PRIMARY KEY,
    employee_id     INT NOT NULL REFERENCES employees(employee_id),
    request_id      INT REFERENCES leave_requests(request_id),
    message         TEXT NOT NULL,
    is_read         BOOLEAN NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Helpful indexes
CREATE INDEX idx_requests_employee ON leave_requests(employee_id);
CREATE INDEX idx_requests_status ON leave_requests(status);
CREATE INDEX idx_balances_employee_year ON leave_balances(employee_id, year);
