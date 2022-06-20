# Ubuntu Setup 
Após configurar a sua chave SSH e ter Personal Acess Token e rode os scripts na sequencia indicada, não esqueça de adicionar permissão de escrita para os scripts  

> sudo chmod +x fetch-repos.sh
> 
> sudo chmod +x install-utils.sh
> 
> sudo chmod +x config-wsl.sh

## config-wsl

Nesta etapa serão instaladas as seguintes ferramentas 

ZSH

PowerLevel10k

ASDF

## install-utils

Nesse momento o script irá instalar dependencias nescessárias, linguagens de programação selecionadas, LunarVim e Postgres. Além disso se desejado ele irá rodar o script de fetch-repositories

## fetch-repos

Este por sua vez, dada a chave de acesso pessoal e o nome da organização, cria uma pasta respectiva e faz clone de todos repositorios daquela organização no github



