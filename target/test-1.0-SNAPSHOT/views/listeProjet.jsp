
<%-- 
    Document   : listeProjet
    Created on : 8 avr. 2025, 01:01:19
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
    <title>Liste des Projets</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/projet.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/listeProjet.css">
    <!-- Icons pour la sidebar -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
    .progress-container {
        width: 100%;
        background-color: #f1f1f1;
        border-radius: 12px;
        overflow: hidden;
        height: 22px;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
        position: relative;
    }

    .progress-bar {
        height: 100%;
        line-height: 22px;
        text-align: center;
        color: #fff;
        font-size: 0.75rem;
        font-weight: 600;
        width: 0%;
        border-radius: 12px;
        animation: growBar 1s ease-out forwards;
    }

    .progress-bar.low {
        background: linear-gradient(90deg, #ffc107, #ffca2c);
    }

    .progress-bar.medium {
        background: linear-gradient(90deg, #17a2b8, #20c997);
    }

    .progress-bar.high {
        background: linear-gradient(90deg, #28a745, #218838);
    }

    @keyframes growBar {
        from {
            width: 0%;
        }
        to {
            width: var(--progress-value);
        }
    }

    .progress-label {
        position: absolute;
        width: 100%;
        text-align: center;
        color: #fff;
        font-weight: 600;
        font-size: 0.75rem;
        z-index: 2;
        top: 0;
        left: 0;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        pointer-events: none;
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
                        <a href="#" class="nav-item has-submenu " id="opportunite-menu">
                            <i class="fas fa-lightbulb"></i>
                            <span>Opportunités</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu " id="opportunite-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/opportunite.jsp">
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
                         <span> Projets</span>/ 
                        <span>Liste des projets</span>
                    </div>
                    <div class="header-top">
                        <h1>Liste des Projets</h1>
                        <div class="header-actions">
                            <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/views/projet.jsp'">
                                <span class="icon"><i class="fas fa-plus"></i></span> Ajouter un Projet
                            </button>
                            <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/projet/liste'">
                                <span class="icon"><i class="fas fa-sync"></i></span> Rafraîchir la liste
                            </button>
                        </div>
                    </div>
                    <div class="header-divider"></div>
                </div>

                <!-- Message d'erreur (si présent) -->
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">
                        ${errorMessage}
                    </div>
                </c:if>

                <!-- Filtres et recherche -->
                <div class="filters-container">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Rechercher un projet...">
                    </div>
                    <div class="filter-options">
                        <div class="filter-group">
                            <label for="statusFilter">Status:</label>
                            <select id="statusFilter" class="filter-select">
                                <option value="tous">Tous</option>
                                
                                <option value="enCours" >En cours</option>
                                <option value="terminee">Terminée</option>
                                <option value="enAttente">En attente</option>
                                <option value="cloturee" >Clôturée</option>
                               
                                    
                               
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="responsableFilter">Responsable:</label>
                            <select id="responsableFilter" class="filter-select">
                                <option value="all">Tous</option>
                                <c:forEach var="utilisateur" items="${utilisateurs}">
                                    <option value="${utilisateur.id}">${utilisateur.nom} ${utilisateur.prenom}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Table des projets -->
                <div class="table-container">
                    <table class="projects-table">
                        <thead>
                            <tr>
                                <th class="sortable" data-sort="nom">Nom projet <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="nomCourt">Nom court <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="responsable">Responsable <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="status">Status <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="progression">Progression <i class="fas fa-sort"></i></th>

                                <th class="sortable" data-sort="dateDebut">Date début <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="dateFin">Date fin <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="budget">Budget <i class="fas fa-sort"></i></th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="projectsTableBody">
                            <c:choose>
                                <c:when test="${empty projets}">
                                    <tr class="empty-table">
                                        <td colspan="8">
                                            <div class="empty-state">
                                                <i class="fas fa-folder-open"></i>
                                                <p>Aucun projet trouvé</p>
                                                <button class="btn-secondary" onclick="location.href='${pageContext.request.contextPath}/views/projet.jsp'">
                                                    Ajouter un projet
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                              
<c:otherwise>
    <c:forEach var="projet" items="${projets}">
        <tr class="projet-row" data-id="${projet.id}" data-status="${projet.status}">
            <td class="projet-name">
                <a href="${pageContext.request.contextPath}/projet/details/${projet.id}">${projet.nom}</a>
            </td>
            <td>${projet.nomCourt}</td>
            <td class="projet-responsable">
    
               <c:forEach var="utilisateur" items="${utilisateurs}">
                                <c:if test="${utilisateur.id == projet.responsable}">
                                    ${utilisateur.nom} ${utilisateur.prenom}
                                </c:if>
                </c:forEach>
            </td>
            <td>
                <span class="status-badge ${projet.status}">
                    ${projet.status}
                </span>
            </td>
            <td>
    <div class="progress-container">
        <div class="progress-label">${projet.progression}%</div>
        <div class="progress-bar
            ${projet.progression < 50 ? 'low' : (projet.progression < 100 ? 'medium' : 'high')}"
            style="--progress-value: ${projet.progression}%; animation-delay: 0.1s;">
        </div>
    </div>
</td>



            <td><fmt:formatDate value="${projet.dateDebut}" pattern="dd/MM/yyyy" /></td>
            <td><fmt:formatDate value="${projet.dateFin}" pattern="dd/MM/yyyy" /></td>
            <td class="budget" type="currency" currencySymbol="DA">${projet.budget} </td>
            
            <td class="actions">
                <button class="action-btn view-btn" title="Voir" onclick="location.href='${pageContext.request.contextPath}/projet/details/${projet.id}'">
                    <i class="fas fa-eye"></i>
                </button>
                <button class="action-btn edit-btn" title="Modifier" onclick="location.href='${pageContext.request.contextPath}/projet/edit?id=${projet.id}'">
                    <i class="fas fa-edit"></i>
                </button>
                 <button class="action-btn delete-btn" title="Supprimer" onclick="confirmerSuppression(${projet.id})">
                    <i class="fas fa-trash"></i>
                </button>
            </td>
        </tr>
    </c:forEach>
</c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <div class="modal" id="deleteModal">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title">Confirmer la suppression</h4>
            <button class="close-modal" onclick="fermerModal()">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div class="modal-body">
            <p class="modal-text">Êtes-vous sûr de vouloir supprimer ce projet ? Cette action est irréversible.</p>
        </div>
        <div class="modal-footer">
            <form id="deleteForm" action="${pageContext.request.contextPath}/projet/delete" method="post">
                <input type="hidden" id="deleteProjetId" name="id">
                <button type="button" class="btn-secondary" onclick="fermerModal()">Annuler</button>
                <button type="submit" class="btn-danger">Supprimer</button>
            </form>
        </div>
    </div>
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
            
            // Initialiser le tri des colonnes
            initTableSorting();
            
            // Initialiser les filtres
            initFiltering();
            
            // Initialiser la recherche
            initSearch();
            
            // Initialiser la modale de suppression
            initDeleteModal();
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
         * Initialise le tri des colonnes du tableau
         */
        function initTableSorting() {
            const headers = document.querySelectorAll('.projects-table th.sortable');
            
            headers.forEach(function(header) {
                header.addEventListener('click', function() {
                    const column = this.getAttribute('data-sort');
                    const currentDirection = this.classList.contains('asc') ? 'asc' : (this.classList.contains('desc') ? 'desc' : '');
                    
                    // Réinitialiser les autres en-têtes
                    headers.forEach(h => {
                        if (h !== this) {
                            h.classList.remove('asc', 'desc');
                        }
                    });
                    
                    // Déterminer la direction
                    let newDirection;
                    if (currentDirection === '' || currentDirection === 'desc') {
                        newDirection = 'asc';
                        this.classList.remove('desc');
                        this.classList.add('asc');
                    } else {
                        newDirection = 'desc';
                        this.classList.remove('asc');
                        this.classList.add('desc');
                    }
                    
                    // Trier le tableau
                    sortTable(column, newDirection);
                });
            });
        }
        
        /**
         * Trie le tableau selon la colonne et la direction spécifiées
         */
        function sortTable(column, direction) {
            const tbody = document.getElementById('projectsTableBody');
            const rows = Array.from(tbody.querySelectorAll('tr.projet-row'));
            
            // Si pas de lignes à trier, on s'arrête
            if (rows.length === 0) return;
            
            const sortedRows = rows.sort((a, b) => {
                let aValue, bValue;
                
                // Déterminer les valeurs à comparer selon la colonne
                switch(column) {
                    case 'nom':
                        aValue = a.querySelector('.projet-name a').textContent.trim().toLowerCase();
                        bValue = b.querySelector('.projet-name a').textContent.trim().toLowerCase();
                        break;
                    case 'nomCourt':
                        aValue = a.cells[1].textContent.trim().toLowerCase();
                        bValue = b.cells[1].textContent.trim().toLowerCase();
                        break;
                    case 'responsable':
                        aValue = a.cells[2].textContent.trim().toLowerCase();
                        bValue = b.cells[2].textContent.trim().toLowerCase();
                        break;
                    case 'status':
                        aValue = a.cells[3].textContent.trim().toLowerCase();
                        bValue = b.cells[3].textContent.trim().toLowerCase();
                        break;
                    case 'dateDebut':
                        // Convertir la date au format JJ/MM/AAAA en objet Date
                        aValue = parseDate(a.cells[4].textContent.trim());
                        bValue = parseDate(b.cells[4].textContent.trim());
                        break;
                    case 'dateFin':
                        aValue = parseDate(a.cells[5].textContent.trim());
                        bValue = parseDate(b.cells[5].textContent.trim());
                        break;
                    case 'budget':
                        // Extraire la valeur numérique du budget
                        aValue = parseFloat(a.cells[6].textContent.trim().replace(/[^\d,-]/g, '').replace(',', '.')) || 0;
                        bValue = parseFloat(b.cells[6].textContent.trim().replace(/[^\d,-]/g, '').replace(',', '.')) || 0;
                        break;
                    default:
                        return 0;
                }
                
                // Comparer les valeurs
                if (direction === 'asc') {
                    return aValue < bValue ? -1 : (aValue > bValue ? 1 : 0);
                } else {
                    return aValue > bValue ? -1 : (aValue < bValue ? 1 : 0);
                }
            });
            
            // Réorganiser les lignes dans le tableau
            sortedRows.forEach(row => tbody.appendChild(row));
        }
        
        /**
         * Initialise les filtres de la table
         */
        function initFiltering() {
            const statusFilter = document.getElementById('statusFilter');
            const responsableFilter = document.getElementById('responsableFilter');
            
            if (statusFilter) {
                statusFilter.addEventListener('change', applyFilters);
            }
            
            if (responsableFilter) {
                responsableFilter.addEventListener('change', applyFilters);
            }
        }
        
        /**
         * Initialise la fonction de recherche
         */
        function initSearch() {
            const searchInput = document.getElementById('searchInput');
            
            if (searchInput) {
                searchInput.addEventListener('input', applyFilters);
            }
        }
        
        /**
         * Applique les filtres à la table
         */
        function applyFilters() {
            const statusFilter = document.getElementById('statusFilter').value;
            const responsableFilter = document.getElementById('responsableFilter').value;
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            
            const rows = document.querySelectorAll('#projectsTableBody tr.projet-row');
            let visibleCount = 0;
            
            rows.forEach(function(row) {
                let showRow = true;
                
                // Filtre par statut
                if (statusFilter !== 'all') {
                    const rowStatus = row.querySelector('.status-badge').textContent.trim();
                    if (rowStatus !== statusFilter) {
                        showRow = false;
                    }
                }
                
                // Filtre par responsable
                if (responsableFilter !== 'all') {
                    const rowResponsable = row.getAttribute('data-responsable');
                    if (rowResponsable !== responsableFilter) {
                        showRow = false;
                    }
                }
                
                // Recherche textuelle
                if (searchTerm !== '') {
                    const projectName = row.querySelector('.projet-name a').textContent.toLowerCase();
                    const projectCode = row.cells[1].textContent.toLowerCase();
                    const projectResponsable = row.cells[2].textContent.toLowerCase();
                    
                    if (!projectName.includes(searchTerm) && 
                        !projectCode.includes(searchTerm) && 
                        !projectResponsable.includes(searchTerm)) {
                        showRow = false;
                    }
                }
                
                // Afficher ou masquer la ligne
                row.style.display = showRow ? '' : 'none';
                if (showRow) visibleCount++;
            });
            
            // Afficher un message si aucun résultat
            const emptyRow = document.querySelector('.empty-table');
            if (visibleCount === 0 && !emptyRow) {
                const tbody = document.getElementById('projectsTableBody');
                const newEmptyRow = document.createElement('tr');
                newEmptyRow.className = 'empty-table dynamic';
                newEmptyRow.innerHTML = `
                    <td colspan="8">
                        <div class="empty-state">
                            <i class="fas fa-search"></i>
                            <p>Aucun projet ne correspond à votre recherche</p>
                            <button class="btn-secondary" onclick="resetFilters()">
                                Réinitialiser les filtres
                            </button>
                        </div>
                    </td>
                `;
                tbody.appendChild(newEmptyRow);
            } else if (visibleCount > 0) {
                const dynamicEmptyRow = document.querySelector('.empty-table.dynamic');
                if (dynamicEmptyRow) {
                    dynamicEmptyRow.remove();
                }
            }
        }
        
        /**
         * Réinitialise les filtres
         */
        function resetFilters() {
            document.getElementById('statusFilter').value = 'all';
            document.getElementById('responsableFilter').value = 'all';
            document.getElementById('searchInput').value = '';
            applyFilters();
        }
        
        
        
        
        /**
         * Convertit une date au format JJ/MM/AAAA en objet Date
         */
        function parseDate(dateStr) {
            if (!dateStr || dateStr.trim() === '') return new Date(0); // Date minimale pour les valeurs vides
            
            const parts = dateStr.split('/');
            if (parts.length === 3) {
                // Format JJ/MM/AAAA -> AAAA-MM-JJ pour la création de l'objet Date
                return new Date(parts[2], parts[1] - 1, parts[0]);
            }
            return new Date(0); // Date par défaut si format invalide
        }
      // Ouvrir le modal de confirmation de suppression
        function confirmerSuppression(id) {
            document.getElementById('deleteProjetId').value = id;
            document.getElementById('deleteModal').classList.add('show');
        }

        // Fermer le modal
        function fermerModal() {
            document.getElementById('deleteModal').classList.remove('show');
        }
        // Ajouter cette fonction dans votre script
function supprimerProjet() {
    const id = document.getElementById('deleteProjetId').value;
    
    fetch('${pageContext.request.contextPath}/projet/liste', {
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
            // Supprimer la ligne du tableau ou rafraîchir la page
            const row = document.querySelector(`.projet-row[data-id="${id}"]`);
            if (row) row.remove();
            
            // Afficher un message de succès
            alert(data.message);
            
            // Rafraîchir la pagination si nécessaire
            resetPagination();
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
