# Farm Tracker — System Architecture

This document describes the design, folder layout, data flow, and technical implementation details of the **Farm & Rental Tracker** application.

---

## 1. Directory Structure

The project is structured as follows:

```
farm-tracker/
├── frontend/
│   └── farm-tracker.html     # Single Page Application (HTML, CSS, JS)
├── backend/
│   └── supabase/
│       ├── schema.sql        # Database table schemas
│       └── policies.sql      # Row Level Security (RLS) policies
├── docs/
│   ├── README-dadi.md        # User guide for non-technical users (Dadi)
│   └── architecture-farm.md  # This architecture overview
└── README.md                 # Top-level project overview
```

---

## 2. Component Design

The application uses a simple **Client-Serverless** architecture, minimizing infrastructure management by delegating database hosting, security, and APIs to Supabase.

```mermaid
graph TD
    Browser["Frontend (farm-tracker.html)"] -- HTTPS / WebSockets -- API_Gateway["Supabase API Gateway"]
    API_Gateway --> DB["PostgreSQL Database"]
    DB --> RLS["Row Level Security Policies"]
```

### A. Frontend (Client-side)
*   **Technologies**: Vanilla HTML5, Vanilla CSS3 (custom styling system with dark green/cream theme tokens), and Vanilla ECMAScript (JavaScript).
*   **Architecture**: Single Page Application (SPA) utilizing DOM replacement based on sidebar navigation states.
*   **Data Store**: Synchronized local variables (`rental`, `matooke`, `coffee`, `expenses`) which mirror database states for instant computations and graph plotting.

### B. Backend (Serverless Supabase)
*   **Database**: PostgreSQL database.
*   **Security (RLS)**: Row Level Security policies ensure that the client-side code (which relies on the publishable `anon` key) can execute queries directly and safely.
*   **API**: REST endpoints automatically exposed by Supabase based on the defined database tables.

---

## 3. Data Flow

### A. Initialization (Page Load)
1.  Browser loads [farm-tracker.html](file:///c:/Users/Raynel/Desktop/farm%20tracker/frontend/farm-tracker.html).
2.  `loadData()` is called asynchronously.
3.  The Supabase Client performs `SELECT *` operations on tables (`rental`, `matooke`, `coffee`, `expenses`).
4.  Local data variables are updated, and the page renders the dashboard charts and data tables.

### B. Creating Records
1.  User enters data in any entry form and submits.
2.  Frontend constructs a payload *omitting* the `id` field.
3.  Payload is inserted into Supabase via `.insert(payload).select()`.
4.  Supabase generates a unique ID, inserts the row, and returns it.
5.  Frontend receives the returned row (with its database ID) and pushes it to local state.
6.  The UI re-renders to display the new entry.

### C. Deleting Records
1.  User clicks the **Remove** button.
2.  Frontend targets the item's database-assigned `id`.
3.  Frontend calls `.delete().eq('id', id)` to delete it from the cloud.
4.  Frontend filters the deleted item from the local state array.
5.  The UI re-renders.

---

## 4. Dependencies & Libraries

All dependencies are loaded via CDN script tags in the frontend to avoid complex build steps:

1.  **Supabase JS Client SDK** (`@supabase/supabase-js`): Provides database queries, filters, and client-side mutations.
2.  **Chart.js** (`chart.js`): Renders responsive bar charts showing monthly, weekly, or daily income versus expenses.
3.  **SheetJS** (`xlsx`): Generates a multi-sheet spreadsheet file on the fly from local JavaScript objects when the user clicks "Export everything (Excel)".
