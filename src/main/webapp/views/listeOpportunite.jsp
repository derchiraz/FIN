<%-- 
    Document   : listeOP
    Created on : 10 avr. 2025, 01:30:58
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
    <title>Liste des Opportunités</title>
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
                        <a href="#" class="nav-item has-submenu " id="project-menu">
                            <i class="fas fa-project-diagram"></i>
                            <span>Projets</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu " id="project-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/projet.jsp">
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
                                <a href="${pageContext.request.contextPath}/views/listeRessources">
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
                         <span>Opportunités</span> / 
                        <span>Liste des opportunités</span>
                    </div>
                    <div class="header-top">
                        <h1>Liste des Opportunités</h1>
                        
                        <div class="header-actions">
                            <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/load-form-data?page=opportunite'">
                              <span class="icon"><i class="fas fa-plus"></i></span> Ajouter une Opportunité
                            </button>
                              <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/opportunite/liste'">
        <span class="icon"><i class="fas fa-sync"></i></span> Rafraîchir la liste
    </button>
                            
                        </div>
                    </div>
                    <div class="header-divider"></div>
                </div>

                <!-- Filtres et recherche -->
                <div class="filters-container">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Rechercher une opportunité...">
                    </div>
                    <div class="filter-options">
                        <div class="filter-group">
                            <label for="status">Status:</label>
                            <select id="statusFilter" class="filter-select">
                                <option value="tous">Tous</option>
                                
                                    <option value="enCours" >En cours</option>
                                    <option value="terminée">Terminée</option>
                                    <option value="enAttente">En attente</option>
                                    <option value="clôturée" >Clôturée</option>
                            </select>
                        </div>
                       
                    </div>
                </div>

                <!-- Table des opportunités -->
                <div class="table-container">
                    <table class="projects-table">
                        <thead>
                            <tr>
                                <th class="sortable" data-sort="nom">Nom opportunité <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="client">Client <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="entreprise">Entreprise <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="status">Status <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="dateCreation">Date début  <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="dateCloture">Date fin <i class="fas fa-sort"></i></th>
                                <th class="sortable" data-sort="montant">Budget <i class="fas fa-sort"></i></th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="opportunitesTableBody">
                            <c:choose>
                                <c:when test="${empty opportunites}">
                                    <tr class="empty-table">
                                        <td colspan="8">
                                            <div class="empty-state">
                                                <i class="fas fa-lightbulb"></i>
                                                <p>Aucune opportunité trouvée</p>
                                                <button class="btn-secondary" onclick="location.href='${pageContext.request.contextPath}/load-form-data?page=opportunite'">
                                                    Ajouter une opportunité
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="opportunite" items="${opportunites}">
    <tr class="opportunite-row" data-id="${opportunite.id}" data-status="${opportunite.status}">
        <td class="opportunite-name">
            <a href="${pageContext.request.contextPath}/opportunite/details?id=${opportunite.id}">${opportunite.nom_opportunite}</a>
        </td>
        <td>${opportunite.nom_contact}</td>
        <td>${opportunite.nom_entreprise}</td>
        <td>
            <span class="status-badge ${opportunite.status}">
                ${opportunite.status}
            </span>
        </td>
        <td><fmt:formatDate value="${opportunite.dateDebut}" pattern="dd/MM/yyyy" /></td>
        <td><fmt:formatDate value="${opportunite.dateFin}" pattern="dd/MM/yyyy" /></td>
        <td class="budget" type="currency" currencySymbol="DA">${opportunite.budget_estime} </td>
        <td class="actions">
    <button class="action-btn view-btn" title="Voir" onclick="location.href='${pageContext.request.contextPath}/opportunite/details?id=${opportunite.id}'">
        <i class="fas fa-eye"></i>
    </button>
    <button class="action-btn edit-btn" title="Modifier" onclick="location.href='${pageContext.request.contextPath}/opportunite/edit?id=${opportunite.id}'">
        <i class="fas fa-edit"></i>
    </button>
    <button class="action-btn delete-btn" title="Supprimer" onclick="confirmerSuppression(${opportunite.id})">
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

               <!-- Pagination -->
                <div class="pagination-container" id="pagination">
                    <button class="pagination-arrow" id="prevPage" disabled>
                        <i class="fas fa-chevron-left"></i>
                    </button>
                    <div class="pagination-numbers" id="paginationNumbers">
                       
                    </div>
                    <button class="pagination-arrow" id="nextPage">
                        <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
        </main>
    </div>

   <!-- Modal de confirmation de suppression pour les opportunités -->
<div class="modal" id="deleteModal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>Confirmer la suppression</h4>
            <button class="close-modal" onclick="fermerModal()">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div class="modal-body">
            <p>Êtes-vous sûr de vouloir supprimer cette opportunité ? Cette action est irréversible.</p>
        </div>
        <div class="modal-footer">
            <form id="deleteForm" action="${pageContext.request.contextPath}/opportunite/delete" method="post">
                <input type="hidden" id="deleteOpportuniteId" name="id">
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
                <div class="toast-message">${successMessage}</div>
            </div>
            <button class="toast-close">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <script>
       // Variables globales pour la pagination
let currentPage = 1;
const rowsPerPage = 10;

document.addEventListener('DOMContentLoaded', function() {
    // Afficher le message de succès s'il existe
    if (document.getElementById('toast-success')) {
        document.getElementById('toast-success').classList.add('show');
        setTimeout(() => {
            document.getElementById('toast-success').classList.remove('show');
        }, 5000);
    }
    
    // Sidebar toggle
    const sidebarToggle = document.createElement('button');
    sidebarToggle.classList.add('sidebar-toggle');
    sidebarToggle.innerHTML = '<i class="fas fa-bars"></i>';
    document.querySelector('.main-header')?.prepend(sidebarToggle);
    
    sidebarToggle.addEventListener('click', function() {
        document.body.classList.toggle('sidebar-open');
    });

    // Sidebar collapse
    const sidebarCollapse = document.getElementById('sidebar-collapse');
    if (sidebarCollapse) {
        sidebarCollapse.addEventListener('click', function() {
            document.body.classList.toggle('sidebar-collapsed');
            setTimeout(() => {
                window.dispatchEvent(new Event('resize'));
            }, 300);
        });
    }

    // User dropdown toggle
    const avatarTrigger = document.getElementById('avatar-trigger');
    const userDropdown = document.getElementById('user-dropdown');
    
    if (avatarTrigger && userDropdown) {
        avatarTrigger.addEventListener('click', function(e) {
            e.stopPropagation();
            userDropdown.classList.toggle('show');
        });
        
        document.addEventListener('click', function(e) {
            if (!e.target.closest('#user-dropdown') && !e.target.closest('#avatar-trigger')) {
                userDropdown.classList.remove('show');
            }
        });
    }
    
    // Toggle submenu
    const submenus = document.querySelectorAll('.has-submenu');
    submenus.forEach(menu => {
        menu.addEventListener('click', function(e) {
            const subId = this.id.replace('-menu', '-submenu');
            const subMenu = document.getElementById(subId);
            if (subMenu) {
                subMenu.classList.toggle('show');
                this.classList.toggle('expanded');
                e.preventDefault();
            }
        });
    });

    // Configurations du tableau
    setupTableFiltering();
    setupTableSorting();
    setupPagination();
    
    // Theme toggle
    const themeToggle = document.getElementById('theme-toggle');
    if (themeToggle) {
        themeToggle.addEventListener('click', function() {
            document.body.classList.toggle('dark-theme');
            localStorage.setItem('theme', document.body.classList.contains('dark-theme') ? 'dark' : 'light');
            if (document.body.classList.contains('dark-theme')) {
                this.innerHTML = '<i class="fas fa-sun"></i>';
            } else {
                this.innerHTML = '<i class="fas fa-moon"></i>';
            }
        });
        
        // Apply saved theme
        if (localStorage.getItem('theme') === 'dark') {
            document.body.classList.add('dark-theme');
            themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
        }
    }
});

// Configuration du filtrage
function setupTableFiltering() {
    const searchInput = document.getElementById('searchInput');
    const statusFilter = document.getElementById('statusFilter');
    const responsableFilter = document.getElementById('responsableFilter');
    
    if (!searchInput || !statusFilter) return;
    
    function applyFilters() {
        const searchTerm = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;
        const responsableValue = responsableFilter ? responsableFilter.value : 'all';
        
        const rows = document.querySelectorAll('#opportunitesTableBody tr.opportunite-row');
        
        rows.forEach(row => {
            if (row.classList.contains('empty-table')) return;
            
            const opportuniteName = row.querySelector('.opportunite-name')?.textContent.toLowerCase() || '';
            const opportuniteStatus = row.getAttribute('data-status');
            const opportuniteResponsable = row.getAttribute('data-client');
            
            const matchesSearch = opportuniteName.includes(searchTerm);
            const matchesStatus = statusValue === 'all' || statusValue === 'tous' || opportuniteStatus === statusValue;
            const matchesResponsable = responsableValue === 'all' || responsableValue === 'tous' || opportuniteResponsable === responsableValue;
            
            row.style.display = (matchesSearch && matchesStatus && matchesResponsable) ? '' : 'none';
        });
        
        resetPagination();
    }
    
    searchInput.addEventListener('input', applyFilters);
    statusFilter.addEventListener('change', applyFilters);
    if (responsableFilter) {
        responsableFilter.addEventListener('change', applyFilters);
    }
}

// Configuration du tri
function setupTableSorting() {
    const headers = document.querySelectorAll('.sortable');
    
    headers.forEach(header => {
        header.addEventListener('click', function() {
            const column = this.getAttribute('data-sort');
            const icon = this.querySelector('i');
            
            document.querySelectorAll('.sortable i').forEach(i => {
                i.className = 'fas fa-sort';
            });
            
            let direction = 'asc';
            if (icon.classList.contains('fa-sort-up')) {
                direction = 'desc';
                icon.className = 'fas fa-sort-down';
            } else if (icon.classList.contains('fa-sort-down')) {
                direction = 'none';
                icon.className = 'fas fa-sort';
            } else {
                icon.className = 'fas fa-sort-up';
            }
            
            if (direction !== 'none') {
                sortTable(column, direction);
            }
        });
    });
}

function sortTable(column, direction) {
    const tbody = document.getElementById('opportunitesTableBody');
    if (!tbody) return;
    
    const rows = Array.from(tbody.querySelectorAll('tr.opportunite-row'));
    
    if (rows.length === 0 || rows[0].classList.contains('empty-table')) return;
    
    const sortedRows = rows.sort((a, b) => {
        let aValue, bValue;
        
        if (column === 'nom') {
            aValue = a.querySelector('.opportunite-name')?.textContent.trim().toLowerCase() || '';
            bValue = b.querySelector('.opportunite-name')?.textContent.trim().toLowerCase() || '';
        } else if (column === 'entreprise' || column === 'commercial') {
            const columnIndex = column === 'entreprise' ? 2 : 3;
            aValue = a.querySelectorAll('td')[columnIndex]?.textContent.trim().toLowerCase() || '';
            bValue = b.querySelectorAll('td')[columnIndex]?.textContent.trim().toLowerCase() || '';
        } else if (column === 'client') {
            aValue = a.querySelectorAll('td')[1]?.textContent.trim().toLowerCase() || '';
            bValue = b.querySelectorAll('td')[1]?.textContent.trim().toLowerCase() || '';
        } else if (column === 'status') {
            aValue = a.querySelectorAll('td')[3]?.textContent.trim().toLowerCase() || '';
            bValue = b.querySelectorAll('td')[3]?.textContent.trim().toLowerCase() || '';
        } else if (column === 'dateCreation' || column === 'dateCloture') {
            const dateColumnIndex = column === 'dateCreation' ? 4 : 5;
            const aDate = a.querySelectorAll('td')[dateColumnIndex]?.textContent.trim() || '';
            const bDate = b.querySelectorAll('td')[dateColumnIndex]?.textContent.trim() || '';
            
            if (!aDate || aDate === '-') return direction === 'asc' ? 1 : -1;
            if (!bDate || bDate === '-') return direction === 'asc' ? -1 : 1;
            
            const [aDay, aMonth, aYear] = aDate.split('/');
            const [bDay, bMonth, bYear] = bDate.split('/');
            
            aValue = new Date(aYear, aMonth - 1, aDay);
            bValue = new Date(bYear, bMonth - 1, bDay);
        } else if (column === 'montant') {
            aValue = parseFloat(a.querySelector('.budget')?.textContent.replace(/[^\d.-]/g, '')) || 0;
            bValue = parseFloat(b.querySelector('.budget')?.textContent.replace(/[^\d.-]/g, '')) || 0;
        } else {
            return 0;
        }
        
        if (direction === 'asc') {
            return aValue > bValue ? 1 : -1;
        } else {
            return aValue < bValue ? 1 : -1;
        }
    });
    
    while (tbody.firstChild) {
        tbody.removeChild(tbody.firstChild);
    }
    
    sortedRows.forEach(row => {
        tbody.appendChild(row);
    });
    
    setupPagination();
}

// Configuration de la pagination améliorée
function setupPagination() {
    const rows = Array.from(document.querySelectorAll('#opportunitesTableBody tr.opportunite-row')).filter(row => 
        window.getComputedStyle(row).display !== 'none' && !row.classList.contains('empty-table')
    );
    
    const totalPages = Math.ceil(rows.length / rowsPerPage);
    const paginationNumbers = document.getElementById('paginationNumbers');
    const prevButton = document.getElementById('prevPage');
    const nextButton = document.getElementById('nextPage');
    
    if (!paginationNumbers || !prevButton || !nextButton) return;
    
    // Réinitialiser pagination
    paginationNumbers.innerHTML = '';
    
    // Créer les boutons de pagination
    if (totalPages <= 7) {
        // Afficher tous les numéros de page si il y a 7 pages ou moins
        for (let i = 1; i <= totalPages; i++) {
            addPageButton(i);
        }
    } else {
        // Pagination avec ellipsis pour les grands nombres de pages
        if (currentPage <= 4) {
            // Premières pages
            for (let i = 1; i <= 5; i++) {
                addPageButton(i);
            }
            addEllipsis();
            addPageButton(totalPages);
        } else if (currentPage >= totalPages - 3) {
            // Dernières pages
            addPageButton(1);
            addEllipsis();
            for (let i = totalPages - 4; i <= totalPages; i++) {
                addPageButton(i);
            }
        } else {
            // Pages du milieu
            addPageButton(1);
            addEllipsis();
            for (let i = currentPage - 1; i <= currentPage + 1; i++) {
                addPageButton(i);
            }
            addEllipsis();
            addPageButton(totalPages);
        }
    }
    
    // État des boutons précédent/suivant
    prevButton.disabled = currentPage === 1;
    nextButton.disabled = currentPage === totalPages || totalPages === 0;
    
    // Assigner les fonctions de navigation
    prevButton.onclick = function() {
        if (currentPage > 1) {
            goToPage(currentPage - 1);
        }
    };
    
    nextButton.onclick = function() {
        if (currentPage < totalPages) {
            goToPage(currentPage + 1);
        }
    };
    
    // Afficher ou masquer le conteneur de pagination
    const paginationContainer = document.getElementById('pagination');
    if (paginationContainer) {
        paginationContainer.style.display = totalPages <= 1 ? 'none' : 'flex';
    }
    
    // Afficher la page courante
    showCurrentPage();
}

// Ajouter un bouton numéroté à la pagination
function addPageButton(pageNum) {
    const paginationNumbers = document.getElementById('paginationNumbers');
    if (!paginationNumbers) return;
    
    const pageButton = document.createElement('button');
    pageButton.className = 'pagination-number' + (pageNum === currentPage ? ' active' : '');
    pageButton.textContent = pageNum;
    pageButton.onclick = function() {
        goToPage(pageNum);
    };
    paginationNumbers.appendChild(pageButton);
}

// Ajouter des ellipsis (points de suspension)
function addEllipsis() {
    const paginationNumbers = document.getElementById('paginationNumbers');
    if (!paginationNumbers) return;
    
    const ellipsis = document.createElement('span');
    ellipsis.className = 'pagination-ellipsis';
    ellipsis.textContent = '...';
    paginationNumbers.appendChild(ellipsis);
}

// Aller à une page spécifique
function goToPage(pageNum) {
    currentPage = pageNum;
    showCurrentPage();
    setupPagination(); // Mettre à jour les contrôles de pagination
}

// Afficher la page courante
function showCurrentPage() {
    const rows = Array.from(document.querySelectorAll('#opportunitesTableBody tr.opportunite-row')).filter(row => 
        window.getComputedStyle(row).display !== 'none' && !row.classList.contains('empty-table')
    );
    
    const startIndex = (currentPage - 1) * rowsPerPage;
    const endIndex = Math.min(startIndex + rowsPerPage, rows.length);
    
    // Masquer toutes les lignes
    rows.forEach(row => {
        row.style.display = 'none';
    });
    
    // Afficher uniquement les lignes de la page courante
    for (let i = startIndex; i < endIndex; i++) {
        if (rows[i]) {
            rows[i].style.display = '';
        }
    }
}

// Réinitialiser la pagination (après filtrage, tri, etc.)
function resetPagination() {
    currentPage = 1;
    setupPagination();
}

// Ouvrir le modal de confirmation de suppression
function confirmerSuppression(id) {
    const deleteOpportuniteId = document.getElementById('deleteOpportuniteId');
    const deleteModal = document.getElementById('deleteModal');
    
    if (deleteOpportuniteId && deleteModal) {
        deleteOpportuniteId.value = id;
        deleteModal.classList.add('show');
    }
}

// Fermer le modal
function fermerModal() {
    const deleteModal = document.getElementById('deleteModal');
    if (deleteModal) {
        deleteModal.classList.remove('show');
    }
}

// Supprimer une opportunité
function supprimerOpportunite() {
    const deleteOpportuniteId = document.getElementById('deleteOpportuniteId');
    if (!deleteOpportuniteId) return;
    
    const id = deleteOpportuniteId.value;
    
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
            // Supprimer la ligne du tableau ou rafraîchir la page
            const row = document.querySelector(`.opportunite-row[data-id="${id}"]`);
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
