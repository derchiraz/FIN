<%-- 
    Document   : detailsOpportunite
    Created on : 13 avr. 2025, 22:21:36
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
    <title>Détails de l'Opportunité</title>
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
                        <a href="#" class="nav-item has-submenu" id="project-menu">
                            <i class="fas fa-project-diagram"></i>
                            <span>Projets</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu" id="project-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/projet.jsp">
                                    <i class="fas fa-plus-circle"></i> Ajouter projet
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/views/listeProjet.jsp">
                                    <i class="fas fa-list"></i> Liste des projets
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="nav-item has-submenu active" id="opportunite-menu">
                            <i class="fas fa-lightbulb"></i>
                            <span>Opportunités</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu show" id="opportunite-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/load-form-data?page=opportunite">
                                    <i class="fas fa-plus-circle"></i> Ajouter opportunité
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/opportunite/liste" class="active">
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
                        <a href="${pageContext.request.contextPath}/opportunite/liste">Opportunités</a> / 
                        <span>Détails</span>
                    </div>
                    <div class="header-top">
                        <h1>Détails de l'Opportunité</h1>
                        <div class="header-actions">
                            <button class="btn-action" onclick="window.location.href='${pageContext.request.contextPath}/opportunite/edit?id=${opportunite.id}'">
                                <i class="fas fa-edit"></i> Modifier
                            </button>
                            <button class="btn-action btn-danger" onclick="confirmerSuppression(${opportunite.id})">
                                <i class="fas fa-trash"></i> Supprimer
                            </button>
                            
                        </div>
                    </div>
                    <div class="header-divider"></div>
                </div>

                <!-- Détails de l'opportunité -->
                <div class="form-container">
                    <div class="form-section">
                        <h4 class="section-title">Informations de base</h4>
                        <p><strong>Nom de l'opportunité :</strong> ${opportunite.nom_opportunite}</p>
                        <p><strong>Statut :</strong> ${opportunite.status}</p>
                        <p><strong>Description :</strong> ${opportunite.description_opportunite}</p>
                    </div>
                 
                    <div class="form-section">
                        <h4 class="section-title">Informations Client</h4>
                        <p><strong>Entreprise :</strong> ${opportunite.nom_entreprise}</p>
                        <p><strong>Contact :</strong> ${opportunite.nom_contact}</p>
                        <p><strong>Téléphone :</strong> ${opportunite.telephone}</p>
                        <p><strong>Email :</strong> ${opportunite.email}</p>
                        <p><strong>Adresse :</strong> ${opportunite.adresse}</p>
                    </div>
                </div>
              
                <div class="form-container">
                    <div class="form-section">
                        <h4 class="section-title">Période et Budget</h4>
                        <p><strong>Date de début :</strong> <fmt:formatDate value="${opportunite.dateDebut}" pattern="dd/MM/yyyy" /></p>
                        <p><strong>Date de fin :</strong> <fmt:formatDate value="${opportunite.dateFin}" pattern="dd/MM/yyyy" /></p>
                        <p><strong>Budget estimé :</strong> <fmt:formatNumber value="${opportunite.budget_estime}" type="currency" currencySymbol="DA" /></p>     
                    </div>
                    
                    <div class="form-section">
                        <h4 class="section-title">Objectifs et Architecture</h4>
                        <p><strong>Objectifs principaux :</strong> ${opportunite.objectifs_principaux}</p>
                        <p><strong>Description de l'architecture :</strong> ${opportunite.description_architecture}</p>
                    </div>
                </div>
                
                <div class="form-container">
                    <div class="form-section">
                        <h4 class="section-title">Équipe</h4>
                        <p><strong>Responsable :</strong> 
                            <c:forEach var="utilisateur" items="${utilisateurs}">
                                <c:if test="${utilisateur.id == opportunite.responsable}">
                                    ${utilisateur.nom} ${utilisateur.prenom}
                                </c:if>
                            </c:forEach>
                            ${opportunite.responsable == null ? 'Non assigné' : ''}
                        </p>
                        <p><strong>Membres :</strong></p> 
                        <c:if test="${not empty membresProjets}">
                            <ul class="membre-list">
                                <c:forEach var="membre" items="${membresProjets}">
                                    <li>
                                        <c:forEach var="utilisateur" items="${utilisateurs}">
                                            <c:if test="${utilisateur.id == membre.utilisateurId}">
                                                ${utilisateur.nom} ${utilisateur.prenom}
                                            </c:if>
                                        </c:forEach>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                        <c:if test="${empty membresProjets}">
                            <p class="text-muted">Aucun membre assigné</p>
                        </c:if>
                    </div>
                </div>

                <div class="btn-container">
                    <button class="btn-secondary" onclick="window.history.back();">Retour</button>
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
                <p>Confirmez-vous la suppression de cette opportunité ?</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="deleteOpportuniteId" value="">
                <button type="button" class="btn-secondary" onclick="fermerModal()">Annuler</button>
                <button type="button" class="btn-danger" onclick="supprimerOpportunite()">Supprimer</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Sidebar toggle
            const sidebarToggle = document.createElement('button');
            sidebarToggle.classList.add('sidebar-toggle');
            sidebarToggle.innerHTML = '<i class="fas fa-bars"></i>';
            document.querySelector('.main-header').prepend(sidebarToggle);
            
            sidebarToggle.addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('collapsed');
                document.querySelector('.main-content').classList.toggle('expanded');
            });
            
            // User dropdown toggle
            const avatarTrigger = document.getElementById('avatar-trigger');
            if (avatarTrigger) {
                avatarTrigger.addEventListener('click', function() {
                    document.getElementById('user-dropdown').classList.toggle('show');
                });
            }
            
            // Close dropdown when clicking outside
            window.addEventListener('click', function(e) {
                if (!e.target.matches('#avatar-trigger') && !e.target.closest('#avatar-trigger')) {
                    const dropdown = document.getElementById('user-dropdown');
                    if (dropdown && dropdown.classList.contains('show')) {
                        dropdown.classList.remove('show');
                    }
                }
            });
        });
        
        // Fonction pour confirmer la suppression
        function confirmerSuppression(id) {
            document.getElementById('deleteOpportuniteId').value = id;
            document.getElementById('deleteModal').classList.add('show');
        }
        
        // Fermer le modal
        function fermerModal() {
            document.getElementById('deleteModal').classList.remove('show');
        }
        
        // Fonction pour supprimer l'opportunité après confirmation
        function supprimerOpportunite() {
            const id = document.getElementById('deleteOpportuniteId').value;
            
            fetch('${pageContext.request.contextPath}/opportunite/liste', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=delete&id=' + id
            })
            .then(response => response.json())
            .then(data => {
                fermerModal();
                if (data.success) {
                    alert(data.message);
                    window.location.href = '${pageContext.request.contextPath}/opportunite/liste';
                } else {
                    alert('Erreur: ' + data.message);
                }
            })
            .catch(error => {
                fermerModal();
                console.error('Erreur:', error);
                alert('Une erreur est survenue lors de la suppression.');
            });
        }
    </script>
</body>
</html>