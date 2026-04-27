-- +goose Up
CREATE TABLE public.users (
    id UUID NOT NULL,
    email CITEXT NOT NULL,
    password_hash TEXT NOT NULL,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'subscriber',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE public.users ADD CONSTRAINT users_id_pk PRIMARY KEY (id);
ALTER TABLE public.users ADD CONSTRAINT users_email_unique UNIQUE (email);
ALTER TABLE public.users ADD CONSTRAINT users_role_check CHECK (role IN ('admin', 'subscriber'));

CREATE INDEX users_email_idx ON public.users(email);

CREATE TRIGGER trg_users_updated_at
    BEFORE UPDATE ON public.users
    FOR EACH ROW
    EXECUTE FUNCTION public.set_updated_timestamp();

-- +goose Down
DROP TABLE public.users;
