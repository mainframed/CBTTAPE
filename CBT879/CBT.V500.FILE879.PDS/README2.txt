TSOFIND  by Tom Hall (tomhall.teepee@ntlworld.com)
=======

A program to interactively do a DSN/catalog look-up, and
optionally scan online dasd vtocs for all instances of a dataset, and
optionally display the dataset's DCB information

History
=======

In those days, We had only a few disk drives, but several removable
disks. Batch jobs often failed and left unwanted files
As our disks were frequently swapped-out to run other jobs, these
left-over files were a ticking time-bomb, and their presence often
brought down jobs which would have otherwise worked ok
- the dreaded 'not catalog'd -2 message'
Our Operators had to resort to punching-up IEHLIST jobs, printing
and searching through the listings to locate these left-over files,
then punching-up IEFBR14 jobs to clean-up these files

Change History (1st version written circa 1976)
==============

- Initial version used WTO/WTORs to get & display on the system console
- Once I got a TSO UserId, I replaced the WTO/WTORs with TPUT/TGETs
- added DCB infomation code
- added GDG support e.g. DSN(+1), DSN(-2) etc.

I did toy with the idea of optionally submitting IEFBR14 delete jobs
via the internal reader, but decided this could too easily produce
disasterous results (and I would get the blame)
