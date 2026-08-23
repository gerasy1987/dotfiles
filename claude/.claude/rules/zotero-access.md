# Zotero Library Access

**This rule applies to ALL projects, regardless of type.**

---

Claude and its agents have **standing permission** to read my local Zotero library without asking:

- **Database**: `~/Zotero/zotero.sqlite` — metadata, collections, item attachments. This is an explicit exception to the Data Privacy Protocol's `.sqlite` restriction: the Zotero database contains bibliographic metadata, not research-subject data.
- **Attachments**: `~/Zotero/storage/<KEY>/` — full-text PDFs and supplementary files of published papers, preprints, and appendices.

## How to access safely

1. **Read-only, always.** Never write to `zotero.sqlite`, never add, move, or delete files under `~/Zotero/`.
2. **Query a copy.** Zotero may be running and holding locks; copy `zotero.sqlite` to the scratchpad before running `sqlite3` queries against it.
3. **Useful query shape** (title/creator search → attachment path):

```sql
SELECT it.value AS title, i.key, ia.path
FROM items p
JOIN itemData id ON id.itemID = p.itemID AND id.fieldID = 1
JOIN itemDataValues it ON it.valueID = id.valueID
JOIN itemAttachments a ON a.parentItemID = p.itemID
JOIN items i ON i.itemID = a.itemID
LEFT JOIN itemAttachments ia ON ia.itemID = i.itemID
WHERE it.value LIKE '%<search term>%';
```

Attachment `path` values of the form `storage:file.pdf` resolve to `~/Zotero/storage/<KEY>/file.pdf`, where `<KEY>` is the attachment item's key.

## Why

I frequently ask Claude to verify what cited papers actually argue (see project CLAUDE.md files) and to pull published versions and appendices. The Zotero library is the authoritative local source for these; requiring per-file permission for it defeats the purpose.
