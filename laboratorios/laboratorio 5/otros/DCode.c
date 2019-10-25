#include <stdio.h>
#include <iostream>
#include <cstdlib>
#include <pthread.h>
#include <unistd.h>
#include <string.h>

void sequencer(){
    std::cout << "Starting sequence" << std::endl;
    for (int i = 0; i < 5; i++){
        std::cout << "." << std::endl;
        sleep(1);
    }
    std::cout << "Security filter: passed" << std::endl;
    std::cout << "user: Ale Rav" << std::endl;
    sleep(1);
    std::cout << "pass: ********" << std::endl;
    sleep(1);
    std::cout << "Uncrypting" << std::endl;
    sleep(2);
    system("clear");

}

void *covering(void *arg){
    std::string element;
    std::cout << "Ingrese el simbolo del elemento de la tabla periodica a utilizar para la bomba: ";
    std::cin >> element;

    if(element == "U-235" || element == "U235" || element == "u235" || element == "U" || element == "u"){
        std::cout << "Elemento encontrado exitosamente" << std::endl;
        std::cout << "Configurando...";
        sleep(2);
        return NULL;
    }
    else{
        std::cout << "Incorrecto, saliendo del programa de detonacion" << std::endl;
        exit(0);
    }
}

void confirmation(void *arg){
	
    char *conf = (char *)arg;

	printf("\n¿Desea realmente desactivar la bomba?\n");
    printf("Ingrese 'S' o 'n': ");
    std::cin >> *conf;
    return;
}

void *inactive(void *arg){
    char *cad = (char *)arg;
    if (*cad == 'S' || *cad == 's'){
        printf("\nLa bomba ha sido desactivada.\n");
    }
    else{
        printf("\nBomba activa.\n");
    }
	
    return NULL;
}

pthread_t h1;
pthread_t h2;

char con = 'n';

int main(){
	
    sequencer();
	
	pthread_create(&h1,NULL, covering,NULL);
	pthread_join (h1,NULL);
    
    confirmation(&con);
    
	pthread_create(&h2,NULL, inactive,&con);
    pthread_join (h2,NULL);
	
	return 0;
}

