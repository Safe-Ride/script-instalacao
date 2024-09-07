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

# Função para verificar a versão do Node.js
check_node() {
    if type -p node; then
        echo "Node.js encontrado."
        node_version=$(node -v | sed 's/v//')
        if [[ "$node_version" == 18* ]]; then
            echo "Node.js versão 18 já está instalado."
        else
            echo "Versão diferente de Node.js instalada ($node_version)."
            install_node
        fi
    else
        echo "Node.js não encontrado."
        install_node
    fi
}

# Função para instalar o Node.js versão 18
install_node() {
    echo "Instalando Node.js versão 18..."
    sudo apt --fix-broken install -y
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install -y nodejs
}

# Verificar Java e Node.js
check_java
check_node

echo "Verificação e instalação concluídas."
