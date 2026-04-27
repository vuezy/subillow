-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION public.set_updated_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp;
-- +goose StatementEnd

-- +goose Down
DROP FUNCTION IF EXISTS public.set_updated_timestamp();
