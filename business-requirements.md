# Business Requirements Document
## Employee Leave & Approval Management System

### 1. Project Overview
A medium-sized company (150–300 employees) currently manages employee leave requests through email and shared spreadsheets. This document defines the business case and requirements for replacing that process with a purpose-built Leave Management System (LMS).

### 2. Business Problem
The current manual process causes:

| Issue | Impact |
|---|---|
| Requests submitted via email/WhatsApp | Requests get lost or missed in busy inboxes |
| Manual approval by reply-email | No audit trail, no SLA on approval time |
| Spreadsheet-based leave balances | Balances go out of sync; errors in calculation |
| No visibility for HR | HR cannot see company-wide leave trends without manually compiling data |
| No visibility for managers | Managers can't see team availability before approving overlapping leave |
| Manual reporting | Month-end/​year-end leave reporting takes days of manual spreadsheet work |

### 3. Business Objectives
1. Reduce average leave-approval turnaround from ~3 days to under 24 hours.
2. Eliminate leave-balance calculation errors.
3. Give managers real-time visibility of team availability.
4. Give HR a single source of truth for leave data and reporting.
5. Provide a full audit trail for compliance (BCEA leave record-keeping requirements).

### 4. Stakeholders

| Stakeholder | Interest |
|---|---|
| Employees | Submit requests quickly, see accurate balances |
| Line Managers | Approve/reject requests, see team calendar, avoid coverage gaps |
| HR Administrators | Configure leave policies, generate reports, manage exceptions |
| IT/Systems Owner | Reliable, secure, low-maintenance system |
| Executive/Finance | Leave liability reporting, headcount planning |

### 5. Scope

**In scope:**
- Annual, sick, family responsibility, and unpaid leave types
- Employee self-service leave request and cancellation
- Manager approval/rejection workflow with comments
- Automatic leave balance calculation and accrual
- Email/in-app notifications on status change
- Audit trail of all actions
- HR/manager reporting and dashboards

**Out of scope (Phase 1):**
- Payroll system integration
- Public holiday calendar sync per country/region
- Multi-level (2+ stage) approval chains

### 6. Business Rules
1. Employees accrue 1.25 days of annual leave per completed month (15 days/year), per South African BCEA minimum.
2. Sick leave: 30 days per 3-year cycle (simplified to an annual pro-rata balance for this system).
3. A leave request cannot be submitted for a balance the employee does not have, except unpaid leave.
4. Only a direct manager can approve/reject their direct reports' requests.
5. Once approved, a leave request can only be cancelled with HR involvement if within 48 hours of the start date.
6. All state changes (submitted, approved, rejected, cancelled) must be logged with timestamp and actor.

### 7. Expected Business Benefits
- **Efficiency:** Estimated 5–8 admin hours/week saved in HR leave administration.
- **Accuracy:** Removal of manual spreadsheet errors in balance tracking.
- **Compliance:** Full audit trail supports BCEA record-keeping obligations.
- **Employee experience:** Self-service visibility into balances and request status.
- **Planning:** Managers can see team leave calendars to avoid coverage gaps.

### 8. Success Metrics
| Metric | Baseline | Target |
|---|---|---|
| Average approval time | ~3 days | < 1 day |
| Leave balance disputes/month | ~4 | 0 |
| HR admin time on leave/week | ~7 hrs | < 2 hrs |
