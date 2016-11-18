       identification division.
      * cgl200 - test mainframe conversion to micro focus cobol
      *        - update gl account master with transactions
       program-id. cgl200.
       environment division.
       input-output section.
       file-control.
uvM   * select glmsold assign glmsold
uvM        select glmsold assign external GLMSOLD
                  organization record sequential access mode sequential.
uvM   * select glmsnew assign glmsnew
uvM        select glmsnew assign external GLMSNEW
                  organization record sequential access mode sequential.
uvM   * select gltrans assign gltrans
uvM        select gltrans assign external GLTRANS
                  organization record sequential access mode sequential.
uvM   *eject
       data division.
       file section.
       fd  glmsold record contains 128 characters.
           01 glmrec.
              05 glm-acct       pic x(8).
              05 glm-type       pic x(10).
              05 glm-dscrptn    pic x(30).
              05 glm-balance    pic s9(9)v99 comp-3.
              05 glm-date       pic x(8).
              05 filler         pic x(66).
       fd  gltrans record contains 80 characters.
           01 gltrec.
              05 glt-acct       pic 9(8).
              05 glt-type       pic x(2).
              05 glt-dscrptn    pic x(30).
              05 glt-amount     pic s9(8)v99.
              05 glt-batch      pic x(6).
              05 glt-js         pic x(2).
              05 glt-ref        pic x(6).
              05 glt-date       pic x(6).
              05 filler         pic x(10).
       fd  glmsnew record contains 128 characters.
           01 glmrec2.
              05 glmn-acct       pic x(8).
              05 glmn-type       pic x(10).
              05 glmn-dscrptn    pic x(30).
              05 glmn-balance    pic s9(9)v99 comp-3.
              05 glmn-date       pic x(8).
              05 filler         pic x(66).
uvM   *eject
       working-storage section.
uvM    copy "unixwork1.cpy".
       01  wrk-flds.
           05 glm-eof           pic x value ' '.
      *
uvM   *eject
       procedure division.
uvM        perform unixproc1.
       mainline.
           open input glmsold gltrans. open output glmsnew.
           read glmsold at end move '1' to glm-eof.
           perform updtrtn until glm-eof = '1'.
           close glmsold glmsnew gltrans.
           stop run.
       updtrtn.
      * to be completed later, for now just update the date
           move glmrec to glmrec2.
           move rundate-ymd8 to glmn-date.
           write glmrec2.
           read glmsold at end move '1' to glm-eof.
uvM    copy "unixproc1.cpy".
