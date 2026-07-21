#!/bin/bash
 
# Create staff_records directory if it doesn't exist
mkdir -p staff_records
 
# Move into the directory
cd staff_records
 
# Find the highest existing staff number
max_num=$(ls staff*.txt 2>/dev/null | \
sed -E 's/staff([0-9]+)\.txt/\1/' | \
sort -n | tail -1)
 
# If no files exist, start from 100
if [ -z "$max_num" ]; then
    max_num=100
fi
 
# Create the next 30 staff files
start=$((max_num + 1))
end=$((max_num + 30))
 
for ((i=start; i<=end; i++))
do
cat > staff${i}.txt << EOF
Staff ID: $i
Department: IT
Status: Active
EOF
done
 
echo "Created staff files from staff${start}.txt to staff${end}.txt"
 
echo "Total staff files:"
ls staff*.txt | wc -l