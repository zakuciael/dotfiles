# Directory to look for dynamic window rules executables in
RULES_D="${BASH_SOURCE[0]}.d"

if [[ ! -d "$RULES_D" ]]; then
    error "rules directory '${RULES_D}' not found"
    exit 1
fi

find -L "${RULES_D}" -type f | sort | while IFS= read -r RULE_FILE; do
    if [[ -x "${RULE_FILE}" && ! "${RULES_FILE}" =~ "##" && ! "${RULES_FILE}" =~ "~$" ]]; then
        . ${RULE_FILE}
    fi
done
