# postgresql

This includes a Chef Habitat plan for installing and running PostgreSQL.

## Installation

```
hab pkg install {origin}/postgresql
```

This will install postgres as a windows service named postgreSQL. It will be in the `stopped` state.

## Running

```
hab svc load {origin}/postgresql
```

This will start postgresql and it should be reachable on port 5432.

## Stopping

```
hab svc stop {origin}/postgresql
```
or
```
hab svc unload {origin}/postgresql
```

This will stop postgresql.

## Uninstalling

```
hab pkg uninstall {origin}/postgresql
```

This will completely uninstall postgresql, the windows service and any data.
