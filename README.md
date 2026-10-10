# Leavehub — Employee Leave & Approval Management System

## 1. Project Overview
Leavehub replaces a manual, email/spreadsheet-based leave process with a self-service system covering employees, managers, and HR administrators.

## 2. Business Problem
Leave requests submitted by email get lost, balances are tracked in spreadsheets and go out of sync, managers have no visibility into team coverage, and HR has no real-time reporting. See [`docs/business-requirements.md`](docs/business-requirements.md) for the full breakdown.

## 3. Proposed Solution
A role-based web application where employees submit requests against an automatically-validated leave balance, managers approve/reject with full team-calendar context, and HR gets real-time company-wide reporting — with every action captured in an immutable audit log.

## 4. Objectives
- Cut average approval turnaround from ~3 days to under 24 hours
- Eliminate manual leave-balance errors
- Give HR real-time reporting without manual spreadsheet compilation
- Provide a full audit trail for compliance

## 5. Stakeholders
Employees, Line Managers, HR Administrators, IT/Systems Owner, Executive/Finance. Detail in [`docs/business-requirements.md`](docs/business-requirements.md).

## 6. Requirements
Full functional/non-functional requirements, user stories, use cases, and acceptance criteria: [`docs/functional-requirements.md`](docs/functional-requirements.md).

## 7. Business Process
AS-IS and TO-BE process flows (BPMN-style, Mermaid diagrams): [`docs/process-analysis.md`](docs/process-analysis.md).

## 8. Database Design
- Schema (DDL): [`database/schema.sql`](database/schema.sql)
- Sample data: [`database/seed.sql`](database/seed.sql)
- Reporting queries: [`database/queries.sql`](database/queries.sql)

**Entities:** `departments`, `roles`, `employees` (self-referencing manager_id), `leave_types`, `leave_balances`, `leave_requests`, `audit_log`, `notifications`.

## 9. Technologies
- **Database:** PostgreSQL (schema uses generated columns, CHECK constraints, foreign keys)
- **Frontend prototype:** HTML/CSS/vanilla JS (single-file, no build step — see below on why)
- **Diagrams:** Mermaid (renders natively on GitHub)

> **Note on the prototype:** the working prototype in `frontend/index.html` simulates the same schema as `database/schema.sql` in-memory (no live backend), so it can run instantly with zero setup for demo/review purposes. It is structured so that each in-memory operation (submit, approve, reject, balance deduction, audit logging) maps directly onto a real query in `database/queries.sql` and a future FastAPI/Express backend.

## 10. Features
- Role switcher (Employee / Manager / HR Admin) for demo purposes
- Employee: submit request with live balance validation, view/cancel own requests
- Manager: approve/reject direct reports' requests with comments, team overview
- HR Admin: company-wide reports (by department, by leave type, approval rate, low-balance alerts)
- Full audit trail view, immutable log entries

## 11. Screenshots
See `screenshots/` (add after running the demo).

## 12. Installation
No installation needed for the prototype — it's a static HTML file.
```
open frontend/index.html   # or double-click the file
```
For the database:
```
psql -U youruser -d leavehub -f database/schema.sql
psql -U youruser -d leavehub -f database/seed.sql
```

## 13. How to Run
1. Open `frontend/index.html` in any browser.
2. Use the **"Viewing as"** dropdown in the sidebar to switch between an Employee, a Manager, and the HR Admin to see each role's view.
3. As an employee, go to **New Request** → submit a leave request → watch balance validation happen live.
4. Switch to that employee's manager → go to **Approvals** → approve or reject → balance updates automatically.
5. Switch to the HR Admin → **HR Reports** → see company-wide numbers update in real time.
6. **Audit Trail** shows every action logged.

## 14. Testing
Manual test cases executed against the prototype (see `docs/test-cases.md` for full list): submission validation, insufficient-balance rejection, approval balance deduction, cancellation, role-based navigation, audit logging.

## 15. Results
The prototype demonstrates the full TO-BE process end-to-end: request → validation → approval/rejection → balance update → audit trail → reporting, with zero manual spreadsheet handling.

## 16. Business Value
Projected 5–8 admin hours/week saved in HR leave administration, elimination of leave-balance disputes, and full BCEA-aligned audit trail. Detail in [`docs/business-requirements.md`](docs/business-requirements.md#7-expected-business-benefits).

## 17. Future Improvements
- Replace in-memory data with a live PostgreSQL backend (FastAPI) using the existing schema
- Add email notifications (currently modelled in schema but not wired up)
- Add a real team leave calendar (visual, not just tabular)
- Multi-stage approval chains for senior roles
- Public holiday calendar integration per region
