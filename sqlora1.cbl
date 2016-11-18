       identification division.
      * sqlora1 - demo cobol-api for oracle
      *         - insert customer name&address into table from text file
      *         - first drops (if exists) & recreates the table
      *         - also see sqlora2 to read table rows write seqntl file
      *         - see alt versions sqlmyo1 mysql/odbc, sqldb21 for db2
      *         - see doc at www.uvsoftware.ca/sqldemo.htm#part_4
      * 3 ways to compile: see ctl/cobdirectives at 'SQLdemo.htm#4T1'
      * 1. procobol - called separately, requires no sql directives
      * 2. preprocess(cobsql) microfocus calls procobol better animation
      * 3. "SQL(targetdb==OracleOCI)" openesql
       program-id. sqlora1.
       environment division.
       input-output section.
       file-control.
uvM   * select cust1 assign external cust1in
           select cust1 assign external cust1in
uvM               organization line sequential access mode sequential.
uvM   *eject
       data  division.
       file section.
       fd  cust1 record contains 80 characters.
           01 cust1rec.
              05 c1num          pic 9(6).
              05 filler         pic x(1).
              05 c1name         pic x(22).
              05 filler         pic x(1).
              05 c1adrs         pic x(22).
              05 filler         pic x(1).
              05 c1city         pic x(16).
              05 filler         pic x(1).
              05 c1prov         pic x(2).
              05 filler         pic x(7).
      *
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
      * database options, communications area, & declare section
           copy "sqlca.cpy".
           exec sql begin declare section end-exec.
      *
      * database & user/pswd for connect to mysql, oracle,& db2
           01  dbname           pic x(20).
           01  userpass         pic x(20).
      *
      * customer record fields to be inserted into cust1 table
           01  csrec.
               05 csnum         pic 9(6).
               05 csname        pic x(22).
               05 csadrs        pic x(22).
               05 cscity        pic x(16).
               05 csprov        pic x(2).
           exec sql end declare section end-exec.
      *
      *eject
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       begin-program.
      **connect to database --> uncomment for mysql/odbc,oracle,or db2
      * - modify cobdirectives, see www.uvsoftware.ca/sqldemo.htm#4t1
      * following works for mysql/odbc
      *    move "myodbc351" to dbname.
      *    move "mysql2/mysql200" to userpass.
      *    exec sql connect to :dbname user :userpass end-exec.
      * following works for db2
      *    move "ar" to dbname
      *    move "db2demo1" to dbuser
      *    move "db2demo100" to dbpass
      *    exec sql connect
      *         to :dbname user :dbuser using :dbpass end-exec.
      * following works for oracle:
           move "demo1/demo100" to userpass.
           exec sql connect :userpass end-exec.
           if sqlcode not = 0 go to sql-error.
      *
      * drop table & recreate to clear any old table data
           exec sql drop table cust1 end-exec.
           if sqlcode not = 0 go to sql-error.
           exec sql create table cust1
uvM             (custno numeric(6) primary key, name1 char(22),
                 adrs char(22), city char(16), prov char(2)) end-exec.
           if sqlcode not = 0 go to sql-error.
      *
      * open input file & use loop to get records & insert to table
           open input cust1.
       mainloop.
           read cust1 at end go to cust1eof.
           move c1num to csnum, move c1name to csname,
           move c1adrs to csadrs, move c1city to cscity,
           move c1prov to csprov.
           exec sql insert into cust1
uvM             (custno, name1, adrs, city, prov) values
                (:csnum, :csname, :csadrs, :cscity, :csprov) end-exec.
           if sqlcode not = 0 go to sql-error.
           go to mainloop.
      *
      * end of file
       cust1eof.
           display "EOF, cust1 table loaded" upon console.
           exec sql commit work release end-exec.
           close cust1. stop run.
      *
      * sql error rtn - when any sql error occurs
       sql-error.
           display "oracle error detected: " sqlerrmc upon console.
           exec sql rollback work release end-exec.
           stop run.
      ******************* end program sqlora1.cbl *********************
uvM    copy "unixproc1.cpy".
