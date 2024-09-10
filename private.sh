#!/bin/bash

# Função para verificar a versão do Java
check_java() {
    if type -p java; then
        echo "Java encontrado."
        java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
        if [[ "$java_version" == "17.0.2" ]]; then
            echo "Java 17.0.2 já está instalado."
        else
            echo "Versão diferente de Java instalada ($java_version)."
            install_java
        fi
    else
        echo "Java não encontrado."
        install_java
    fi
}

# Função para instalar o Java 17.0.2
install_java() {
    echo "Instalando Java 17.0.2..."
    sudo apt update
    sudo apt --fix-broken install -y
    sudo apt install -y openjdk-17-jdk
}

check_java

REPO_URL="https://github.com/Safe-Ride/api-backend.git"
REPO_DIR="api-backend/out/artifacts/api_backend_jar/"
JAR_FILE="api_backend_jar/api-backend.jar"


if ! command -v git &> /dev/null; then
    echo "Git não está instalado. Instalando o Git..."
    sudo apt update
    sudo apt install git -y
else
    echo "Git já está instalado."
fi

# Clona o repositório se ele não existir, ou faz git pull se já existir
if [ ! -d "$REPO_DIR" ]; then
    echo "Repositório não encontrado. Clonando o repositório..."
    git clone "$REPO_URL"
else
    echo "Repositório já existe. Atualizando com git pull..."
    cd "$REPO_DIR"
    git pull
    cd ..
fi

# Verifica se o arquivo JAR existe e o executa
if [ -f "$JAR_FILE" ]; then
    echo "Executando o backend..."
    java -jar "$JAR_FILE"
else
    echo "Arquivo JAR não encontrado: $JAR_FILE"
fi