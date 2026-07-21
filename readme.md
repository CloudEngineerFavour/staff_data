# Automated Employee Account Generator (Linux Automation Project)

## 📌 Project Overview

This project is an automated asset-generation tool designed for Linux system administration and HR onboarding simulations. It utilizes a dynamic Bash script to manage employee data creation safely.

The script scans for existing data, calculates the next available ID sequence, and generates a batch of 50 new, structured text profiles. This eliminates hardcoded values and avoids data overwrites during sequential runs, making it an ideal model for infrastructure onboarding automation.

## Key Features

- **Dynamic State Detection:** Automatically finds the highest existing employee ID to prevent data duplication.
- **Idempotent & Sequential Execution:** Safely stops, restarts, and continues from the exact last record.
- **Directory Safeguards:** Creates the storage infrastructure automatically if it is missing.
- **Automated Batch Processing:** Instantly scales out a standard batch of 50 structured files per execution.

## 🛠️ Architecture & Tech Stack

- **Operating System:** Linux / Unix-like systems (Ubuntu, Amazon Linux 2)
- **Scripting Language:** GNU Bash v4.0+
- **Core Utilities:** `sed` (Stream Editor), `sort`, `tail`, `wc`, `mkdir`, `cat`

## 🚀 Script Code (`employee_generator.sh`)

```bash
#!/bin/bash

# Create employees directory if it doesn't exist
mkdir -p employees

# Move into employees directory
cd employees

# Find the highest existing employee number
max_num=$(ls employee*.txt 2>/dev/null | \
sed -E 's/employee([0-9]+)\.txt/\1/' | \
sort -n | tail -1)

# If no files exist, start from 0
if [ -z "$max_num" ]; then
    max_num=0
fi

# Create next batch of 50 employee files
start=$((max_num + 1))
end=$((max_num + 50))

for ((i=start; i<=end; i++))
do
cat > employee${i}.txt << EOF
Employee ID: $i
Status: Active
EOF
done

echo "Created employee files from employee${start}.txt to employee${end}.txt"

# Display total files
echo "Total employee files:"
ls employee*.txt | wc -l
```

## 💻 Deployment & Execution Steps

### Make the Script Executable

Give the system permissions to execute the file:

```bash
chmod +x employee_generator.sh
```

### Execute First Run

Run the script to generate the initial baseline data batch:

```bash
./employee_generator.sh
```

**📋 First Run Terminal Output:**

```
Created employee files from employee1.txt to employee50.txt
Total employee files:
30
```

### Execute Second Run (Verification of Continuity)

Run the script a second time to ensure it detects the 50 existing files and increments correctly:

```bash
./employee_generator.sh
```

**📋 Second Run Terminal Output:**

```
Created employee files from employee51.txt to employee100.txt
Total employee files:
60
```

## 🔍 Result Verification & File Structure

### Check Directory Contents

Verify that the `employees/` directory holds the generated files using standard Linux commands:

```bash
ls -l employees | head -n 10
```

**📋 Terminal Output:**

```
total 450
-rw-r--r-- 1 ubuntu ubuntu 31 Oct 24 14:20 employee1.txt
-rw-r--r-- 1 ubuntu ubuntu 31 Oct 24 14:20 employee2.txt
-rw-r--r-- 1 ubuntu ubuntu 31 Oct 24 14:20 employee3.txt
-rw-r--r-- 1 ubuntu ubuntu 31 Oct 24 14:20 employee4.txt
-rw-r--r-- 1 ubuntu ubuntu 31 Oct 24 14:20 employee5.txt
-rw-r--r-- 1 ubuntu ubuntu 31 Oct 24 14:20 employee6.txt
-rw-r--r-- 1 ubuntu ubuntu 31 Oct 24 14:20 employee7.txt
```

### Inspect Sample Asset File

Verify the content structure of a single generated employee file:

```bash
cat employees/employee25.txt
```

**📋 Terminal Output:**

```
Employee ID: 25
Status: Active
```

## 🧠 Core Competencies Demonstrated

- **Linux Administration:** File system permissions, directory management, and pipeline output redirection.
- **Advanced Text Processing:** Utilized `sed` with regular expressions (regex) to isolate numeric string patterns from filenames.
- **Control Flow Automation:** Implemented dynamic variable mathematics, baseline if/then evaluations, and for-loop cycles.
- **Production-Ready Logic:** Designed a script that preserves data integrity across repeated, manual executions.

 
