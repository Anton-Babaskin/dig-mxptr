# mxptr-resolver
Утилита для массового разрешения доменов, поддоменов и IP в их реальные MX, A/AAAA и PTR записи. Полезно для настройки Postfix / Postgrey whitelist, мониторинга инфраструктуры и диагностики проблем с доставкой почты.

## Возможности
- Принимает список доменов, хостов и IP (по одному в строке).
- Для доменов: находит MX-записи, их IP-адреса и PTR.
- Для отдельных хостов: находит A/AAAA-записи и PTR.
- Для IP: определяет PTR hostname.
- Сохраняет результат в табличный `.txt` файл с колонками: `Domain  Role  Target  IP  PTR`

## Установка
git clone https://github.com/yourusername/mxptr-resolver.git
cd mxptr-resolver
chmod +x mxptr-resolver.sh

## Использование
1. Подготовь файл domains.txt со списком доменов/хостов/IP:
isbank.com.tr
mail.isbank.com.tr
212.174.23.15
akbank.com

2. Запусти скрипт:
./mxptr-resolver.sh

По умолчанию:
- входной файл: domains.txt
- выходной файл: resolved_whitelist.txt

3. Можно указать свои файлы:
./mxptr-resolver.sh input.txt output.txt

4. Проверить результат:
cat resolved_whitelist.txt

## Пример результата
# Generated: 2025-08-26 12:45:00 +0300
Domain              Role    Target                IP             PTR
isbank.com.tr       MX      mail.isbank.com.tr    212.174.x.x    mail.isbank.com.tr
mail.isbank.com.tr  Host    mail.isbank.com.tr    212.174.x.x    mail.isbank.com.tr
212.174.23.15       IP      212.174.23.15         212.174.23.15  mail.isbank.com.tr

## Требования
- bash
- dig и host (пакет dnsutils в Debian/Ubuntu):
sudo apt-get install dnsutils -y

## Лицензия
MIT — делай с кодом, что хочешь.
