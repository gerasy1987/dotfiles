# Generate version-matched completions on first use instead of shell startup.
if type -q kubectl
    kubectl completion fish 2>/dev/null | source
end
