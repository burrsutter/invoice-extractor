mc alias set myminio http://localhost:9000 --api s3v4 --access-key minioadmin --secret-key minioadmin

mc rb --force myminio/invoices/done
mc rb --force myminio/invoices/json 
mc rb --force myminio/invoices/json-line-items
mc rb --force myminio/invoices/error
mc rb --force myminio/invoices/intake

mc mb myminio/invoices/intake
mc mb myminio/invoices/done
mc mb myminio/invoices/json
mc mb myminio/invoices/json-line-items
mc mb myminio/invoices/error

