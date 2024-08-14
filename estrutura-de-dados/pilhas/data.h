#include <stdio.h>
#include <stdlib.h>

struct TPtPilha{
        TipoInfo dado;
        struct TPtPilha *elo;
};

typedef struct TPtPilha TipoPilha;
typedef int TipoInfo;

TipoPilha* inicializaPilha ();
int pilhaVazia(TipoPilha *Topo);
void imprimePilha(TipoPilha *Topo);
TipoPilha* pushPilha(TipoPilha *Topo, TipoInfo Dado);
int popPilha(TipoPilha **Topo, TipoInfo *Dado);
TipoInfo consultaPilha(TipoPilha *Topo);
TipoPilha* destroiPilha(TipoPilha *Topo);
int comparaPilhas(TipoPilha *TopoUm, TipoPilha *TopoDois);
