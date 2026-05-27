-- ============================================================
-- V3: Documents table (resumes, cover letters, etc.)
-- ============================================================

CREATE TYPE document_type AS ENUM (
    'RESUME',
    'COVER_LETTER',
    'PORTFOLIO',
    'CERTIFICATE',
    'OTHER'
);

CREATE TABLE documents (
    id                      BIGSERIAL PRIMARY KEY,
    user_id                 BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    job_application_id      BIGINT REFERENCES job_applications(id) ON DELETE SET NULL,
    file_name               VARCHAR(255) NOT NULL,
    file_path               TEXT NOT NULL,
    file_type               VARCHAR(100) NOT NULL,
    file_size               BIGINT NOT NULL,
    document_type           document_type NOT NULL DEFAULT 'RESUME',
    created_at              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_documents_user_id ON documents(user_id);

CREATE INDEX idx_documents_job_application_id ON documents(job_application_id);