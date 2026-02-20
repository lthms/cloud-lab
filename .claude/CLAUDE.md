# Conventions

## Commits

Commit messages follow the pattern `<topic> - <description>`. For chart
updates, `<topic>` is `<chart-name> <version>`. For other changes, use a
short topic like `DNS`, `Tooling`, etc.

## Changelog

`CHANGELOG.md` at the repo root must be updated with every chart version
bump. Entries are grouped by date (`## YYYY-MM-DD`) and follow the format:

- `<chart-name>` <version>: <short description>
