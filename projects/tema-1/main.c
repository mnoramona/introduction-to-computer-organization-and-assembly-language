#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "structs.h"
#include <inttypes.h>

#define INPUTSIZE 256

int8_t convert8(char *bancnota){
    int semn = 1, i;
    int8_t val = 0;
    if(*bancnota == '-'){
        semn = -1;
        bancnota = bancnota + 1;
    }
    for(i = 0; i < strlen(bancnota); i++){
        val = val * 10 + (bancnota[i] - '0');
    }
    val = val * semn;
    return val;
}

int16_t convert16(char *bancnota){
    int semn = 1, i;
    int16_t val = 0;
    if(*bancnota == '-'){
        semn = -1;
        bancnota = bancnota + 1;
    }
    for(i = 0; i < strlen(bancnota); i++){
        val = val * 10 + (bancnota[i] - '0');
    }
    val = val * semn;
    return val;
}

int32_t convert32(char *bancnota){
    int semn = 1, i;
    int32_t val = 0;
    if(*bancnota == '-'){
        semn = -1;
        bancnota = bancnota + 1;
    }
    for(i = 0; i < strlen(bancnota); i++){
        val = val * 10 + (bancnota[i] - '0');
    }
    val = val * semn;
    return val;
}

size_t size(void *arr, int len){
    int s = 0, i;
    for (i = 0; i < len; i++){
        data_structure *new_data = (data_structure*)arr; // ca sa nu modific arr u'
        s += new_data->header->len + 5;
        arr += new_data->header->len + 5; // ma mut
    }
    return s;
}

int add_last(void **arr, int *len, data_structure *data){
    // functia adauga un element la finalul vectorului arr 
    //int s = size(*arr, *len);
    // adaug = +len+5
    //int s1 = s + data->header->len + 5;
    // modific lungimea => realoc memorie pt noua lungime
    *arr = realloc(*arr, size(*arr, *len) + data->header->len + 5);
    if(*arr == NULL) return -1;
    // add_last => intre pozitia "len" si "s"
    memcpy((*arr) + size(*arr, *len), data, data->header->len + 5);
    // lungimea va fi incrementata la finalul operatiilor
    (*len)++;
    return 0;
}

int add_at(void **arr, int *len, data_structure *data, int index){ 
    //verific pozitia
    if(index < 0) return -1;
    if(index > *len) index = *len;
    *arr = realloc(*arr, size(*arr, *len) + data->header->len + 5);
    if(*arr == NULL) return -1;
    memcpy((char*)*arr + size(*arr, index) + data->header->len + 5, (char*)*arr + size(*arr, index), size(*arr, *len) - size(*arr, index));
    memcpy((char*)*arr + size(*arr, index), data, data->header->len + 5);
    (*len)++;
    return 0;
}

void find(void *data_block, int len, int index) { 
    // find index - se va apela functia find
    if(index >= len) return;
    int i;
    for(i = 0; i < index; i++){
        data_structure *datas = (data_structure*)data_block;
        data_block = (char*) data_block + datas->header->len + 5;
    }
    size_t size = 0;
    size_t dimensiune_bancnota_1 = 0, dimensiune_bancnota_2 = 0;
    data_structure *new_data = (data_structure*)data_block;
    void *d = new_data->data; // ma ajuta la pozitii
    printf("Tipul %c\n", new_data->header->type); // afisez tipul
    if(new_data->header->type == '1'){ // salvez dimensiunile bancnotelor, in functie de fiecare tip
        dimensiune_bancnota_1 = sizeof(int8_t);
        dimensiune_bancnota_2 = sizeof(int8_t);
    }
    else if(new_data->header->type == '2'){
        dimensiune_bancnota_1 = sizeof(int16_t);
        dimensiune_bancnota_2 = sizeof(int32_t);
    }
    else if(new_data->header->type == '3'){
        dimensiune_bancnota_1 = sizeof(int32_t);
        dimensiune_bancnota_2 = sizeof(int32_t);
    }
    while(*(char*)d != '\0'){ // pana la intalnirea caracterului terminator
        printf("%c", *(char*)d); // afisez persoana care da, caracter cu caracter
        d = (char*)d + 1;
        size++; // lungimea primei persoane care ne ajuta la afisarea bancnotelor
    }

    d = (char*)d + dimensiune_bancnota_1 + dimensiune_bancnota_2 + 1;
    printf(" pentru ");
    while(*(char*)d != '\0'){ // pana la intalnirea caracterului terminator
        printf("%c", *(char*)d); // afisez persoana care primeste, caracter cu caracter
        d = (char*)d + 1;
    }

    printf("\n");
            
    if(new_data->header->type == '1'){
        d = new_data->data;
        d = (char*)d + size + 1;
        printf("%"PRId8"\n", *(int8_t*)d);

        d = (char*)d + dimensiune_bancnota_1;
        printf("%"PRId8"\n", *(int8_t*)d);
        printf("\n");
    }
    else if(new_data->header->type == '2'){
        d = new_data->data;
        d = (char*)d + size + 1;
        printf("%"PRId16"\n", *(int16_t*)d);

        d = (char*)d + dimensiune_bancnota_1;
        printf("%"PRId32"\n", *(int32_t*)d);

        printf("\n");
    }
    else if(new_data->header->type == '3'){
        d = new_data->data;
        d = (char*)d + size + 1;
        printf("%"PRId32"\n", *(int32_t*)d);

        d = (char*)d + dimensiune_bancnota_1;
        printf("%"PRId32"\n", *(int32_t*)d);
        printf("\n");
    }
}

int delete_at(void **arr, int *len, int index){
     // delete_at index - se va apela functia delete_at
    if(index < 0) return -1;
    if(index > *len - 1) return -1;

    if(*len == 1){
        if(index == 0){
            free(*arr);
            (*len)--;
            return 0;
        }
    }
    size_t before = size(*arr, *len);
    size_t diferenta = size(*arr, index) - size(*arr, index - 1);
    memcpy((char*)*arr + size(*arr, index), (char*)*arr + size(*arr, index + 1), size(*arr, *len) - size(*arr, index));
    *arr = realloc(*arr, before - diferenta);
    //if(*arr == NULL) return -1;
    (*len)--;
    return 0;

}
// print - se va afisa tot vectorul
void print(void *arr, int len){
    /* Tipul <type>
    <cine da> pentru <cine primeste>
    <valoare prima bancnota>
    <valoare a doua bancnota>
    (spatiu)
    */
    int i;
    if(len != 0){
        for(i = 0; i < len; i++){
            size_t size = 0;
            size_t dimensiune_bancnota_1 = 0, dimensiune_bancnota_2 = 0;
            data_structure *new_data = (data_structure*)arr;
            void *d = new_data->data; // ma ajuta la pozitii
            printf("Tipul %c\n", new_data->header->type); // afisez tipul
            if(new_data->header->type == '1'){ // salvez dimensiunile bancnotelor, in functie de fiecare tip
                dimensiune_bancnota_1 = sizeof(int8_t);
                dimensiune_bancnota_2 = sizeof(int8_t);
            }
            else if(new_data->header->type == '2'){
                dimensiune_bancnota_1 = sizeof(int16_t);
                dimensiune_bancnota_2 = sizeof(int32_t);
            }
            else if(new_data->header->type == '3'){
                dimensiune_bancnota_1 = sizeof(int32_t);
                dimensiune_bancnota_2 = sizeof(int32_t);
            }
            while(*(char*)d != '\0'){ // pana la intalnirea caracterului terminator
                    printf("%c", *(char*)d); // afisez persoana care da, caracter cu caracter
                    d = (char*)d + 1;
                    size++; // lungimea primei persoane care ne ajuta la afisarea bancnotelor
            }

            d = (char*)d + dimensiune_bancnota_1 + dimensiune_bancnota_2 + 1;
            printf(" pentru ");
            while(*(char*)d != '\0'){ // pana la intalnirea caracterului terminator
                printf("%c", *(char*)d); // afisez persoana care primeste, caracter cu caracter
                d = (char*)d + 1;
            }

            printf("\n");
            
            if(new_data->header->type == '1'){
                d = new_data->data;
                d = (char*)d + size + 1;
                printf("%"PRId8"\n", *(int8_t*)d);

                d = (char*)d + dimensiune_bancnota_1;
                printf("%"PRId8"\n", *(int8_t*)d);
                printf("\n");
            }
            else if(new_data->header->type == '2'){
                d = new_data->data;
                d = (char*)d + size + 1;
                printf("%"PRId16"\n", *(int16_t*)d);

                d = (char*)d + dimensiune_bancnota_1;
                printf("%"PRId32"\n", *(int32_t*)d);

                printf("\n");
            }
            else if(new_data->header->type == '3'){
                d = new_data->data;
                d = (char*)d + size + 1;
                printf("%"PRId32"\n", *(int32_t*)d);

                d = (char*)d + dimensiune_bancnota_1;
                printf("%"PRId32"\n", *(int32_t*)d);
                printf("\n");
            }
            data_structure *new_arr = (data_structure*)arr;
            arr = (char*)arr + 5 + new_arr->header->len;
        }
    }
}


void pun_date(char *tip, char *da, char *b1, char *b2, char *primeste, data_structure **new_data){
    if(strcmp(tip, "1") == 0){
        int8_t banc1 = convert8(b1);
        int8_t banc2 = convert8(b2);
        (*new_data)->header = malloc(5 * sizeof(char));
        (*new_data)->header->type = '1';
        size_t lungime = 0;
        lungime += strlen(da) + 1;
        lungime += sizeof(int8_t);
        lungime += sizeof(int8_t);
        lungime += strlen(primeste) + 1;
        (*new_data)->header->len = lungime;
        (*new_data)->data = malloc(lungime * sizeof(char));
        size_t index = 0;
        memcpy((char*)(*new_data)->data + index, da, (strlen(da) + 1));
        index += strlen(da) + 1;
        memcpy((char*)(*new_data)->data + index, &banc1, sizeof(int8_t));
        index += sizeof(int8_t);
        memcpy((char*)(*new_data)->data + index, &banc2, sizeof(int8_t));
        index += sizeof(int8_t);
        memcpy((char*)(*new_data)->data + index, primeste, (strlen(primeste) + 1));
    }
    if(strcmp(tip, "2") == 0){
        int16_t banc1 = convert16(b1);
        int32_t banc2 = convert32(b2);
        (*new_data)->header = malloc(5 * sizeof(char));
        (*new_data)->header->type = '2';
        size_t lungime = 0;
        lungime += strlen(da) + 1;
        lungime += sizeof(int16_t);
        lungime += sizeof(int32_t);
        lungime += strlen(primeste) + 1;
        (*new_data)->header->len = lungime;
        (*new_data)->data = malloc(lungime * sizeof(char));
        size_t index = 0;
        memcpy((char*)(*new_data)->data + index, da, (strlen(da) + 1));
        index += strlen(da) + 1;
        memcpy((char*)(*new_data)->data + index, &banc1, sizeof(int16_t));
        index += sizeof(int16_t);
        memcpy((char*)(*new_data)->data + index, &banc2, sizeof(int32_t));
        index += sizeof(int32_t);
        memcpy((char*)(*new_data)->data + index, primeste, (strlen(primeste) + 1));
    }
    if(strcmp(tip, "3") == 0){
        int32_t banc1 = convert32(b1);
        int32_t banc2 = convert32(b2);
        (*new_data)->header = malloc(5 * sizeof(char));
        (*new_data)->header->type = '3';
        size_t lungime = 0;
        lungime += strlen(da) + 1;
        lungime += sizeof(int16_t);
        lungime += sizeof(int32_t);
        lungime += strlen(primeste) + 1;
        (*new_data)->header->len = lungime;
        (*new_data)->data = malloc(lungime * sizeof(char));
        int index = 0;
        memcpy((char*)(*new_data)->data + index, da, (strlen(da) + 1));
        index += strlen(da) + 1;
        memcpy((char*)(*new_data)->data + index, &banc1, sizeof(int32_t));
        index += sizeof(int32_t);
        memcpy((char*)(*new_data)->data + index, &banc2, sizeof(int32_t));
        index += sizeof(int32_t);
        memcpy((char*)(*new_data)->data + index, primeste, (strlen(primeste) + 1));
    }
}

int main(){
    //pasul 1: citire (check)
    //pasul 2: alocarea de memorie pentru data_structure(check)
    //pasul 3: crearea unui header in care se salveaza TIPUL si LUNGIMEA(check)
// care va fi ocupata de datele salvate in interiorul zonei de memorie date;
    //pasul 4: alocam memorie pentru data si incepem sa scriem in acea zona de memorie (check)
//Nu dorim sa salvam adresa de memorie a niciunei valori, dorim sa scriem exact memoria de la acea adresa.
//nu dorim sa salvam in void *data 2 adrese ci valoarea efectiva de la acele adrese ('Ana\0', 'Banana\0')
//pentru cele 2 int-uri, dorim sa salvam exact acei bytes, in cazul de fata avem 2 int-uri pe 1 byte. Astfel lungimea ocupata de toate aceste date este de 13 bytes (4 + 1 + 1 + 7).
	void *arr = NULL; //stocarea datelor intr-un “vector generic”
    //   ^vector de dedicatii de bani
//la adresa arr se va afla structura header specifica, iar la adresa arr + sizeof(struct header) se vor afla datele efective ale primului element. 
	int len = 0;
    //Pentru un string cu continutul “Ana”, se vor aloca dinamic 4 octeti (3 pentru fiecare litera + unul pentru terminatorul de sir). 
    
    char input[INPUTSIZE];
    fgets(input, INPUTSIZE, stdin);
    //strcspn imi da prima pozitie a lui \n
    input[strcspn(input, "\n")] = 0;
// valoarea returnata este <0 (daca sir1 <sir2), =0 (daca sir1 = sir2) si >0 (daca sir1 > sir2)
    while(strcmp(input, "exit") != 0){ // verificam operatiile doar atunci cand nu sunt operatia de exit
        char *intrare = (char*) malloc (sizeof(char) * (strlen(input) + 1));
        memcpy(intrare, input, (strlen(input) + 1));
        char *informatii = strtok(intrare, " "); // "informatii" aici se refera la actiunea care trebuie facuta - insert, print etc.
        informatii[strlen(informatii)] ='\0'; //terminator de sir
    // memcpy() copiaza un numar num caractere din sirul sursa in sirul destinatie
    // void* memcpy(void *destination, const void *source, size_t num);
        if(strcmp(informatii, "insert") == 0){ \
        // insert tip dedicator suma1 suma2 dedicatul - se va apela functia add_last
            data_structure *datas;
            datas = malloc(sizeof(*datas));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la tipul de date care trebuie folosit
            char *tip;
            tip = malloc(strlen(informatii) + 1);
            memcpy(tip, informatii, (strlen(informatii) + 1));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la numele celui care dedica
            char *cine_da;
            cine_da = malloc(strlen(informatii) + 1);
            memcpy(cine_da, informatii, (strlen(informatii) + 1));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la prima bancnota
            char *char_bancnota1;
            char_bancnota1 = malloc(strlen(informatii) + 1);
            memcpy(char_bancnota1, informatii, (strlen(informatii) + 1));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la a doua bancnota
            char *char_bancnota2;
            char_bancnota2 = malloc(strlen(informatii) + 1);
            memcpy(char_bancnota2, informatii, (strlen(informatii) + 1));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la numele celui caruia i se dedica
            char *cine_primeste;
            cine_primeste = malloc(strlen(informatii) + 1);
            memcpy(cine_primeste, informatii, (strlen(informatii) + 1));
            pun_date(tip, cine_da, char_bancnota1, char_bancnota2, cine_primeste, &datas);
            // am pus datele
            add_last(&arr, &len, datas);
            free(tip);
            free(cine_da);
            free(cine_primeste);
            free(char_bancnota2);
            free(char_bancnota1);
            free(datas->header);
            free(datas->data);
            free(datas);
        }
        if(strcmp(informatii, "insert_at") == 0){
            // insert_at index tip dedicator suma1 suma2 dedicatul - se va apela functia add_at
            data_structure *datas;
            datas = malloc(sizeof(*datas));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la index
            int32_t index;
            index = convert32(informatii);
            informatii = strtok(NULL, " "); // "informatii" aici se refera la tipul de date care trebuie folosit
            char *tip;
            tip = malloc(strlen(informatii) + 1);
            memcpy(tip, informatii, (strlen(informatii) + 1));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la numele celui care dedica
            char *cine_da;
            cine_da = malloc(strlen(informatii) + 1);
            memcpy(cine_da, informatii, (strlen(informatii) + 1));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la prima bancnota
            char *char_bancnota1;
            char_bancnota1 = malloc(strlen(informatii) + 1);
            memcpy(char_bancnota1, informatii, (strlen(informatii) + 1));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la a doua bancnota
            char *char_bancnota2;
            char_bancnota2 = malloc(strlen(informatii) + 1);
            memcpy(char_bancnota2, informatii, (strlen(informatii) + 1));
            informatii = strtok(NULL, " "); // "informatii" aici se refera la numele celui caruia i se dedica
            char *cine_primeste;
            cine_primeste = malloc(strlen(informatii) + 1);
            memcpy(cine_primeste, informatii, (strlen(informatii) + 1));
            pun_date(tip, cine_da, char_bancnota1, char_bancnota2, cine_primeste, &datas);
            // am pus datele
            add_at(&arr, &len, datas, index);
            free(cine_da);
            free(tip);
            free(cine_primeste);
            free(char_bancnota2);
            free(char_bancnota1);
            free(datas->header);
            free(datas->data);
            free(datas);
        }
        if(strcmp(informatii, "find") == 0){
            informatii = strtok(NULL, " "); // "informatii" aici se refera la index
            int32_t index;
            index = convert32(informatii);
            find(arr, len, index);
        }
        if(strcmp(informatii, "delete_at") == 0){
            informatii = strtok(NULL, " "); // "informatii" aici se refera la index
            int index;
            index = convert32(informatii);
            delete_at(&arr, &len, index);
        }
        if(strcmp(informatii, "print") == 0){
            print(arr, len);
        }
        
        fgets(input, INPUTSIZE, stdin);
        input[strcspn(input, "\n")] = 0;
    }
    if(strcmp(input, "exit") == 0){
        // exit - se va elibera memoria si se va iesi din program
        free(arr);
        return 0;
    }
	return 0;
}