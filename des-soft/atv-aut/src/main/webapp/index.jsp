<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
    <h2>Lançamento de Notas</h2>
    <form action="processa" method="post">
        Nome: <input type="text" name="nome" value="${param.nome}" required><br><br>
        Nota 1: <input type="number" step="0.1" name="nota1" value="${param.nota1}" min="0" max="10" required><br><br>
        Nota 2: <input type="number" step="0.1" name="nota2" value="${param.nota2}" min="0" max="10" required><br><br>
        Nota 3: <input type="number" step="0.1" name="nota3" value="${param.nota3}" min="0" max="10" required><br><br>
        Faltas: <input type="number" name="faltas" value="${param.faltas}" min="0" required><br><br>
        <button type="submit">Processar</button>
    </form>

    <%-- Exibe os resultados se existirem no request --%>
    <% if (request.getAttribute("resultado") != null) { %>
        <hr>
        <h3>Verificação de Situação:</h3>
        <p><strong><%= request.getAttribute("resultado") %></strong></p>
        
        <h3>Elegibilidade para Bolsas:</h3>
        <% Boolean analisouTodas = (Boolean) request.getAttribute("analisouTodas"); %>
        <% if (analisouTodas != null && analisouTodas) { %>
            <p>
                <% String resultados = (String) request.getAttribute("elegibilidade"); %>
                <% for (String linha : resultados.split("\n")) { %>
                    <% if (!linha.trim().isEmpty()) { %>
                        <strong><%= linha %></strong><br>
                    <% } %>
                <% } %>
            </p>
        <% } else if (request.getAttribute("elegibilidade") != null) { %>
            <p><strong><%= request.getAttribute("elegibilidade") %></strong></p>
        <% } %>
    <% } %>
</body>
</html>