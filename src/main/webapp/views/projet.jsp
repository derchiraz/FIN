<%-- 
    Document   : projet
    Created on : 6 avr. 2025, 23:51:17
    Author     : L13
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Ajouter un Projet</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/projet.css">
    <!-- Icons pour la sidebar -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
    .membre-row {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-top: 10px;
    }

    .btn-remove {
        background-color: #e74c3c;
        color: white;
        border: none;
        padding: 6px 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn-remove:hover {
        background-color: #c0392b;
    }
    </style>
</head>
<body>
    <!-- Header principal -->
    <header class="main-header">
        <div class="logo">
            <span class="eadn">EADN</span> <span class="timex">Timex</span>
        </div>
        <div class="header-search">
            <input type="text" placeholder="Rechercher...">
            <button><i class="fas fa-search"></i></button>
        </div>
        <div class="user-menu">
            <span class="user-name">${sessionScope.utilisateur.nom}</span>
            <div class="user-avatar" id="avatar-trigger">
                <span>${sessionScope.utilisateur.initiales}</span>
                <i class="fas fa-chevron-down"></i>
            </div>
            <div class="user-dropdown" id="user-dropdown">
                <div class="dropdown-header">
                    <div class="user-avatar-lg">${sessionScope.utilisateur.initiales}</div>
                    <div class="user-info">
                        <div class="user-fullname">${sessionScope.utilisateur.nom} ${sessionScope.utilisateur.prenom}</div>
                        <div class="user-email">${sessionScope.utilisateur.email}</div>
                    </div>
                </div>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath}/views/coordonne.jsp"><i class="fas fa-user"></i> Mes coordonnées</a></li>
                   
                    <li class="divider"></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/views/login.jsp" class="login">
                            <i class="fas fa-sign-out-alt"></i> Déconnexion
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </header>

    <!-- Layout principal avec sidebar et contenu -->
    <div class="main-layout">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
           
            <nav class="sidebar-nav">
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}/views/home.jsp" class="nav-item">
                            <i class="fas fa-home"></i>
                            <span>Accueil</span>
                        </a>
                    </li>
                    
                    <li>
                        <a href="#" class="nav-item has-submenu active" id="project-menu">
                            <i class="fas fa-project-diagram"></i>
                            <span>Projets</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu show" id="project-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/load-form-data?page=projet" class="active">
                                    <i class="fas fa-plus-circle"></i> Ajouter projet
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeProjet.jsp" >
                                    <i class="fas fa-list"></i> Liste des projets
                                </a>
                            </li>
                            
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="nav-item has-submenu " id="opportunite-menu">
                            <i class="fas fa-lightbulb"></i>
                            <span>Opportunités</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu " id="opportunite-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/load-form-data?page=opportunite">
                                    <i class="fas fa-plus-circle"></i> Ajouter opportunité
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeOpportunite.jsp" >
                                    <i class="fas fa-list"></i> Liste des opportunités
                                </a>
                            </li>
                            
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="nav-item has-submenu" id="team-menu">
                            <i class="fas fa-users"></i>
                            <span>Ressource</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu" id="team-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/ressources.jsp">
                                    <i class="fas fa-user-plus"></i> Nouvel employé
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeRessources.jsp">
                                    <i class="fas fa-users-cog"></i> liste des employés
                                </a>
                            </li>
                            
                        </ul>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/views/timesheet.jsp" class="nav-item">
                            <i class="fas fa-cog"></i>
                            <span>Timesheet</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="sidebar-footer">
                <div class="sidebar-collapse" id="sidebar-collapse">
                    <i class="fas fa-chevron-left"></i>
                </div>
                <div class="theme-toggle" id="theme-toggle">
                    <i class="fas fa-moon"></i>
                </div>
            </div>
        </aside>

        <!-- Contenu principal -->
        <main class="main-content" id="main-content">
            <div class="container">
                <div class="app-header">
                    <div class="breadcrumbs">
                        <a href="${pageContext.request.contextPath}/views/home.jsp">Accueil</a> / 
                        <span> Projet</span>/ 
                        <span>Ajouter un projet</span>
                    </div>
                    <div class="header-top">
                        <h1>Ajouter un Projet</h1>
                        <div class="header-actions">
                            <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/views/listeProjet.jsp'">
                                <span class="icon"><i class="fas fa-list"></i></span> Liste des Projets
                            </button>
                        </div>
                    </div>
                    <div class="header-divider"></div>
                </div>

                <form action="${pageContext.request.contextPath}/projet/save" method="post" onsubmit="return validateForm(event)">
                    <div class="form-container">
                        <div class="form-section">
                            <h4 class="section-title">Informations Générales</h4>
                            <div class="input-group">
                                <label for="nom">Nom projet</label>
                                <input type="text" id="nom" name="nom" class="form-control" 
                                      placeholder="Entrez le nom du projet" required>
                            </div>
                            <div class="input-group">
                                <label for="nomCourt">Nom court</label>
                                <input type="text" id="nomCourt" name="nomCourt" class="form-control" 
                                      placeholder="Nom abrégé" required>
                            </div>
                            <div class="input-group">
                                <label for="description">Descriptif du projet</label>
                                <textarea id="description" name="description" class="form-control" 
                                         placeholder="Décrivez le projet..." required></textarea>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h4 class="section-title">Détails du Projet</h4>
                            <div class="input-group">
                                <label for="budget">Budget (DA)</label>
                                <input type="number" id="budget" name="budget" class="form-control" 
                                      placeholder="Montant..." required>
                            </div>
                            <div class="input-group">
                                <label for="status">Status</label>
                                <select id="status" name="status" class="form-control" required>
                                    <option value="">Sélectionnez un status</option>
                                    <option value="enCours" >En cours</option>
                                    <option value="terminee">Terminée</option>
                                    <option value="enAttente">En attente</option>
                                    <option value="cloturee" >Clôturée</option>

                                </select>
                            </div>
                            <div class="input-group">
                                <label for="progression">Progression (%)</label>
                                <input type="number" id="progression" name="progression" class="form-control"
                                      value="${projet.progression}" min="0" max="100" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-container">
                        <div class="form-section">
                            <h4 class="section-title">Calendrier</h4>
                            <div class="input-group">
                                <label for="dateDebut">Date de début</label>
                                <div class="date-input-wrapper">
                                    <input type="date" id="dateDebut" name="dateDebut" class="form-control" required>
                                    
                                </div>
                            </div>
                            <div class="input-group">
                                <label for="dateFin">Date de fin</label>
                                <div class="date-input-wrapper">
                                    <input type="date" id="dateFin" name="dateFin" class="form-control" required>
                                   
                                </div>
                            </div>
                            <div id="error-message" class="error-message">
                                <i class="fas fa-exclamation-triangle"></i> La date de fin doit être après la date de début.
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h4 class="section-title">Équipe du Projet</h4>

                            <!-- Responsable -->
                            <div class="input-group">
                                <label for="responsable">Responsable du projet</label>
                                <select id="responsable" name="responsable" class="form-control" required>
                                    <option value="">Choisir...</option>
                                    <c:forEach var="utilisateur" items="${utilisateurs}">
                                        <option value="${utilisateur.id}">${utilisateur.nom} ${utilisateur.prenom}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Membres dynamiques -->
                            <div id="membres-wrapper">
                                <label>Membres du projet</label>
                                <div id="membre-template" style="display: none;">
                                <div class="membre-row input-group">
                                    <select name="membres" class="form-control">
                                        <option value="">Choisir...</option>
                                        <c:forEach var="utilisateur" items="${utilisateurs}">
                                            <option value="${utilisateur.id}">${utilisateur.nom} ${utilisateur.prenom}</option>
                                        </c:forEach>
                                    </select>
                                    <button type="button" class="btn-remove" onclick="removeMembre(this)">−</button>
                                </div>
                            </div>
                            </div>

                            <button type="button" class="btn-secondary" onclick="addMembre()">+ Ajouter un membre</button>
                        </div>
                    </div>

                    <div class="btn-container">
                        <button type="reset" class="btn-secondary">Annuler</button>
                        <button type="submit" class="btn-primary">
                            <i class="fas fa-save"></i> Sauvegarder
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <!-- Notification toast -->
    <div class="toast-container">
        <div class="toast" id="toast-success">
            <div class="toast-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="toast-content">
                <div class="toast-title">Succès!</div>
                <div class="toast-message">Le projet a été ajouté avec succès.</div>
            </div>
            <button class="toast-close">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <!-- Inclusion du fichier JavaScript externe -->
    <script src="${pageContext.request.contextPath}/js/projet.js"></script>
</body>
</html>