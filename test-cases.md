# Test Cases — Prototype Validation

| ID | Test | Steps | Expected | Result |
|---|---|---|---|---|
| TC-01 | Submit valid request | Employee (Sipho, 11 days Annual available) requests 3 days Annual | Request created, status Pending, appears in "My Requests" | Pass |
| TC-02 | Reject over-allocation | Employee requests more Annual days than available balance | System blocks with "Insufficient balance: X available, Y requested" | Pass |
| TC-03 | Working-day calculation | Request spans a weekend (e.g. Fri–Mon) | Weekend days excluded from day count | Pass |
| TC-04 | Manager approval | Manager approves a Pending request | Status → Approved, balance `days_used` increases, audit entry logged | Pass |
| TC-05 | Manager rejection | Manager rejects a Pending request with a comment | Status → Rejected, comment visible to employee, balance unchanged | Pass |
| TC-06 | Employee cancellation | Employee cancels their own Pending request | Status → Cancelled, removed from manager's pending queue | Pass |
| TC-07 | Role-based navigation | Switch role to Employee | "Approvals" and "HR Reports" nav items hidden | Pass |
| TC-08 | HR reporting aggregation | Approve requests across departments, view HR Reports | Department/leave-type totals update correctly | Pass |
| TC-09 | Audit trail immutability | Perform submit → approve on a request | Both actions appear in Audit Trail in chronological order, no edit/delete option present | Pass |
| TC-10 | Unpaid leave has no balance cap | Request Unpaid leave for any number of days | Request allowed regardless of balance (balance check skipped for Unpaid type) | Pass |

**Environment:** Manual testing in-browser against `frontend/index.html` (in-memory data store), cross-checked against the business rules in `docs/business-requirements.md` §6 and the SQL logic in `database/queries.sql`.

**Known limitation:** the prototype resets to seed data on page refresh, since it has no persistent backend yet (see README §17, Future Improvements).
