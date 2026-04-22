# LuxDev Data Analytics Bootcamp — Assignments

SQL, Excel, and Power BI work completed during the LuxDev Data Analytics Programme. The SQL assignments use two practice databases — `nairobi_academy` (a Kenyan secondary school) and `city_hospital` (a hospital management system).

---

### Assignment 1 — Database design and SQL foundations
**File:** `nairobi_academy.sql`

I built the `nairobi_academy` schema from scratch — designed the tables, defined the relationships, inserted data, and then wrote queries against it.

The schema has three tables: `students`, `subjects`, and `exam_results`, linked by foreign keys. After setting it up I practised DDL (adding, renaming, and dropping columns with `alter table`), DML (inserting, updating, and deleting rows), and then a range of filtering queries using `where`, `and`, `or`, `in`, `between`, and `like`.

The more interesting part was using `case when` — first to label exam results as Distinction, Merit, Pass, or Fail based on mark thresholds, and then to classify students as Senior or Junior based on their form.

---

### Assignment 2 — Functions, joins, and window functions
**File:** `SQLAssgnment_Week2.sql`

This one covered a lot of ground across both schemas.

On the functions side: string work like `upper()`, `lower()`, `length()`, `substring()`, and `concat()`; number functions including `round()`, `ceil()`, and `floor()`; and date functions — using `to_char()` to format dates in different ways and `extract(year from age())` to calculate how old each student is from their date of birth.

The joins section used the `city_hospital` schema — doctors, patients, appointments, and prescriptions. I wrote an inner join across four tables to pull appointment details with patient and doctor names and the medicine prescribed. Then a left join to show every patient even if they'd never had an appointment. A right join to show every doctor even if they had no patients. And a left join combined with `where ... is null` to find patients who had genuinely never been seen.

Window functions were the hardest part to wrap my head around but the most satisfying once they clicked. I used `row_number()` to rank exam results, then compared `rank()` and `dense_rank()` side by side to see how they handle ties differently. `ntile(3)` with `case when` grouped results into top, middle, and bottom performance bands. `avg() over(partition by student_id)` showed each student's individual marks alongside their own average. And `lag()` let me compare each result to the student's previous exam to calculate whether they improved.

---

### Assignment 3 — Set operators
**File:** `SET_OPERATORS.sql`

Combining results from the two schemas using `union`, `union all`, and `intersect`.

The most practical query here was using `intersect` to find cities that appear in both the students table and the patients table — cities home to both. The three-way `union all` that merged students, patients, and doctors into one list ordered by source label was also a good exercise in keeping things readable across multiple combined queries.

One thing worth noting: the `city_hospital` schema was set as the active search path, so the `nairobi_academy` tables had to be referenced with explicit schema prefixes throughout.

---

### Assignment 4 — Excel sales analysis
**File:** `JUMIA EXCEL PROJECT.xlsx`

Sales data analysis for Jumia, East Africa's largest e-commerce platform. Data cleaning, pivot tables, charts, and a summary dashboard.

---

### Assignment 5 — Power BI dashboard
**File:** `PowerBI_Project.pbix`

An interactive dashboard built in Power BI — data transformation in Power Query, KPI cards, bar charts, and slicers.

---

These are learning assignments from the LuxDev programme. For independent portfolio work, see my [GitHub profile](https://github.com/JulesInData).
