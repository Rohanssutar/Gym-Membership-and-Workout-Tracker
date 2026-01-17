-- Gym Membership & workout tracker

-- Represents all Members in the Gym
CREATE TABLE "members"(
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER CHECK("age" >= 14),
    "status" TEXT NOT NULL CHECK("status" IN ('Active','Non-Active'))
);

-- Represents a view for all the active members of gym
CREATE VIEW "active_members" AS
SELECT "first_name", "last_name", "age"
FROM "members"
WHERE "status" = 'Active';

-- Represents all Trainers in the Gym
CREATE TABLE "trainers"(
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER CHECK("age" >= 18),
    "experience_years" INTEGER NOT NULL CHECK("experience_years" >= 0)
);

-- Represents all Workout plans available
CREATE TABLE "workout_plans"(
    "id" INTEGER PRIMARY KEY,
    "plan_name" TEXT NOT NULL,
    "trainer_id" INTEGER NOT NULL,
    FOREIGN KEY("trainer_id") REFERENCES "trainers"("id")
);

-- Represents the Attendance of the members
CREATE TABLE "attendance"(
    "id" INTEGER PRIMARY KEY,
    "member_id" INTEGER NOT NULL,
    "date" DATE NOT NULL,
    "status" TEXT CHECK("status" IN ('Absent','Present')),
    FOREIGN KEY("member_id") REFERENCES "members"("id")
);

-- Represents all the Payments done by members
CREATE TABLE "payments"(
    "id" INTEGER PRIMARY KEY,
    "member_id" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL CHECK("amount" > 0),
    "date" DATE NOT NULL,
    FOREIGN KEY("member_id") REFERENCES "members"("id")
);

-- Indexes
CREATE INDEX "member_id_search" ON "payments"("member_id");
CREATE INDEX "trainer_id_search" ON "workout_plans"("trainer_id");

-- Trigger
-- Automatically mark a member as Active after a successful payment
CREATE TRIGGER "activate_member_after_payment"
AFTER INSERT ON "payments"
FOR EACH ROW
BEGIN
    UPDATE "members"
    SET status = 'Active'
    WHERE "id" = NEW.member_id;
END;

-- Trigger execution
INSERT INTO payments (member_id, amount, date)
VALUES (6, 2500, '2026-01-17');


