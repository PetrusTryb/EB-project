# Stawianie prestashop używając docker

## Przygotowania serwera
0. Sklonuj repozytorium na swój komputer, uaktualnij je (`git pull`)
1. Zainstaluj docker https://docs.docker.com/engine/install/.
2. Zbuduj image: \
a. otwórz w CMD/Terminalu folder z projektem i przejdź do `docker-compose`.\
b. Uruchom `docker compose up --build`. Obraz buduje się dłuższą chwilę.
3. Uruchom kontener dockera. 
- Windows: Otwórz *docker desktop* > Containers i uruchom kontener `docker compose`.

## Uruchamianie prestashop
4. Przejdź do `http://localhost:8081/` i zaloguj się do phpMyAdmin.\
serwer: `some-mysql`\
user: `root`\
password: `admin`
5. (jeśli pierwsza instalacja) Stwórz nową bazę danych o nazwie `prestashop`, nie zmieniaj parametrów domyślnych.
6. Przejdź do bazy danych `prestashop` i wciśnij *Import* (połowa szerokości ekranu).
7. Zaimportuj plik `prestashop.sql`, to konfiguracja sklepu.

## Prestashop w przeglądarce
8. Przejdź do `localhost:8080`, witaj na stronie!

## Pushowanie zmian
9. Wyeksportuj bazę danych `prestashop` do pliku sql. Koniecznie dołącz go do repo!
10. Dołącz pozostałe pliki do repo.

## Kończenie pracy
11. Otwórz *docker desktop* i zatrzymaj wybrane kontenery. 
