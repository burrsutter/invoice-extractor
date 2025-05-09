while true; do
  clear
  echo "File count in invoices/intake:"
  mc find myminio/invoices/intake | grep -v '/$' | wc -l
  sleep 3
done