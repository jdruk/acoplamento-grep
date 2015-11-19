#!/bin/bash

# Carregar funções principaiss
compilar(){
	VERSION=$1
	DIRETORIO=$2
	
	#Removendo arquivo compilados anteriormente
	rm -rf ../../source/*

	cp -r $VERSION/* ../../source/

	#Entrar no diretorio e compilar arquivo
	cd ../../source/
	gcc -o grep.exe grep.c


	# Retornar para diretorio anterior 
	# versions.alt/versions.orig/
	cd -

	# Removendo arquivos de testes anteriores
	rm -rf ../../testplans/*

	# Copiando novos testes
	echo $PWD
	cp -r ../../testplans.alt/$VERSION/* ../../testplans/
	
	# Gerar scripts
	cd ../../scripts/
	bash mts .. ../source/grep.exe ../testplans/v0_1.tsl.universe R v0_1_version_$VERSION.sh NULL NULL
	#Desenvolver para os demais arquivos

	#Apagar saida anterior
	rm -rf ../outputs/*

	# Executar testes
	chmod a+x v0_1_version_$VERSION.sh
	./v0_1_version_$VERSION.sh

	#Desenvolver para as demais

	mkdir -p ../outputs.alt/origin/$VERSION/v0_1_universe/
	cp -r ../outputs/* ../outputs.alt/origin/$VERSION/v0_1_universe/

}

cd grep/

cd versions.alt/versions.orig/

for i in $(ls )
do
	echo "Versão -----------------------------------------------" $i
	compilar $i $PWD
	
done

