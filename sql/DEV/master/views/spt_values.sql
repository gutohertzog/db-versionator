USE [master]
GO

create view spt_values as
select name collate database_default as name,
	number,
	type collate database_default as type,
	low, high, status
from sys.spt_values
GO

GRANT SELECT ON [spt_values] TO [public]
GO
