USE msdb
GO

EXEC sp_send_dbmail @profile_name='Outlook HIS',
@recipients='daniel.d.dehaven@gmail.com',
@subject='Test message 3',
@body='This is the body of a test'