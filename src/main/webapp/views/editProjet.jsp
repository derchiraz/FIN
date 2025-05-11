<%-- 
    Document   : editProjet
    Created on : 9 mai 2025
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
    <title>Modifier un Projet</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/projet.css">
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
                                <a href="${pageContext.request.contextPath}/views/projet.jsp">
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
                                <a href="${pageContext.request.contextPath}/views/opportunite.jsp">
                                    <i class="fas fa-plus-circle"></i> Ajouter opportunité
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeOpportunite.jsp">
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
                        <span>Modifier</span>
                    </div>
                    <div class="header-top">
                        <h1>Modifier un Projet</h1>
                        <div class="header-actions">
                            <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/projet/details/${projet.id}'">
                                <span class="icon"><i class="fas fa-eye"></i></span> Voir Détails
                            </button>
                        </div>
                    </div>
                    <div class="header-divider"></div>
                </div>

                <form action="${pageContext.request.contextPath}/projet/update" method="post" onsubmit="return validateForm(event)">
                    <!-- Identifiant caché -->
                    <input type="hidden" name="id" value="${projet.id}" />

                    <div class="form-container">
                        <div class="form-section">
                            <h4 class="section-title">Informations Générales</h4>
                            <div class="input-group">
                                <label for="nom">Nom projet</label>
                                <input type="text" id="nom" name="nom" class="form-control" 
                                      value="${projet.nom}" required>
                            </div>
                            <div class="input-group">
                                <label for="nomCourt">Nom court</label>
                                <input type="text" id="nomCourt" name="nomCourt" class="form-control" 
                                      value="${projet.nomCourt}" required>
                            </div>
                            <div class="input-group">
                                <label for="description">Descriptif du projet</label>
                                <textarea id="description" name="description" class="form-control" 
                                         rows="3" required>${projet.description}</textarea>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h4 class="section-title">Détails du Projet</h4>
                            <div class="input-group">
                                <label for="budget">Budget (DA)</label>
                                <input type="number" id="budget" name="budget" class="form-control" 
                                      value="${projet.budget}" required>
                            </div>
                            <div class="input-group">
                                <label for="status">Status</label>
                                <select id="status" name="status" class="form-control" required>
                                    <option value="enCours" ${projet.status == 'enCours' ? 'selected' : ''}>En cours</option>
                                    <option value="terminée" ${projet.status == 'terminée' ? 'selected' : ''}>Terminée</option>
                                    <option value="enAttente" ${projet.status == 'enAttente' ? 'selected' : ''}>En attente</option>
                                    <option value="clôturée" ${projet.status == 'clôturée' ? 'selected' : ''}>Clôturée</option>
                                </select>
                            </div>
                            <div class="input-group">
                                <label for="responsable_id">Responsable</label>
                                <select id="responsable_id" name="responsable_id" class="form-control" required>
                                   <option value="">Choisir...</option>
                                   <c:forEach var="utilisateur" items="${utilisateurs}">
                                <option value="${utilisateur.id}">${utilisateur.nom} ${utilisateur.prenom}</option>
                               </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-container">
                        <div class="form-section">
                            <h4 class="section-title">Calendrier</h4>
                            <div class="input-group">
                                <label for="date_debut">Date de début</label>
                                <input type="date" id="dateDebut" name="dateDebut" class="form-control" 
                                       value="<fmt:formatDate value='${projet.dateDebut}' pattern='yyyy-MM-dd' />" required>
                            </div>
                            <div class="input-group">
                                <label for="date_fin">Date de fin</label>
                                <input type="date" id="dateFin" name="dateFin" class="form-control" 
                                       value="<fmt:formatDate value='${projet.dateFin}' pattern='yyyy-MM-dd' />" required>
                            </div>
                            <div id="dateError" class="error-message" style="display: none;">
                                <i class="fas fa-exclamation-triangle"></i> La date de fin doit être après la date de début.
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn-secondary" onclick="location.href='${pageContext.request.contextPath}/projet/liste'">
                            Annuler
                        </button>
                        <button type="submit" class="btn-primary">
                            <i class="fas fa-save"></i> Enregistrer les modifications
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <!-- Scripts -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Gestion du menu utilisateur
            const avatarTrigger = document.getElementById('avatar-trigger');
            const userDropdown = document.getElementById('user-dropdown');
            
            if (avatarTrigger) {
                avatarTrigger.addEventListener('click', function() {
                    userDropdown.classList.toggle('show');
                });
                
                // Fermer le dropdown quand on clique ailleurs
                document.addEventListener('click', function(e) {
                    if (!avatarTrigger.contains(e.target)) {
                        userDropdown.classList.remove('show');
                    }
                });
            }
            
            // Toggle sidebar
            const sidebarCollapse = document.getElementById('sidebar-collapse');
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            
            if (sidebarCollapse) {
                sidebarCollapse.addEventListener('click', function() {
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('expanded');
                });
            }
            
            // Gestion des submenus
            const submenus = document.querySelectorAll('.has-submenu');
            submenus.forEach(function(item) {
                item.addEventListener('click', function(e) {
                    if (e.target.closest('.submenu')) return;
                    this.classList.toggle('active');
                    const submenu = this.nextElementSibling;
                    if (submenu && submenu.classList.contains('submenu')) {
                        submenu.classList.toggle('show');
                    }
                });
            });
        });
        
        // Validation du formulaire
        function validateForm(event) {
            const dateDebut = new Date(document.getElementById('date_debut').value);
            const dateFin = new Date(document.getElementById('date_fin').value);
            const dateError = document.getElementById('dateError');
            
            // Vérifier que la date de fin est après la date de début
            if (dateFin < dateDebut) {
                dateError.style.display = 'block';
                event.preventDefault();
                return false;
            }
            
            dateError.style.display = 'none';
            return true;
        }
    </script>
</body>
</html>