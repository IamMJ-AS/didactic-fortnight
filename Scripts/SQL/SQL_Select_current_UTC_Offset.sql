print GETUTCDATE()
print SYSDATETIMEOFFSET()
DECLARE @datetimeoffset datetimeoffset(7)
set @datetimeoffset = CAST(SYSDATETIMEOFFSET() AS datetimeoffset(7))
print @datetimeoffset