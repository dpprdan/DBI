% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dbConnect.R
\name{dbConnect}
\alias{dbConnect}
\title{Create a connection to a DBMS}
\usage{
dbConnect(drv, ...)
}
\arguments{
\item{drv}{An object that inherits from \link[=DBIDriver-class]{DBI::DBIDriver},
or an existing \link[=DBIConnection-class]{DBI::DBIConnection}
object (in order to clone an existing connection).}

\item{...}{Authentication arguments needed by the DBMS instance; these
typically include \code{user}, \code{password}, \code{host}, \code{port}, \code{dbname}, etc.
For details see the appropriate \code{DBIDriver}.}
}
\value{
\code{dbConnect()} returns an S4 object that inherits from \link[DBI:DBIConnection-class]{DBI::DBIConnection}.
This object is used to communicate with the database engine.

A \code{\link[=format]{format()}} method is defined for the connection object.
It returns a string that consists of a single line of text.
}
\description{
Connect to a DBMS going through the appropriate authentication procedure.
Some implementations may allow you to have multiple connections open, so you
may invoke this function repeatedly assigning its output to different
objects.
The authentication mechanism is left unspecified, so check the
documentation of individual drivers for details.
Use \code{\link[=dbCanConnect]{dbCanConnect()}} to check if a connection can be established.

\Sexpr[results=rd,stage=render]{DBI:::methods_as_rd("dbConnect")}
}
\section{Specification}{


DBI recommends using the following argument names for authentication
parameters, with \code{NULL} default:
\itemize{
\item \code{user} for the user name (default: current user)
\item \code{password} for the password
\item \code{host} for the host name (default: local connection)
\item \code{port} for the port number (default: local connection)
\item \code{dbname} for the name of the database on the host, or the database file
name
}

The defaults should provide reasonable behavior, in particular a
local connection for \code{host = NULL}.  For some DBMS (e.g., PostgreSQL),
this is different to a TCP/IP connection to \code{localhost}.

In addition, DBI supports the \code{bigint} argument that governs how
64-bit integer data is returned.  The following values are supported:
\itemize{
\item \code{"integer"}: always return as \code{integer}, silently overflow
\item \code{"numeric"}: always return as \code{numeric}, silently round
\item \code{"character"}: always return the decimal representation as \code{character}
\item \code{"integer64"}: return as a data type that can be coerced using
\code{\link[=as.integer]{as.integer()}} (with warning on overflow), \code{\link[=as.numeric]{as.numeric()}}
and \code{\link[=as.character]{as.character()}}
}

}

\examples{
\dontshow{if (requireNamespace("RSQLite", quietly = TRUE)) withAutoprint(\{ # examplesIf}
# SQLite only needs a path to the database. (Here, ":memory:" is a special
# path that creates an in-memory database.) Other database drivers
# will require more details (like user, password, host, port, etc.)
con <- dbConnect(RSQLite::SQLite(), ":memory:")
con

dbListTables(con)

dbDisconnect(con)

# Bad, for subtle reasons:
# This code fails when RSQLite isn't loaded yet,
# because dbConnect() doesn't know yet about RSQLite.
dbListTables(con <- dbConnect(RSQLite::SQLite(), ":memory:"))
\dontshow{\}) # examplesIf}
}
\seealso{
\code{\link[=dbDisconnect]{dbDisconnect()}} to disconnect from a database.

Other DBIDriver generics: 
\code{\link{DBIDriver-class}},
\code{\link{dbCanConnect}()},
\code{\link{dbDataType}()},
\code{\link{dbDriver}()},
\code{\link{dbGetInfo}()},
\code{\link{dbIsReadOnly}()},
\code{\link{dbIsValid}()},
\code{\link{dbListConnections}()}

Other DBIConnector generics: 
\code{\link{DBIConnector-class}},
\code{\link{dbDataType}()},
\code{\link{dbGetConnectArgs}()},
\code{\link{dbIsReadOnly}()}
}
\concept{DBIConnector generics}
\concept{DBIDriver generics}
