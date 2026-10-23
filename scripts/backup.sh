#!/bin/bash

# Fungsi untuk mencatat aktivitas ke log
log_message() {
    local level="$1"
    local message="$2"
    local timestamp

    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    printf '[%s] [%s] %s\n' "$timestamp" "$level" "$message" \
        >> "$LOG_FILE"
    printf '[%s] [%s] %s\n' "$timestamp" "$level" "$message"
}

# Fungsi untuk menampilkan petunjuk penggunaan
#!/bin/bash

LOG_FILE="$(dirname "$0")/../logs/backup.log"

log_message() {
    local level="$1"
    local message="$2"
    local timestamp

    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    printf '[%s] [%s] %s\n' "$timestamp" "$level" "$message" >> "$LOG_FILE"
    printf '[%s] [%s] %s\n' "$timestamp" "$level" "$message"
}

usage() {
    echo "Penggunaan: $0 SUMBER DIREKTORI_TUJUAN"
}

perform_backup() {
    local source_dir="$1"
    local backup_dir="$2"
    local source_real
    local backup_real
    local backup_file

    if [[ ! -d "$source_dir" ]]; then
        log_message "ERROR" "Direktori sumber tidak ditemukan."
        return 1
    fi

    if [[ ! -r "$source_dir" || ! -x "$source_dir" ]]; then
        log_message "ERROR" "Direktori sumber tidak dapat dibaca."
        return 1
    fi

    if [[ -e "$backup_dir" && ! -d "$backup_dir" ]]; then
        log_message "ERROR" "Tujuan bukan direktori."
        return 1
    fi

    source_real=$(realpath -e -- "$source_dir") || {
        log_message "ERROR" "Gagal memvalidasi direktori sumber."
        return 1
    }

    backup_real=$(realpath -m -- "$backup_dir") || {
        log_message "ERROR" "Gagal memvalidasi direktori tujuan."
        return 1
    }

    case "$backup_real/" in
        "$source_real/"*)
            log_message "ERROR" "Tujuan backup tidak boleh berada di dalam sumber."
            return 1
            ;;
    esac

    if ! mkdir -p -- "$backup_real"; then
        log_message "ERROR" "Gagal membuat direktori tujuan."
        return 1
    fi

    backup_file="$backup_real/backup-$(date '+%Y%m%d-%H%M%S-%N').tar.gz"

    if tar -czf "$backup_file" -C "$(dirname "$source_real")" \
        "$(basename "$source_real")"; then
        log_message "INFO" "Backup berhasil: $backup_file"
        return 0
    else
        rm -f -- "$backup_file"
        log_message "ERROR" "Proses backup gagal."
        return 1
    fi
}

main() {
    if [[ "$#" -ne 2 ]]; then
        echo "ERROR: Harus memberikan tepat dua parameter." >&2
        usage
        return 2
    fi

    if [[ -z "$1" || -z "$2" ]]; then
        echo "ERROR: Parameter tidak boleh kosong." >&2
        usage
        return 2
    fi

    if ! touch "$LOG_FILE"; then
        echo "ERROR: Tidak dapat menulis file log." >&2
        return 1
    fi

    perform_backup "$1" "$2"
    return $?
}

main "$@"
exit $?
