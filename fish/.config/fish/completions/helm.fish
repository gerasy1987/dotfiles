# Generate version-matched completions on first use instead of shell startup.
if type -q helm
    helm completion fish 2>/dev/null | source
end
