#!/bin/bash

# Define el nombre de dominio y la ubicación de los certificados
DOMAIN="api-notion"
CERT_DIR="path/to/certificacion"

# Crea el directorio de certificados si no existe
sudo mkdir -p $CERT_DIR

# Genera una clave privada RSA
sudo openssl genrsa -out $CERT_DIR/$DOMAIN.key 2048

# Genera una solicitud de firma de certificado (CSR)
sudo openssl req -new -key $CERT_DIR/$DOMAIN.key -out $CERT_DIR/$DOMAIN.csr -subj "/CN=$DOMAIN"

# Genera un certificado autofirmado válido por 365 días
sudo openssl x509 -req -days 365 -in $CERT_DIR/$DOMAIN.csr -signkey $CERT_DIR/$DOMAIN.key -out $CERT_DIR/$DOMAIN.crt

# Muestra información del certificado
openssl x509 -in $CERT_DIR/$DOMAIN.crt -noout -text

# Muestra el resumen del certificado
openssl x509 -in $CERT_DIR/$DOMAIN.crt -noout -issuer -subject -dates

# Registra el certificado autofirmado en el llavero de macOS
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" $CERT_DIR/$DOMAIN.crt

# Muestra un mensaje de confirmación
echo "Certificado autofirmado generado y registrado correctamente para $DOMAIN."
