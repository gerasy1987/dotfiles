# Data Privacy Protocol

**These rules apply to ALL projects, regardless of type.**

---

## Rule 1: Never Read Data Files Without Permission

**Before reading any data file, ask the user for explicit permission.**

Data file extensions: `.csv`, `.dta`, `.rds`, `.rdata`, `.xlsx`, `.xls`, `.sav`, `.json` (when used as data), `.parquet`, `.feather`, `.arrow`, `.sqlite`, `.db`

This applies even when:
- You need column names to fix a merge or join
- You want to understand variable structure
- A script references the file and you want to inspect what it loads
- The file appears to be de-identified or anonymized

**What to do instead:**
1. Read the **code** that processes the data to infer structure
2. Look for codebooks, data dictionaries, or README files in the same directory
3. Check CLAUDE.md for documented variable lists
4. If none of the above works, explain to the user **why** you need to read the file and ask for permission

## Rule 2: Never Access PII Directories

**Never read, open, preview, or list files in directories whose names suggest personally identifiable information.**

Flag words in directory or file names: `identified`, `PII`, `personal`, `confidential`, `unlocked`, `deanonymized`, `linked`, `names`, `addresses`, `sensitive`

If a task absolutely requires accessing such a directory:
1. Stop and explain to the user **what** you need and **why**
2. Wait for explicit permission before proceeding
3. Access only the minimum necessary files

## Rule 3: Include Data Privacy in CLAUDE.md

**When creating or updating a CLAUDE.md file (e.g., via `/init`), check whether the project is a scientific/research project.** A project is scientific if it contains data files, analysis scripts (R, Stata, Python), or research materials (pre-analysis plans, manuscripts, IRB documentation).

For scientific projects, the CLAUDE.md MUST include a **Data Privacy and Identified Data** section that:

1. **Lists known sensitive data paths** — directories or files containing PII
2. **States the access policy** — which files/directories should never be read
3. **Specifies the permission protocol** — if access is unavoidable, explain why and ask first
4. **Notes general caution** — be cautious with all data files in the project; ask before reading any

To populate this section:
- Search for paths containing PII flag words (Rule 2) referenced in code
- Check `.gitignore` for data directory patterns
- Look for IRB documentation, consent forms, or data use agreements
- Ask the user about any sensitive data locations you cannot infer

## Rule 4: Suggest PII Review for New Projects

**After creating a CLAUDE.md for a scientific project, suggest running the `pii-reviewer` agent** to audit the project for data exposure risks. The pii-reviewer scans code references, file paths, git tracking, and `.gitignore` coverage without reading actual data.

Phrase it as: *"This project contains data files. Would you like me to run the PII reviewer to check for any data exposure risks (untracked data files, missing .gitignore coverage, hardcoded paths to identified data)?"*
