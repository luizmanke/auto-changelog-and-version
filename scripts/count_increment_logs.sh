# Count the number of increment logs based on git commits

# feat: add some feature [skip bump]

set -e

create_log_pattern() {
    local increment_log_pattern_raw=$(printf "^%s|" "$@")
    local increment_log_pattern="${increment_log_pattern_raw::-1}"
    echo "$increment_log_pattern"
}

count_increment_logs() {

    local last_tag=$(git tag | sort -V | tail -n 1)
    local last_logs=$(git log $last_tag..HEAD --oneline --format="%s")
    local increment_logs=$(echo "$last_logs" | grep -E "$1")
    local -i n_increment_logs=0

    if [[ ! -z "$increment_logs" ]]
    then
        n_increment_logs=$(echo "$increment_logs" | wc -l)
    fi

    echo "$n_increment_logs"
}

main() {
    local increment_log_types=("fix" "feat")
    local increment_log_pattern=$(create_log_pattern "${increment_log_types[@]}")
    local n_increment_logs=$(count_increment_logs "$increment_log_pattern")
    echo "$n_increment_logs"
}

main
