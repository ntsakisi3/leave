# Process Analysis: AS-IS vs TO-BE
## Employee Leave & Approval Management System

### AS-IS Process (Manual, Email/Spreadsheet-Based)

```mermaid
flowchart TD
    A([Employee needs leave]) --> B[Employee emails manager]
    B --> C{Manager sees email\nin time?}
    C -- No / delayed --> D[Request sits unactioned]
    C -- Yes --> E[Manager checks memory/spreadsheet\nfor team availability]
    E --> F{Approve?}
    F -- No --> G[Manager replies rejecting]
    F -- Yes --> H[Manager replies approving]
    H --> I[Manager manually updates\nshared spreadsheet]
    I --> J[Employee manually checks\nspreadsheet or asks HR]
    J --> K[HR manually compiles\nmonth-end leave report]
    G --> L([End])
    K --> L
    D --> L
```

**Pain points identified:**
1. No system enforces that a request even reaches the manager (email can be missed).
2. No automatic balance check — over-allocation of leave is possible.
3. Spreadsheet updates are manual and error-prone (double entry, no validation).
4. No audit trail — disputes about "who approved what, when" are common.
5. HR reporting requires manually opening and cross-referencing spreadsheets.

---

### TO-BE Process (System-Based)

```mermaid
flowchart TD
    A([Employee needs leave]) --> B[Employee submits request in LMS]
    B --> C{System validates\nbalance available}
    C -- Insufficient --> D[System blocks request,\nshows shortfall]
    C -- Sufficient --> E[Request status: Pending\nManager notified]
    E --> F[Manager reviews request\n+ team calendar in LMS]
    F --> G{Manager decision}
    G -- Reject --> H[Status: Rejected\nEmployee notified\nAudit log entry]
    G -- Approve --> I[Status: Approved\nBalance auto-deducted\nEmployee notified\nAudit log entry]
    I --> J[Leave appears on\nteam calendar automatically]
    H --> K([End])
    J --> L[HR views real-time\ndashboards/reports]
    L --> K
    D --> K
```

**Improvements delivered:**
1. Every request is captured in the system — nothing gets lost in inboxes.
2. Balance validation happens automatically before submission.
3. Managers get calendar visibility, reducing coverage clashes.
4. Every action is logged automatically — full audit trail.
5. HR reporting is real-time, no manual compilation.

### Process Comparison Summary

| Aspect | AS-IS | TO-BE |
|---|---|---|
| Request channel | Email | Self-service system |
| Balance check | Manual/none | Automatic |
| Approval turnaround | ~3 days | < 24 hours (target) |
| Team visibility | None | Real-time calendar |
| Audit trail | None | Full, immutable log |
| Reporting | Manual spreadsheet compilation | Real-time dashboard |
