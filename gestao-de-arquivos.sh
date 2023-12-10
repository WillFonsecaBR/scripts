#!/bin/bash

#############################################
#
# DOCUMENTAÇÃO DO SCRIPT
# Este script gerencia arquivos de acordo com os parâmetros fornecidos.
# - Função 'criar_arquivos': Cria arquivos com nome base, tipo e quantidade especificados.
# - Função 'deletar_arquivos': Deleta arquivos que correspondem ao termo de busca fornecido.
# - Função 'renomear_arquivos': Renomeia arquivos que contêm o termo de busca no nome.
#
#############################################

# Função para criar arquivos
criar_arquivos() {
  NOME_BASE="$1"
  TIPO="$2"
  QUANTIDADE="$3"

  for i in $(seq 1 $QUANTIDADE); do
    touch "${NOME_BASE}${i}.${TIPO}"
    echo "Arquivo criado: ${NOME_BASE}${i}.${TIPO}"
  done
}

# Função para deletar arquivos
deletar_arquivos() {
  TERMO_BUSCA="$1"
  ARQUIVOS_ENCONTRADOS=$(find . -type f -name "*${TERMO_BUSCA}*")

  echo "Arquivos selecionados para exclusão:"
  echo "${ARQUIVOS_ENCONTRADOS}"

  read -p "Confirmar exclusão? (s/n): " CONFIRMACAO
  if [[ $CONFIRMACAO == "s" ]]; then
    echo "${ARQUIVOS_ENCONTRADOS}" | xargs rm -f
    echo "Arquivos excluídos."
  else
    echo "Tarefa abortada. Informe o arquivo correto em uma próxima tentativa."
  fi
}

# Função para renomear arquivos
renomear_arquivos() {
  TERMO_BUSCA="$1"
  NOVO_NOME="$2"
  CONT=1

  ARQUIVOS_ENCONTRADOS=$(find . -type f -name "*${TERMO_BUSCA}*")

  echo "Arquivos encontrados para renomear:"
  echo "${ARQUIVOS_ENCONTRADOS}"

  read -p "Confirmar renomeação? (s/n): " CONFIRMACAO
  if [[ $CONFIRMACAO != "s" ]]; then
    echo "Tarefa abortada. Informe os parâmetros corretos em uma próxima tentativa."
    return
  fi

  echo "${ARQUIVOS_ENCONTRADOS}" | while read -r ARQUIVO; do
    EXTENSAO="${ARQUIVO##*.}"
    mv "$ARQUIVO" "${NOVO_NOME}${CONT}.${EXTENSAO}"
    echo "Arquivo renomeado para: ${NOVO_NOME}${CONT}.${EXTENSAO}"
    ((CONT++))
  done
}

# Tratamento dos argumentos de linha de comando
case $1 in
"criar")
  criar_arquivos "$2" $3 $4
  ;;
"deletar")
  deletar_arquivos "$2"
  ;;
"renomear")
  renomear_arquivos "$2" "$3"
  ;;
*)
  echo "Argumento inválido. Use 'criar', 'deletar' ou 'renomear'."
  ;;
esac
