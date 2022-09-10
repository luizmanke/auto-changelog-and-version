# [`auto-changelog-and-version`]

This project is a proof of concept on the automation of the versioning control for a Python project, and it's based on [this post](https://levelup.gitconnected.com/version-control-and-automatic-changelog-python-4d193ec90427).

## How it works

Every time a new commit is pushed to the main branch, the [CI/CD action](./.github/workflows/bump.yml) is triggered.

The action uses [commitizen](https://github.com/commitizen-tools/commitizen) to bump the version based on the latest commits.

> *The commits `must` follow the [conventinal commits](https://www.conventionalcommits.org/en/v1.0.0/) style.*

By bumping the version with commitizen, the following changes are expected:

- the version at `pyproject.toml`
- the logs on `CHANGELOG.md`
- a new tag is created

## Examples

### Patch increment

The following commit would bump the version from `0.0.1` to `0.0.2`.

```
fix: fix some bug
```

### Minor increment

The following commit would bump the version from `0.0.2` to `0.1.0`.

```
feat: add some new feature
```

### Major increment

The following commit would bump the version from `0.1.0` to `1.0.0`.

```
feat!: add some breaking change
```

### No increment

If neither `fix` or `feat` are present in the type of the latest commits, the version bump is not performed.

The types related to bumps can be specified in the [CI/CD script](./scripts/count_increment_logs.sh).

> *A `develop` branch can also be used to hold unreleased changes. Check [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) for more information.*
