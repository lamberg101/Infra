	select (select username from v$session where sid=a.sid) "Locking Sid (yang nge-lock)", a.sid,
	(select username from v$session where sid=b.sid) "Locked SID (Sedang Menunggu)", b.sid
	from (select sid, id1,id2 from v$lock where  block = 1) a,
	(select sid, id1,id2 from v$lock where request > 0 ) b
	where a.id1 = b.id1 and a.id2 = b.id2;