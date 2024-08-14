struct sTipoFila{
    int info;
    struct sTipoFila* prox;
};

typedef struct sTipoFila TipoFila;

TipoFila* criaFila(void);
TipoFila* insereFila (TipoFila *l, int dado);
int filaVazia (TipoFila* l);
int removeFila(TipoFila **l);
void imprimeFila(TipoFila* l);
void DFS(int matrizAdj[8][8], int vertice, int visitado[]);
void BFS(int grafo[8][8], int vertice);
