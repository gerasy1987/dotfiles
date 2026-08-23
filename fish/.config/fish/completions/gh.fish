# Generate version-matched completions on first use instead of shell startup.
if type -q gh
    gh completion -s fish 2>/dev/null | source
end
