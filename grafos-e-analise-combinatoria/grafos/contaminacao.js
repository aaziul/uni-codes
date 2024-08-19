const readline = require('readline');

const propagarContaminacao = (mapa, N, M) => {
    // Copia o mapa original
    const resultado = mapa.map(linha => linha.split(''));

    // Direções de movimento: cima, baixo, esquerda, direita
    const direcoes = [
        [-1, 0], // cima
        [1, 0],  // baixo
        [0, -1], // esquerda
        [0, 1]   // direita
    ];
    
    // Fila para BFS
    const fila = [];

    // Adiciona todas as células contaminadas à fila
    for (let i = 0; i < N; i++) {
        for (let j = 0; j < M; j++) {
            if (mapa[i][j] === 'T') {
                fila.push([i, j]);
            }
        }
    }

    // Processa a BFS
    while (fila.length > 0) {
        const [x, y] = fila.shift();

        for (const [dx, dy] of direcoes) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < N && ny >= 0 && ny < M) {
                if (mapa[nx][ny] === 'A' && resultado[nx][ny] !== 'T') {
                    resultado[nx][ny] = 'T';
                    fila.push([nx, ny]);
                }
            }
        }
    }

    return resultado;
};

const lerMapa = async () => {
    const input = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    const linhas = [];
    for await (const linha of input) {
        linhas.push(linha);
    }
    
    const mapas = [];
    let index = 0;

    while (index < linhas.length) {
        const [N, M] = linhas[index].split(' ').map(Number);
        index++;
        
        if (N === 0 && M === 0) {
            break;
        }

        const mapa = [];
        for (let i = 0; i < N; i++) {
            mapa.push(linhas[index]);
            index++;
        }
        
        mapas.push([N, M, mapa]);
    }

    return mapas;
};

const imprimirMapa = (mapa) => {
    mapa.forEach(linha => {
        console.log(linha.join(''));
    });
    console.log();
};

const principal = async () => {
    const mapas = await lerMapa();
    
    for (const [N, M, mapa] of mapas) {
        const mapaContaminado = propagarContaminacao(mapa, N, M);
        imprimirMapa(mapaContaminado);
    }
};

principal();
