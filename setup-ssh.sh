#!/bin/bash
# script para mac os con keychain
#USO
# chmod 777 setup.ssh.sh
# ./setup-ssh.sh "email" "nombre_archivo"

# Verificar si se proporcionan la dirección de correo electrónico y el nombre de la clave como argumentos
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Por favor, proporciona tu dirección de correo electrónico y un nombre para la clave como argumentos."
    exit 1
fi

# Asignar la dirección de correo electrónico y el nombre de la clave a variables
EMAIL="$1"
KEY_NAME="$2"

# Crear una nueva clave SSH
ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f "$HOME/.ssh/$KEY_NAME"

# Iniciar el agente SSH y agregar la clave
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain "$HOME/.ssh/$KEY_NAME"

# Copiar la clave pública al portapapeles
cat "$HOME/.ssh/$KEY_NAME.pub" | pbcopy

# Imprimir instrucciones para el usuario
echo "La clave SSH '$KEY_NAME' se ha creado y agregado al agente."
echo "La clave pública se ha copiado al portapapeles."

# Mostrar la clave pública para que el usuario pueda agregarla a GitHub
echo "Aquí está tu clave pública:"
cat "$HOME/.ssh/$KEY_NAME.pub"

