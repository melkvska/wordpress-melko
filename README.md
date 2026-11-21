# Розгортання WordPress за допомогою Docker Compose

РГР з дисципліни «Операційні системи», Мелько Вікторія, ПП-24, НУ «Львівська політехніка».

Три контейнери в одній мережі `app-network`:

| Сервіс | Образ | Призначення |
|---|---|---|
| `db-melko` | mysql:8.0 | база даних WordPress (том `dbdata`) |
| `wordpress-melko` | wordpress:5.1.1-fpm-alpine | PHP-FPM з файлами WordPress (том `wordpress`) |
| `webserver-melko` | nginx:1.15.12-alpine | Nginx, порти 80/443, HTTPS із самопідписним сертифікатом |

## Запуск

```bash
echo "127.0.0.1 viktoriia-melko.local www.viktoriia-melko.local" | sudo tee -a /etc/hosts
cp .env.example .env            # вписати власні паролі
cd nginx-conf
openssl genrsa -out viktoriia-melko.key 2048
openssl req -new -x509 -key viktoriia-melko.key -out viktoriia-melko.crt -days 365
cd ..
docker compose up -d
docker compose ps
```

Сайт: https://viktoriia-melko.local

Файли `.env` і приватний ключ сертифіката в репозиторій не додаються (див. `.gitignore`).

## Дві віртуальні машини (UTM, Apple Silicon)

| ВМ | IP | Роль |
|---|---|---|
| Ubuntu (arm64) | 192.168.64.5 | Docker-хост: тут запущено всі три контейнери |
| Windows 11 (ARM64) | 192.168.64.20 | Клієнт: OpenSSL, `.env`, `hosts`, доступ до сайту через мережу |

На Windows 11 ARM у UTM немає вкладеної віртуалізації (`VirtualizationFirmwareEnabled = False`, WSL не встановлюється),
тому Docker Desktop там не запускається. Проєкт, сертифікат і `.env` на Windows підготовлено, а сайт відкрито
з Ubuntu-хоста по мережі за доменом `viktoriia-melko.local`.

