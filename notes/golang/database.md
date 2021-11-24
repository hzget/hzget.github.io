# Database

## Interface and driver

The package ***[database/sql][sql]*** provides a generic interface
around SQL databases. It must be used in conjunction with
a database driver. A database driver will translate requests you make
through functions in the database/sql package into requests
the database understands.

## The handle

An [sql.DB][sql.DB] database handle provides the ability to
read from and write to a database. You can get the handle
by calling either sql.Open(driverName, dataSourceName) or
sql.OpenDB(driverConnector). Then executes data access
operation with the handle. Quite easy.

The following example is an except from golang tutorial
[database access][database access]

```Golang
// open a handle for a specific database
db, err := sql.Open("mysql", "username:password@tcp(127.0.0.1:3306)/jazzrecords")
row := db.QueryRow("SELECT * FROM album WHERE id = ?", id)
if err = row.Scan(&alb.ID, &alb.Title, &alb.Artist, &alb.Price); err != nil {
    if err == sql.ErrNoRows {
        ...
    }
    ...
}
```

### Connections

For many data access APIs, you need to explicitly
open a connection, do work, then close the connection.

The database/sql package simplifies database access by
reducing the need for you to manage connections.
It’s the database handle, represented by an sql.DB,
that handles connections, opening and closing them
on your code’s behalf.

The DB handle represents a connection pool.
When you call an sql.DB Query or Exec method, the sql.DB
implementation retrieves an available connection from
the pool or, if needed, creates one. The package returns
the connection to the pool when it’s no longer needed.

***Note:*** When you open a database handle, the sql package may not
create a new database connection itself right away. Instead,
it may create the connection when your code needs it (access database).
If you won’t be using the database right away and want to confirm
that a connection could be established, call Ping or PingContext.

[sql]: https://pkg.go.dev/database/sql
[sql.DB]: https://pkg.go.dev/database/sql#DB
[database access]: https://golang.google.cn/doc/tutorial/database-access
