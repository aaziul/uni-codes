package br.edu.ufrgs.controller;

import br.edu.ufrgs.model.Aluno;
import br.edu.ufrgs.model.AnaliseElegibilidade;
import br.edu.ufrgs.model.RegraBolsa;
import br.edu.ufrgs.controller.CsvRegraBolsaReader;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/processa")
public class ServletMedia extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String nome = request.getParameter("nome");
            double nota1 = Double.parseDouble(request.getParameter("nota1"));
            double nota2 = Double.parseDouble(request.getParameter("nota2"));
            double nota3 = Double.parseDouble(request.getParameter("nota3"));
            int faltas = Integer.parseInt(request.getParameter("faltas"));

            Aluno aluno = new Aluno(nome, nota1, nota2, nota3, faltas);
            String mensagem = aluno.getMensagemFinal();

            request.setAttribute("resultado", mensagem);
            
            try {
                List<RegraBolsa> regras = CsvRegraBolsaReader.lerRegras("/regras_bolsa.csv");
                
                if (!regras.isEmpty()) {
                    AnaliseElegibilidade analise = new AnaliseElegibilidade();
                    StringBuilder resultadosBolsas = new StringBuilder();
                    
                    for (RegraBolsa regra : regras) {
                        String elegibilidade = analise.verificaElegibilidadeBolsa(aluno.media(), faltas, regra);
                        String nomeBolsaFormatado = regra.getNomeBolsaFormatado();
                        
                        resultadosBolsas.append(nomeBolsaFormatado);
                        resultadosBolsas.append(": ");
                        resultadosBolsas.append(elegibilidade);
                        resultadosBolsas.append("\n");
                    }
                    
                    request.setAttribute("elegibilidade", resultadosBolsas.toString());
                    request.setAttribute("analisouTodas", true);
                }
            } catch (IOException e) {
                request.setAttribute("elegibilidade", "Erro ao ler regras de bolsa: " + e.getMessage());
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("resultado", "Erro: Informe uma nota válida.");
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}