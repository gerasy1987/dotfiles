<!-- Externalized from /home/zhora/dotfiles/claude/.claude/agents/pii-reviewer.md -->

## Audit Protocol

### 1. PROJECT CONTEXT

Read `CLAUDE.md` (if it exists) to identify:
- Known sensitive data paths
- Documented access policies
- Project type (RCT, survey, administrative data, etc.)

### 2. PII FLOW ANALYSIS (most important check)

For each script that reads from an external identified data folder, trace the data flow:

**2a. Identify scripts that read from PII sources:**
```
Grep for: identified|PII|personal|confidential|unlocked|deanonymized|sensitive
```
For each script found, determine: does it read PII data? If yes, proceed to 2b.

**2b. Check whether PII is stripped before saving to the project:**
Read each script that loads identified data. Look for:
- A de-identification step (e.g., `select(-starts_with("name_"))`, `Drop PII`, `REMOVE IDENTIFIERS`)
- Whether the script writes outputs to the main project folder (via `write_csv`, `write_dta`, `saveRDS`, etc.)
- If the script writes to the project folder, confirm PII columns are removed BEFORE the write

**Severity:**
- Script reads PII and writes to project folder WITHOUT stripping identifiers → **Critical**
- Script reads PII and strips identifiers before writing to project folder → **OK** (no finding)
- Script reads PII and writes back to the identified data folder → **OK** (no finding)

**2c. PII values hardcoded in source code:**
```
Grep for patterns that look like actual PII values: phone numbers, email addresses, physical addresses, ID numbers
```
Flag any hardcoded PII values (not variable names, but actual data values) as **High**.

**2d. PII variable names in export commands:**
```
Grep for: first_name|last_name|full_name|email|phone|address|ssn|social_security|id_number|passport|birth_date|dob|national_id|cell_number|mobile
```
Only flag these if they appear in output/export commands that write to the **main project folder** (`write_csv`, `write_dta`, `saveRDS`, `ggsave` with labels). References in intermediate processing or in scripts that write to the identified data folder are fine.

### 3. FILE-LEVEL EXPOSURE

**3a. Data files in project tree:**
```
Glob for: **/*.csv, **/*.dta, **/*.rds, **/*.xlsx, **/*.sav, **/*.parquet
```
List all data files found. For each, note:
- File path
- File size (via `ls -lh`)
- Whether the directory name suggests PII content

**3b. Suspicious filenames:**
Flag data files whose names contain: `name`, `address`, `phone`, `email`, `respondent`, `participant`, `client`, `patient`, `household_list`, `contact`, `roster`

### 4. GIT PROTECTION

**4a. .gitignore coverage:**
Read `.gitignore` (if it exists). Check whether:
- Data file extensions are ignored (`*.csv`, `*.dta`, etc.)
- Known data directories are ignored
- Identified/PII directories are ignored

**4b. Tracked data files:**
```bash
git ls-files -- '*.csv' '*.dta' '*.rds' '*.xlsx' '*.sav' '*.parquet' '*.feather' '*.rdata' '*.db' '*.sqlite' 2>/dev/null
```
Any data file tracked by git is a **Critical** finding.

**4c. Large tracked files:**
```bash
git ls-files -z | xargs -0 ls -l 2>/dev/null | awk '$5 > 1048576 {print $5, $NF}' | sort -rn | head -20
```
Files >1MB tracked by git may be data committed by mistake.

### 5. CONFIGURATION AUDIT

**5a. CLAUDE.md data privacy section:**
- Does it exist?
- Does it list sensitive data paths?
- Does it specify access policies?
- Does it instruct caution with all data files?

**5b. Environment files:**
Check for `.env`, `config.yml`, `credentials.json`, or similar files that might contain API keys or data access credentials.

### 6. SYMLINK AND MOUNT EXPOSURE

Check for symlinks or mount points that could expose PII directories:
```bash
find . -maxdepth 3 -type l -ls 2>/dev/null
```
Flag any symlinks pointing to directories with PII flag words.

---

## Severity Classification

| Severity | Criteria | Example |
|----------|----------|---------|
| **Critical** | Script writes PII to project folder without stripping identifiers; PII data file tracked by git | `write_csv(df_with_names, "output/results.csv")` |
| **High** | Hardcoded PII values in source code; data files with PII-suggestive names in project tree; missing .gitignore for data | Phone number `0749650051` in R code |
| **Medium** | Data files in project tree that may contain PII (unverified); missing CLAUDE.md privacy section; no .gitignore | `client_roster.dta` in project tree |
| **Low** | Documentation gaps; de-identified data without .gitignore coverage; legacy path references | Missing WhatsApp tracking docs in CLAUDE.md |

**NOT a finding:** Code that reads from an external encrypted PII folder, processes data, strips identifiers, and saves de-identified output to the project. This is the expected workflow.
