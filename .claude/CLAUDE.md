# Tooling philosophy

Prefer off-the-shelf tools over custom scripts. Before writing custom
operators, shell helpers, or bespoke automation, check whether an existing
Helm chart or operator already solves the problem. Maintenance burden and
community support are strong signals in favor of adopting a third-party
solution.

# Deployment

NEVER run `make deploy`, `make destroy`, or `terraform apply`/`terraform
destroy` yourself. Deployment is always done by the user.

Before proposing any configuration change (Helm values, Terraform
variables, etc.), ALWAYS verify the exact syntax against official
documentation first. Do not guess flag names or assume conventions from
other tools.

# Conventions

## Commits

Commit messages follow the pattern `<topic> - <description>`. For chart
updates, `<topic>` is `<chart-name> <version>`. For other changes, use a
short topic like `DNS`, `Tooling`, etc.

## Changelog

`CHANGELOG.md` at the repo root must be updated with every chart version
bump. Entries are grouped by date (`## YYYY-MM-DD`) and follow the format:

- `<chart-name>` <version>: <short description>
