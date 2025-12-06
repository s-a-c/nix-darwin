# PostgreSQL Dual Instance Setup

This configuration runs two PostgreSQL instances simultaneously:

## 1. Homebrew-provided PostgreSQL 18 (Primary)
- **Port**: 5432 (default)
- **Service**: Managed by Homebrew services
- **Binary**: Linked as default `postgres` and `psql` in PATH
- **Extensions** (available via Homebrew):
  - postgis
  - pgvector
  - pg_partman
  - pg_cron
- **Extensions NOT available**: timescaledb, pgaudit, pg_hint_plan, hypopg, rum
- **Connection**: `psql -h localhost -p 5432` or just `psql`

## 2. Nix-provided PostgreSQL 17 (Secondary)
- **Port**: 5433 (non-standard)
- **Service**: Managed by nix-darwin
- **Full extension support**: 
  - postgis
  - pg_partman
  - pgvector
  - timescaledb
  - pg_cron
  - hypopg
  - pgaudit ✓ (only available here)
  - pg_hint_plan
  - rum
- **Connection**: `psql -h localhost -p 5433`
- **Use case**: When you need pgaudit or other extensions not available in Homebrew

## Service Management

### Homebrew PostgreSQL 18 (Primary)
```bash
# Start
brew services start postgresql@18

# Stop
brew services stop postgresql@18

# Restart
brew services restart postgresql@18

# Status
brew services list | grep postgresql
```

### Nix PostgreSQL 17 (Secondary)
```bash
# Status
sudo launchctl list | grep postgres

# Restart (via darwin-rebuild)
sudo darwin-rebuild switch --flake ~/.config/nix-darwin
```

## Notes
- Homebrew PostgreSQL 18 runs on default port 5432 and is the primary instance
- Nix PostgreSQL 17 runs on port 5433 for special extension needs (pgaudit, etc.)
- Both instances run simultaneously without conflicts
- No custom activation scripts needed - simpler configuration
