### Check API
Normally need a new Palo Alto API Role associated with a newly created "apiuser" (not set by default for admin user)
```
curl -k -X GET "https://<firewall>/api/?type=keygen&user=<username>&password=<password>"