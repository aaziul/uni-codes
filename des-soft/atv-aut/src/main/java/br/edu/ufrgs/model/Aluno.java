package br.edu.ufrgs.model;
import java.text.DecimalFormat;

public class Aluno {
    private String nome;
    private double nota1;
    private double nota2;
    private double nota3;
    private int faltas;

    public Aluno(String nome, double nota1, double nota2, double nota3, int faltas) {
        this.nome = nome;
        this.nota1 = nota1;
        this.nota2 = nota2;
        this.nota3 = nota3;
        this.faltas = faltas;
    }

    public double media(){
        double media = (nota1 + nota2 + nota3) / 3;

        return media;
    }

    public String verificarConceito() {
        double notaAluno = media();
        String notaConceito = "";

        if(notaAluno < 6.0){
            notaConceito = "D";
        } else if(notaAluno >= 6.0 && notaAluno < 7.0){
            notaConceito = "C";
        } else if(notaAluno >= 7.0 && notaAluno < 9.0){
            notaConceito = "B";
        } else if(notaAluno >= 9.0){
            notaConceito = "A";
        }

        return notaConceito;
    }

    public String verificarSituacao() {
        return (this.media() >= 6.0) ? "Aprovado(a)" : "Reprovado(a)";
    }

    public String getMensagemFinal() {
        DecimalFormat df = new DecimalFormat("0.00"); // formata o double para 2 casas decimais

        return "O aluno " + nome + " está " + verificarSituacao() + " com média " + df.format(media()) + " e conceito " + verificarConceito();
    }
}