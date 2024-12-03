#!/bin/bash

# Fichier CSV contenant les hôtes et IP
csv_file="ip_list.csv"

# Vérifier si le fichier existe
if [[ ! -f $csv_file ]]; then
    echo "Erreur : Le fichier $csv_file est introuvable."
    exit 1
fi

# Lire les hôtes et IP depuis le fichier CSV et effectuer les pings
while IFS=',' read -r ip host; do
    # Ignorer les lignes vides ou les en-têtes
    if [[ -z "$host" || -z "$ip" || "$host" == "host" ]]; then
        continue
    fi
    # Ping avec un seul paquet (-c 1) et un timeout de 1 seconde (-W 1)
    if ping -c 1 -W 1 "$ip" > /dev/null 2>&1; then
        echo -e "$host ($ip) : \e[32m✔️ Success\e[0m"
    else
        echo -e "$host ($ip) : \e[31m❌ Failed\e[0m"
    fi
done < "$csv_file"
