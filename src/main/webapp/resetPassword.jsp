<%-- 
    Document   : resetPassword
    Created on : 18 mars 2025, 00:45:00
    Author     : L13
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>EADN Timex - Réinitialiser le mot de passe</title>
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
        .password-container {
            position: relative;
        }
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            user-select: none;
        }
        .password-hint {
            font-size: 0.8em;
            color: #6c757d;
            margin-top: 5px;
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
            <h3>Réinitialiser votre mot de passe</h3>
            <p>Choisissez un nouveau mot de passe pour votre compte.</p>
            
            <!-- Message d'erreur si présent -->
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/reset-password" method="post">
                <input type="hidden" name="token" value="${token}">
                
                <div class="input-group">
                    <label for="password">Nouveau mot de passe</label>
                    <div class="password-container">
                        <input type="password" 
                               id="password" 
                               name="password" 
                               class="form-control"
                               placeholder="Créez un nouveau mot de passe" 
                               required>
                        <span class="password-toggle" onclick="togglePassword('password')">👁</span>
                    </div>
                    <div class="password-hint">
                        Minimum 8 caractères, incluant lettres, chiffres et caractères spéciaux
                    </div>
                </div>
                
                <div class="input-group">
                    <label for="confirmPassword">Confirmez le mot de passe</label>
                    <div class="password-container">
                        <input type="password" 
                               id="confirmPassword" 
                               name="confirmPassword" 
                               class="form-control"
                               placeholder="Confirmez votre mot de passe" 
                               required>
                        <span class="password-toggle" onclick="togglePassword('confirmPassword')">👁</span>
                    </div>
                </div>
                
                <button type="submit" class="btn-primary">
                    Réinitialiser le mot de passe
                </button>
            </form>
            
            <p class="bottom-text">
                <a href="${pageContext.request.contextPath}/login">Retour à la connexion</a>
            </p>
        </div>
    </div>

    <script>
        function togglePassword(fieldId) {
            const passwordInput = document.getElementById(fieldId);
            const toggleButton = passwordInput.nextElementSibling;
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleButton.style.opacity = '0.7';
            } else {
                passwordInput.type = 'password';
                toggleButton.style.opacity = '1';
            }
        }
    </script>
</body>
</html>