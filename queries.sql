-- Members Table
-- Find the youngest active member in the Gym
SELECT * FROM "members"
WHERE "status" = 'Active'
ORDER BY "age" ASC LIMIT 1;

-- Find the oldest active member in the Gym
SELECT * FROM "members"
WHERE "status" = 'Active'
ORDER BY "age" DESC LIMIT 1;

-- Find the total count of active members
SELECT COUNT("status") AS "active_members"
FROM "members"
WHERE "status" = 'Active';

-- Find the total count of non-active members
SELECT COUNT("status") AS "non-active_members"
FROM "members"
WHERE "status" = 'Non-Active';

-- Find the avg age of members
SELECT AVG("age") AS "avgerage_age"
FROM "members";

-- Find the names of members present on Jan 1st 2026
SELECT "members"."first_name", "members"."last_name"
FROM "members"
JOIN "attendance" ON
    "members"."id" = "attendance"."member_id"
WHERE "attendance"."status" = 'Present' AND "attendance"."date" = '2026-01-01'
ORDER BY "members"."first_name" ASC;

-- Find how much fee each member has paid for gym membership with their names in ascending order
SELECT "members"."first_name", "members"."last_name", "payments"."amount"
FROM "members"
JOIN "payments" ON
    "members"."id" = "payments"."member_id"
ORDER BY "members"."first_name" ASC;

-- Update the status to 'Active' of member named 'Kunal Mehta'
UPDATE "members"
SET "status" = 'Active'
WHERE "first_name" = 'Kunal' AND "last_name" = 'Mehta';


-- Trainers Table
-- Find the trainers with above 5 years of experience
SELECT * FROM "trainers"
WHERE "experience_years" >= 5
ORDER BY "age" ASC;

-- Find trainers with below 5 years of experience
SELECT * FROM "trainers"
WHERE "experience_years" <= 5
ORDER BY "age" ASC;

-- Find the avg years of experience of trainers
SELECT AVG("experience_years") AS 'Average_experience'
FROM "trainers";

-- Find the workout plans assigned to each trainer
SELECT "trainers"."first_name", "trainers"."last_name", "workout_plans"."plan_name"
FROM "trainers"
JOIN "workout_plans" ON
    "trainers"."id" = "workout_plans"."trainer_id"
ORDER BY "trainers"."first_name";


-- Workout Plan Table
-- Find all the workout plans in the gym
SELECT "id", "plan_name" FROM workout_plans;

-- Find the workout plans assigned to each trainer
SELECT * FROM "workout_plans"
ORDER BY "trainer_id" ASC;


-- Attendance Table
-- Find the members who were present on Jan 1st 2026
SELECT * FROM "attendance"
WHERE "date" = '2026-01-01' AND "status" = 'Present';


-- Payments Table
-- Find the avg fee for gym membership
SELECT AVG("amount") AS 'Average Gym Fee'
FROM "payments";

-- Find the total amount collected in a month
SELECT SUM("amount") AS 'Collected Amount'
FROM "payments"
WHERE "date" LIKE '2025-12-%';

-- Find the total number of days a member was present in gym and how much fee they paid for the gym membership
SELECT "members"."first_name", "members"."last_name", COUNT("attendance"."status") AS 'Total Present days', "payments"."amount"
FROM "members"
JOIN "attendance" ON
    "members"."id" = "attendance"."member_id"
JOIN "payments" ON
    "members"."id" = "payments"."member_id"
WHERE "attendance"."status" = 'Present'
GROUP BY "members"."id"
ORDER BY "members"."first_name" ASC;

-- Find members who have made more than one payment.
SELECT "members"."first_name", "members"."last_name", COUNT("payments"."id") AS 'total_payments'
FROM "members"
JOIN "payments" ON
    "members"."id" = "payments"."member_id"
WHERE 'total_payments' > 1
GROUP BY "member"."id"
HAVING COUNT("payments"."id") > 1;

-- List all payments along with the member’s name who made them.
SELECT "members"."first_name", "members"."last_name", "payments"."amount", "payments"."date"
FROM "members"
JOIN "payments" ON
    "members"."id" = "payments"."member_id";

-- List trainers who handle more than one workout plan.
SELECT "trainers"."first_name", "trainers"."last_name", "workout_plans"."plan_name", COUNT("workout_plans"."id") AS 'total_plans'
FROM "trainers"
JOIN "workout_plans" ON
    "trainers"."id" = "workout_plans"."trainer_id"
GROUP BY "trainers"."id"
HAVING COUNT("workout_plans"."id") > 1;



