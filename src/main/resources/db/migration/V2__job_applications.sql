-- ============================================================
-- V2: Job applications table
-- ============================================================

-- Status ENUM-like constraint — only these values allowed
CREATE TYPE application_status AS ENUM (
    'SAVED',
    'APPLIED',
    'PHONE_SCREEN',
    'INTERVIEW',
    'TECHNICAL_TEST',
    'OFFER',
    'REJECTED',
    'WITHDRAWN',
    'GHOSTED'
);

CREATE TYPE application_priority AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH'
);

-- ============================================================

CREATE TABLE job_applications (
    id                  BIGSERIAL PRIMARY KEY,
    user_id             BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    -- Job details
    company_name        VARCHAR(255) NOT NULL,
    job_title           VARCHAR(255) NOT NULL,
    job_url             TEXT,
    location            VARCHAR(255),
    is_remote           BOOLEAN NOT NULL DEFAULT FALSE,

    -- Tracking
    status              application_status NOT NULL DEFAULT 'SAVED',
    priority            application_priority NOT NULL DEFAULT 'MEDIUM',
    notes               TEXT,

    -- Salary range (optional — not all jobs share this)
    salary_min          DECIMAL(15, 2),
    salary_max          DECIMAL(15, 2),

    -- Important dates
    applied_date        DATE,
    interview_date      TIMESTAMP WITHOUT TIME ZONE,

    -- Audit
    created_at          TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Indexes — fields we will filter/sort by frequently

-- Find all applications for a user (most common query)
CREATE INDEX idx_job_applications_user_id
    ON job_applications(user_id);

-- Filter by status (dashboard analytics)
CREATE INDEX idx_job_applications_status
    ON job_applications(status);

-- Filter by user + status together (most common filtered query)
CREATE INDEX idx_job_applications_user_status
    ON job_applications(user_id, status);