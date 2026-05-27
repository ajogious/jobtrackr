-- ============================================================
-- V1: Initial schema - users, roles, user_roles
-- ============================================================

-- USERS table
CREATE TABLE users (
    id                      BIGSERIAL PRIMARY KEY,
    email                   VARCHAR(255) NOT NULL UNIQUE,
    first_name              VARCHAR(100) NOT NULL,
    last_name               VARCHAR(100) NOT NULL,
    password                VARCHAR(255) NOT NULL,
    is_enabled              BOOLEAN NOT NULL DEFAULT TRUE,
    is_account_non_locked   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);

-- Index on email - we query by email on every login
CREATE INDEX idx_users_email ON users(email);

-- ============================================================

-- ROLES table
CREATE TABLE roles (
    id      BIGSERIAL PRIMARY KEY,
    name    VARCHAR(50) NOT NULL UNIQUE
);

-- ============================================================

-- USER_ROLES join table (many-to-many)
CREATE TABLE user_roles (
    user_id     BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role_id     BIGINT NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

-- ============================================================

-- Seed default roles - these must always exist
INSERT INTO roles (name) VALUES ('ROLE_USER');
INSERT INTO roles (name) VALUES ('ROLE_ADMIN');