struct sTipoFila{
    int info;
    struct sTipoFila* prox;
};

typedef struct sTipoFila TipoFila;

TipoFila* cria_fila(void);
TipoFila* insere (TipoFila *l, int dado);
int vazia (TipoFila* l);
int removeFila(TipoFila **l);
void imprime(TipoFila* l);
