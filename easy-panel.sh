#!/bin/sh

if [ -f /etc/ee/ee.conf ]; then
    echo "╔══════════════════════════════════╗"
    echo "║                                  ║"
    echo "║      Painel para EasyEngine      ║"
    echo "║                                  ║"
    echo "╠══════════════════════════════════╣"
    echo "║ A instalação será realizada para ║"
    echo "║ instalar com PHP 7 e também com  ║"
    echo "║ SSL através do Lets Encrypt.     ║"
    echo "║                                  ║"
    echo "║ Caso tenha dúvidas sobre os DNS  ║"
    echo "║ que precisa configurar para uma  ║"
    echo "║ instalação com o Lets Encrypt,   ║"
    echo "║ confira a video aula abaixo:     ║"
    echo "║ URL DO YOUTUBE                   ║"
    echo "╠══════════════════════════════════╣"
    echo "║ Qual tipo de Site Deseja Criar?  ║"
    echo "╠══════════════════════════════════╣"
    echo "║ 1) WordPress - Sem Cache         ║"
    echo "║ 2) WordPress - FastCGI           ║"
    echo "║ 3) WordPress - Redis             ║"
    echo "║ 4) MySQL - Limpo                 ║"
    echo "╠══════════════════════════════════╝"
    read -p "║ Opção: " site_type


    echo "╠══════════════════════════════════╗"
    echo "║ Qual o Domínio do Site?          ║"
    echo "╠══════════════════════════════════╝"
    read -p "║ " site_domain

    if [ "$site_type" -eq 4 ]; then
        ee site create $site_domain --mysql --php7 --le
    else
        echo "╠═══════════════════════════════════"
        read -p "║ Email: " wp_email
        echo "╠═══════════════════════════════════"
        read -p "║ Usuário: " wp_user
        echo "╠═══════════════════════════════════"
        read -p "║ Senha: " wp_pass
        echo "╚═══════════════════════════════════"

        if [ "$site_type" -eq 1 ]; then
            ee site create $site_domain --wp --user=$wp_user --pass=$wp_pass --email=$wp_email
        elif [ "$site_type" -eq 2 ]; then
            ee site create $site_domain --wpfc --user=$wp_user --pass=$wp_pass --email=$wp_email
        elif [ "$site_type" -eq 3 ]; then
            ee site create $site_domain --wpredis --user=$wp_user --pass=$wp_pass --email=$wp_email
        fi
    fi
    echo "╔══════════════════════════════════╗"
    echo "║ Instalação Concluída!            ║"
    echo "╚══════════════════════════════════╝"
else
    echo "╔═══════════════════════════════════════╗"
    echo "║ Instalação do Easy Engine Obrigatória ║"
    echo "╚═══════════════════════════════════════╝"
fi
