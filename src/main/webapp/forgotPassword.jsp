<%-- 
    Document   : forgotPassword
    Created on : 18 mars 2025, 00:42:22
    Author     : L13
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>EADN Timex - Mot de passe oublié</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
            border-radius: 4px;
        }
        .dev-message {
            background-color: #cce5ff;
            color: #004085;
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid #b8daff;
            border-radius: 4px;
            word-break: break-all;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><span class="eadn">EADN</span> <span class="timex">Timex</span></h1>
            <h2>Enterprise d'Appui au Développement du Numérique</h2>
        </div>
        
        <div class="card">
            <h3>Mot de passe oublié?</h3>
            <p>Entrez votre adresse email et nous vous enverrons un lien pour réinitialiser votre mot de passe.</p>
            
            <!-- Message d'erreur si présent -->
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            
            <!-- Message de succès si présent -->
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="success-message">
                    <%= request.getAttribute("successMessage") %>
                </div>
            <% } %>
            
            <!-- Message pour le développement si présent -->
            <% if (request.getAttribute("devMessage") != null) { %>
                <div class="dev-message">
                    <%= request.getAttribute("devMessage") %>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="email" 
                           id="email" 
                           name="email" 
                           class="form-control"
                           placeholder="exemple@gmail.com" 
                           required>
                </div>
                
                <button type="submit" class="btn-primary">
                    Envoyer le lien 
                </button>
            </form>
            
            <p class="bottom-text">
                Vous vous souvenez de votre mot de passe? 
                <a href="${pageContext.request.contextPath}/login">Se connecter</a>
            </p>
        </div>
    </div>
</body>
</html>