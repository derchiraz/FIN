<%-- 
    Document   : detailProjet
    Created on : 5 mai 2025, 00:30:00
    Author     : L13
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Détails du Projet</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/projet.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/listeProjet.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
                                <a href="${pageContext.request.contextPath}/load-form-data?page=projet">
                                    <i class="fas fa-plus-circle"></i> Ajouter projet
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/projet/liste" class="active">
                                    <i class="fas fa-list"></i> Liste des projets
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="nav-item has-submenu" id="opportunite-menu">
                            <i class="fas fa-lightbulb"></i>
                            <span>Opportunités</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu" id="opportunite-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/load-form-data?page=opportunite">
                                    <i class="fas fa-plus-circle"></i> Ajouter opportunité
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/opportunite/liste">
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
                        <a href="${pageContext.request.contextPath}/projet/liste">Liste des Projets</a> / 
                        <span>Détails</span>
                    </div>
                    <div class="header-top">
                        <h1>Détails du Projet</h1>
                        <div class="header-actions">
                            <button class="btn-action" onclick="window.location.href='${pageContext.request.contextPath}/projet/edit?id=${projet.id}'">
                                <i class="fas fa-edit"></i> Modifier
                            </button>
                            <button type="button" class="btn-action btn-danger" onclick="confirmerSuppression(${projet.id})">
                                <i class="fas fa-trash"></i> Supprimer
                            </button>
                        </div>
                    </div>
                    <div class="header-divider"></div>
                </div>

                <!-- Détails du projet -->
                <div class="form-container">
                    <div class="form-section">
                        <h4 class="section-title">Informations Générales</h4>
                        <p><strong>Nom du projet :</strong> ${projet.nom}</p>
                        <p><strong>Nom court :</strong> ${projet.nomCourt}</p>
                        <p><strong>Description :</strong> ${projet.description}</p>
                        
                        <p><strong>Statut :</strong> 
                            <span class="status-badge 
                                <c:choose>
                                    <c:when test="${projet.status eq 'enCours'}">status-progress</c:when>
                                    <c:when test="${projet.status eq 'terminée'}">status-completed</c:when>
                                    <c:when test="${projet.status eq 'enAttente'}">status-pending</c:when>
                                    <c:when test="${projet.status eq 'clôturée'}">status-cancelled</c:when>
                                    <c:otherwise>status-pending</c:otherwise>
                                </c:choose>
                            ">
                                <c:choose>
                                    <c:when test="${projet.status eq 'enCours'}">En cours</c:when>
                                    <c:when test="${projet.status eq 'terminée'}">Terminé</c:when>
                                    <c:when test="${projet.status eq 'enAttente'}">En attente</c:when>
                                    <c:when test="${projet.status eq 'clôturée'}">Clôturé</c:when>
                                    <c:otherwise>${projet.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </p>
                        
                        <p><strong>Progression :</strong> 
                            <div class="progress-bar">
                                <div class="progress" style="width: ${projet.progression}%"></div>
                                <span class="progress-text">${projet.progression}%</span>
                            </div>
                        </p>
                    </div>

                    <div class="form-section">
                        <h4 class="section-title">Dates et Budget</h4>
                        <p><strong>Date de début :</strong> <fmt:formatDate value="${projet.dateDebut}" pattern="dd/MM/yyyy" /></p>
                        <p><strong>Date de fin :</strong> <fmt:formatDate value="${projet.dateFin}" pattern="dd/MM/yyyy" /></p>
                        <p><strong>Durée (jours) :</strong> ${projet.dureeEnJours}</p>
                        <p><strong>Budget :</strong> <fmt:formatNumber value="${projet.budget}" type="currency" currencySymbol="DA"/></p>
                    </div>
                </div>

                <div class="form-container">
                    <div class="form-section">
                        <h4 class="section-title">Équipe</h4>
                        <p><strong>Responsable :</strong> 
                            <c:forEach var="utilisateur" items="${utilisateurs}">
                                <c:if test="${utilisateur.id == projet.responsable}">
                                    ${utilisateur.nom} ${utilisateur.prenom}
                                </c:if>
                            </c:forEach>
                            ${projet.responsable == null ? 'Non assigné' : ''}
                        </p>
                        
                        <p><strong>Membres :</strong></p> 
                        <c:if test="${not empty membresProjets}">
    <ul>
        <c:forEach var="membre" items="${membresProjets}">
            <li>${membre.nom} ${membre.prenom}</li>
        </c:forEach>
    </ul>
</c:if>

                        <c:if test="${empty membresProjets}">
                            <p class="text-muted">Aucun membre assigné</p>
                        </c:if>
                    </div>
                </div>

                <div class="btn-container">
                    <button class="btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/projet/liste'">Retour</button>
                </div>
            </div>
        </main>
    </div>

    <!-- Modal confirmation suppression -->
    <div class="modal" id="deleteModal">
        <div class="modal-content">
            <div class="modal-header">
                <h4>Confirmation</h4>
                <button class="close-modal" onclick="fermerModal()"><i class="fas fa-times"></i></button>
            </div>
            <div class="modal-body">
                <p>Confirmez-vous la suppression de ce projet ?</p>
            </div>
            <div class="modal-footer">
                <form method="post" action="${pageContext.request.contextPath}/projet/delete">
                    <input type="hidden" id="deleteProjetId" name="id" value="${projet.id}">
                    <button type="button" class="btn-secondary" onclick="fermerModal()">Annuler</button>
                    <button type="submit" class="btn-danger">Supprimer</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Notification toast -->
    <div class="toast-container">
        <div class="toast" id="toast-success">
            <div class="toast-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="toast-content">
                <div class="toast-title">Succès!</div>
                <div class="toast-message">L'opération a été effectuée avec succès.</div>
            </div>
            <button class="toast-close">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <!-- JavaScript pour la page -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialiser le menu déroulant utilisateur
            initUserDropdown();
            
            // Initialiser la barre latérale
            initSidebar();
            
            // Initialiser le toggle de thème
            initThemeToggle();
            
            // Initialiser la modale de suppression
            initDeleteModal();
            
            // Initialiser les toasts de notification
            initToasts();
            
            // Afficher la notification de succès si demandé
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('success') === 'true') {
                showToast('toast-success');
            }
        });
        
        /**
         * Initialise le menu déroulant utilisateur
         */
        function initUserDropdown() {
            const avatarTrigger = document.getElementById('avatar-trigger');
            const userDropdown = document.getElementById('user-dropdown');
            
            if (avatarTrigger && userDropdown) {
                avatarTrigger.addEventListener('click', function() {
                    userDropdown.classList.toggle('show');
                });
                
                // Fermer le dropdown si on clique ailleurs
                document.addEventListener('click', function(event) {
                    if (!event.target.closest('#avatar-trigger') && !event.target.closest('#user-dropdown')) {
                        userDropdown.classList.remove('show');
                    }
                });
            }
        }
        
        /**
         * Initialise la barre latérale et les sous-menus
         */
        function initSidebar() {
            // Toggle de la sidebar
            const sidebarCollapse = document.getElementById('sidebar-collapse');
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            
            if (sidebarCollapse && sidebar && mainContent) {
                sidebarCollapse.addEventListener('click', function() {
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('expanded');
                });
            }
            
            // Toggle des sous-menus
            const menuItems = document.querySelectorAll('.nav-item.has-submenu');
            
            menuItems.forEach(function(item) {
                item.addEventListener('click', function(e) {
                    if (e.target === item || e.target.parentElement === item) {
                        const submenu = item.nextElementSibling;
                        const icon = item.querySelector('.submenu-icon');
                        
                        if (submenu && submenu.classList.contains('submenu')) {
                            e.preventDefault();
                            submenu.classList.toggle('show');
                            icon.classList.toggle('rotated');
                        }
                    }
                });
            });
        }
        
        /**
         * Initialise le toggle de thème clair/sombre
         */
        function initThemeToggle() {
            const themeToggle = document.getElementById('theme-toggle');
            const body = document.body;
            
            // Vérifier si un thème est déjà enregistré
            const currentTheme = localStorage.getItem('theme');
            if (currentTheme) {
                body.classList.add(currentTheme);
                if (currentTheme === 'dark-theme') {
                    themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
                }
            }
            
            if (themeToggle) {
                themeToggle.addEventListener('click', function() {
                    body.classList.toggle('dark-theme');
                    
                    // Mettre à jour l'icône
                    if (body.classList.contains('dark-theme')) {
                        themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
                        localStorage.setItem('theme', 'dark-theme');
                    } else {
                        themeToggle.innerHTML = '<i class="fas fa-moon"></i>';
                        localStorage.setItem('theme', '');
                    }
                });
            }
        }
        
        /**
         * Initialise la modale de suppression
         */
        function initDeleteModal() {
            const modal = document.getElementById('deleteModal');
            const closeButtons = modal.querySelectorAll('.close-modal, .btn-secondary');
            
            closeButtons.forEach(function(button) {
                button.addEventListener('click', function() {
                    fermerModal();
                });
            });
            
            // Fermer si on clique en dehors de la modale
            window.addEventListener('click', function(event) {
                if (event.target === modal) {
                    fermerModal();
                }
            });
        }
        
        /**
         * Initialise les toasts de notification
         */
        function initToasts() {
            const toasts = document.querySelectorAll('.toast');
            
            toasts.forEach(function(toast) {
                const closeBtn = toast.querySelector('.toast-close');
                if (closeBtn) {
                    closeBtn.addEventListener('click', function() {
                        toast.classList.remove('show');
                    });
                }
            });
        }
        
        /**
         * Affiche un toast de notification
         */
        function showToast(toastId) {
            const toast = document.getElementById(toastId);
            if (toast) {
                toast.classList.add('show');
                setTimeout(function() {
                    toast.classList.remove('show');
                }, 5000);
            }
        }
        
        /**
         * Affiche la modale de confirmation de suppression
         */
        function confirmerSuppression(projetId) {
            const modal = document.getElementById('deleteModal');
            document.getElementById('deleteProjetId').value = projetId;
            modal.style.display = 'block';
        }
        
        /**
         * Ferme la modale
         */
        function fermerModal() {
            const modal = document.getElementById('deleteModal');
            modal.style.display = 'none';
        }
    </script>
</body>
</html>