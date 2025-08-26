#!/bin/bash

# Скрипт для анализа топ-100 входящих и исходящих доменов из логов почты
# Использование: ./script.sh [in|out]

ACTION="$1"

if [ -z "$ACTION" ]; then
    echo "Использование: $0 [in|out]"
    echo "  in  - показать топ-100 входящих доменов (откуда приходят письма)"
    echo "  out - показать топ-100 исходящих доменов (куда отправляются письма)"
    exit 1
fi

# Функция для получения данных из логов
get_mail_data() {
    zcat -f $(ls -1tr /var/log/mail.log*) \
    | awk '
    {
      ts = sprintf("%s %s %s", $1, $2, $3)
      if (match($0, / ([A-F0-9]{5,}): /, m)) qid = m[1]; else qid=""
    }
    # запоминаем отправителя по QID из qmgr
    $0 ~ /postfix\/qmgr/ && $0 ~ / from=<[^>]*>/ {
      if (qid != "") {
        match($0, / from=<([^>]*)>/, fm)
        from[qid] = fm[1]
      }
    }
    # печатаем успешные доставки из smtp/lmtp
    $0 ~ /postfix\/(smtp|lmtp)/ && $0 ~ / status=sent/ {
      to = "-"
      relay = "-"
      if (match($0, / to=<([^>]*)>/, tm)) to = tm[1]
      if (match($0, / relay=([^,]*)/, rl)) relay = rl[1]
      fd = (qid in from && from[qid] != "" ? from[qid] : "-")
      
      # домен отправителя
      from_domain = fd
      gsub(/^.*@/, "", from_domain)
      
      # домен получателя  
      to_domain = to
      gsub(/^.*@/, "", to_domain)
      
      print from_domain "\t" to_domain
    }'
}

# Функция для показа топ-100 входящих доменов
show_incoming() {
    echo "=== ТОП-100 ВХОДЯЩИХ ДОМЕНОВ (откуда приходят письма) ==="
    echo "Количество | Домен отправителя"
    echo "-----------|-------------------"
    
    get_mail_data | awk -F'\t' '{
        if ($1 != "-" && $1 != "") {
            count[$1]++
        }
    }
    END {
        for (domain in count) {
            print count[domain] "\t" domain
        }
    }' | sort -nr | head -100 | awk -F'\t' '{
        printf "%-10s | %s\n", $1, $2
    }'
}

# Функция для показа топ-100 исходящих доменов
show_outgoing() {
    echo "=== ТОП-100 ИСХОДЯЩИХ ДОМЕНОВ (куда отправляются письма) ==="
    echo "Количество | Домен получателя"
    echo "-----------|------------------"
    
    get_mail_data | awk -F'\t' '{
        if ($2 != "-" && $2 != "") {
            count[$2]++
        }
    }
    END {
        for (domain in count) {
            print count[domain] "\t" domain
        }
    }' | sort -nr | head -100 | awk -F'\t' '{
        printf "%-10s | %s\n", $1, $2
    }'
}

# Основная логика
case "$ACTION" in
    "in")
        show_incoming
        ;;
    "out") 
        show_outgoing
        ;;
    *)
        echo "Неизвестная команда: $ACTION"
        echo "Используйте 'in' для входящих или 'out' для исходящих доменов"
        exit 1
        ;;
esac
