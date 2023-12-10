#!/bin/bash

#############################################
# Documentação do Script
# Este script gerencia arquivos de acordo com os parâmetros fornecidos.
# - Função 'criar_arquivos': Cria arquivos com nome base, tipo e quantidade especificados.
# - Função 'deletar_arquivos': Deleta arquivos que correspondem ao termo de busca fornecido.
# - Função 'renomear_arquivos': Renomeia arquivos que contêm o termo de busca no nome.
#############################################

#!/bin/bash

# Função para criar arquivos
criar_arquivos() {
  nome_base=$1
  tipo=$2
  quantidade=$3

  for i in $(seq 1 $quantidade); do
    touch "${nome_base}${i}.${tipo}"
    echo "Arquivo criado: ${nome_base}${i}.${tipo}"
  done
}

# Função para deletar arquivos
deletar_arquivos() {
  termo_busca=$1
  arquivos_encontrados=$(find . -type f -name "*${termo_busca}*")

  echo "Arquivos selecionados para exclusão:"
  echo "${arquivos_encontrados}"

  read -p "Confirmar exclusão? (s/n): " confirmacao
  if [[ $confirmacao == "s" ]]; then
    echo "${arquivos_encontrados}" | xargs rm -f
    echo "Arquivos excluídos."
  else
    echo "Tarefa abortada. Informe o arquivo correto em uma próxima tentativa."
  fi
}

# Função para renomear arquivos
renomear_arquivos() {
  termo_busca=$1
  novo_nome=$2
  arquivos_encontrados=$(find . -type f -name "*${termo_busca}*")

  echo "Arquivos encontrados para renomear:"
  echo "${arquivos_encontrados}"

  read -p "Confirmar renomeação? (s/n): " confirmacao
  if [[ $confirmacao == "s" ]]; then
    cont=1
    for arquivo in ${arquivos_encontrados}; do
      mv "${arquivo}" "${novo_nome}${cont}.${arquivo##*.}"
      echo "Arquivo renomeado: ${novo_nome}${cont}.${arquivo##*.}"
      ((cont++))
    done
  else
    echo "Tarefa abortada. Informe os parâmetros corretos em uma próxima tentativa."
  fi
}

# Tratamento dos argumentos de linha de comando
case $1 in
"criar")
  criar_arquivos $2 $3 $4
  ;;
"deletar")
  deletar_arquivos $2
  ;;
"renomear")
  renomear_arquivos $2 $3
  ;;
*)
  echo "Argumento inválido. Use 'criar', 'deletar' ou 'renomear'."
  ;;
esac
