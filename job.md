# Synchronization

- psql -U postgres -c "CREATE DATABASE twm_cloud;"

- kubctl apply -f job.yaml
	> 要準備三份 job.yaml, SIT / UAT / PROD
	
- ALTER TABLE statistic  
  ALTER COLUMN is_nsx_t TYPE BOOLEAN  
  USING CASE WHEN is_nsx_t = 0 THEN FALSE ELSE TRUE END;
