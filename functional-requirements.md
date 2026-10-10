# Functional & Non-Functional Requirements
## Employee Leave & Approval Management System

### 1. Functional Requirements

| ID | Requirement | Priority |
|---|---|---|
| FR-01 | Employee can log in and view their leave balances by type | Must |
| FR-02 | Employee can submit a leave request (type, start date, end date, reason) | Must |
| FR-03 | System auto-calculates working days requested (excludes weekends) | Must |
| FR-04 | System validates request against available balance before submission | Must |
| FR-05 | Employee can view status (Pending/Approved/Rejected) of their requests | Must |
| FR-06 | Employee can cancel a Pending request | Must |
| FR-07 | Manager can view all pending requests from direct reports | Must |
| FR-08 | Manager can approve or reject a request with an optional comment | Must |
| FR-09 | System deducts balance automatically on approval | Must |
| FR-10 | Manager can view a team leave calendar | Should |
| FR-11 | HR Admin can view/edit any employee's leave balance | Must |
| FR-12 | HR Admin can view company-wide leave reports (by dept, type, date range) | Must |
| FR-13 | System logs every action to an audit trail (who, what, when) | Must |
| FR-14 | System sends a notification on status change | Should |
| FR-15 | System accrues annual leave monthly per employee | Should |

### 2. Non-Functional Requirements

| ID | Requirement |
|---|---|
| NFR-01 | System must support at least 300 concurrent users without degraded response time |
| NFR-02 | Page response time under 2 seconds for 95% of requests |
| NFR-03 | All passwords stored hashed (never plaintext) |
| NFR-04 | Role-based access control: Employee, Manager, HR Admin |
| NFR-05 | Audit log entries must be immutable (no delete/edit) |
| NFR-06 | System available 99.5% during business hours |
| NFR-07 | Data backed up daily |

### 3. User Stories

- **US-01** — As an employee, I want to submit a leave request, so that I don't need to email my manager.
- **US-02** — As an employee, I want to see my remaining leave balance, so that I know how much I can request.
- **US-03** — As a manager, I want to see all pending requests from my team in one place, so I can act on them quickly.
- **US-04** — As a manager, I want to see who on my team is already on leave during a requested period, so I can avoid coverage gaps.
- **US-05** — As an HR admin, I want to generate a leave report by department, so I can report to management monthly.
- **US-06** — As an HR admin, I want to correct an employee's leave balance, so I can fix onboarding/migration errors.
- **US-07** — As an employee, I want to be notified when my request is approved or rejected, so I don't have to keep checking.

### 4. Use Cases

**UC-01: Submit Leave Request**
- **Actor:** Employee
- **Precondition:** Employee is logged in and has sufficient balance
- **Main flow:** Employee selects leave type → enters dates → system calculates days → system checks balance → employee confirms → request status set to Pending → manager notified
- **Alternate flow:** Insufficient balance → system blocks submission and shows shortfall

**UC-02: Approve/Reject Leave Request**
- **Actor:** Manager
- **Precondition:** Request exists with status Pending, manager is the requester's direct manager
- **Main flow:** Manager opens pending request → reviews team calendar → approves or rejects with comment → balance updated if approved → employee notified → audit log entry created

**UC-03: Generate Leave Report**
- **Actor:** HR Admin
- **Main flow:** HR Admin selects date range and filters (dept/type) → system aggregates data → report displayed/exported

### 5. Acceptance Criteria (example — US-01)
- Given an employee with 10 days annual leave available
- When they request 12 days of annual leave
- Then the system rejects the request and shows "Insufficient balance: 10 days available, 12 requested"
