% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dbGetRowsAffected.R
\name{dbGetRowsAffected}
\alias{dbGetRowsAffected}
\title{The number of rows affected}
\usage{
dbGetRowsAffected(res, ...)
}
\arguments{
\item{res}{An object inheriting from \link[=DBIResult-class]{DBI::DBIResult}.}

\item{...}{Other arguments passed on to methods.}
}
\value{
\code{dbGetRowsAffected()} returns a scalar number (integer or numeric),
the number of rows affected by a data manipulation statement
issued with \code{\link[DBI:dbSendStatement]{DBI::dbSendStatement()}}.
The value is available directly after the call
and does not change after calling \code{\link[DBI:dbFetch]{DBI::dbFetch()}}.
\code{NA_integer_} or \code{NA_numeric_} are allowed if the number of rows affected is not known.

For queries issued with \code{\link[DBI:dbSendQuery]{DBI::dbSendQuery()}},
zero is returned before
and after the call to \code{dbFetch()}.
\code{NA} values are not allowed.
}
\description{
This method returns the number of rows that were added, deleted, or updated
by a data manipulation statement.

\Sexpr[results=rd,stage=render]{DBI:::methods_as_rd("dbGetRowsAffected")}
}
\section{The command execution flow}{


This section gives a complete overview over the flow
for the execution of SQL statements that have side effects
such as stored procedures, inserting or deleting data,
or setting database or connection options.
Most of this flow, except repeated calling of \code{\link[=dbBindArrow]{dbBindArrow()}},
is implemented by \code{\link[=dbExecute]{dbExecute()}}, which should be sufficient
for non-parameterized queries.
This flow requires an active connection established by \code{\link[=dbConnect]{dbConnect()}}.
See also \code{vignette("dbi-advanced")} for a walkthrough.
\enumerate{
\item Use \code{\link[=dbSendStatement]{dbSendStatement()}} to create a result set object of class
\linkS4class{DBIResult}.
For some queries you need to pass \code{immediate = TRUE}.
\item Optionally, bind query parameters with\code{\link[=dbBind]{dbBind()}} or \code{\link[=dbBindArrow]{dbBindArrow()}}.
This is required only if the query contains placeholders
such as \verb{?} or \verb{$1}, depending on the database backend.
\item Optionally, use \code{\link[=dbGetRowsAffected]{dbGetRowsAffected()}} to retrieve the number
of rows affected by the query.
\item Repeat the last two steps as necessary.
\item Use \code{\link[=dbClearResult]{dbClearResult()}} to clean up the result set object.
This step is mandatory even if no rows have been fetched
or if an error has occurred during the processing.
It is good practice to use \code{\link[=on.exit]{on.exit()}} or \code{\link[withr:defer]{withr::defer()}}
to ensure that this step is always executed.
}
}

\section{Failure modes}{


Attempting to get the rows affected for a result set cleared with
\code{\link[DBI:dbClearResult]{DBI::dbClearResult()}} gives an error.

}

\examples{
\dontshow{if (requireNamespace("RSQLite", quietly = TRUE)) withAutoprint(\{ # examplesIf}
con <- dbConnect(RSQLite::SQLite(), ":memory:")

dbWriteTable(con, "mtcars", mtcars)
rs <- dbSendStatement(con, "DELETE FROM mtcars")
dbGetRowsAffected(rs)
nrow(mtcars)

dbClearResult(rs)
dbDisconnect(con)
\dontshow{\}) # examplesIf}
}
\seealso{
Other DBIResult generics: 
\code{\link{DBIResult-class}},
\code{\link{dbBind}()},
\code{\link{dbClearResult}()},
\code{\link{dbColumnInfo}()},
\code{\link{dbFetch}()},
\code{\link{dbGetInfo}()},
\code{\link{dbGetRowCount}()},
\code{\link{dbGetStatement}()},
\code{\link{dbHasCompleted}()},
\code{\link{dbIsReadOnly}()},
\code{\link{dbIsValid}()},
\code{\link{dbQuoteLiteral}()},
\code{\link{dbQuoteString}()}

Other command execution generics: 
\code{\link{dbBind}()},
\code{\link{dbClearResult}()},
\code{\link{dbExecute}()},
\code{\link{dbSendStatement}()}
}
\concept{DBIResult generics}
\concept{command execution generics}
