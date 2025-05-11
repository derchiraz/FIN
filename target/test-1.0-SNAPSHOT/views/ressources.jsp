<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Ajouter une Ressource</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/projet.css">
    <!-- Icons pour la sidebar -->
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
                        <a href="#" class="nav-item has-submenu active" id="team-menu">
                            <i class="fas fa-users"></i>
                            <span>Ressource</span>
                            <i class="fas fa-chevron-right submenu-icon"></i>
                        </a>
                        <ul class="submenu show" id="team-submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/views/ressources.jsp" class="active">
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
                        <span>Ressource</span>/ 
                        <span>Ajouter une ressource</span>
                    </div>
                    <div class="header-top">
                        <h1>Ajouter une Ressource</h1>
                        <div class="header-actions">
                            <button class="btn-action" onclick="location.href='${pageContext.request.contextPath}/views/listeRessources.jsp'">
                                <span class="icon"><i class="fas fa-list"></i></span> Liste des Ressources
                            </button>
                        </div>
                    </div>
                    <div class="header-divider"></div>
                </div>

                <form action="${pageContext.request.contextPath}/ressource/save" method="post" onsubmit="return validateForm(event)">
                    <div class="form-container">
                        <div class="form-section">
                            <h4 class="section-title">Informations Personnelles</h4>
                            <div class="input-group">
                                <label for="code">Code de l'employé</label>
                                <input type="text" id="code" name="code" class="form-control" 
                                      placeholder="Entrez le code de l'employé" required>
                            </div>
                            <div class="input-group">
                                <label for="nom">Nom de l'employé</label>
                                <input type="text" id="nom" name="nom" class="form-control" 
                                      placeholder="Entrez le nom de l'employé" required>
                            </div>
                            <div class="input-group">
                                <label for="identite">Numéro d'identité</label>
                                <input type="text" id="identite" name="identite" class="form-control" 
                                      placeholder="Numéro d'identité" required>
                            </div>
                            <div class="input-group">
                                <label for="qualification">Qualification éducative</label>
                                <textarea id="qualification" name="qualification" class="form-control" 
                                         placeholder="Décrivez la qualification..." rows="3" required></textarea>
                            </div>
                            <div class="input-group">
                                <label for="nationalite">Nationalité</label>
                                <input type="text" id="nationalite" name="nationalite" class="form-control" 
                                      placeholder="Nationalité" required>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h4 class="section-title">Informations Professionnelles</h4>
                            <div class="input-group radio-group">
                                <label>Genre</label>
                                <div class="radio-options">
                                    <label class="radio-label">
                                        <input type="radio" name="genre" value="masculin" required> Masculin
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="genre" value="feminin"> Féminin
                                    </label>
                                </div>
                            </div>
                            <div class="input-group">
                                <label for="dateNaissance">Date de naissance</label>
                                <input type="date" id="dateNaissance" name="dateNaissance" class="form-control" required>
                            </div>
                            <div class="input-group">
                                <label for="poste">Titre du poste</label>
                                <input type="text" id="poste" name="poste" class="form-control" 
                                      placeholder="Titre du poste" required>
                            </div>
                            <div class="input-group">
                                <label for="telephone">Téléphone</label>
                                <input type="text" id="telephone" name="telephone" class="form-control" 
                                      placeholder="Numéro de téléphone" required>
                            </div>
                            <div class="input-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" class="form-control" 
                                      placeholder="Adresse email" required>
                                <div id="emailError" class="error-message">
                                    <i class="fas fa-exclamation-triangle"></i> Veuillez entrer une adresse email valide.
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-container">
                        <div class="form-section">
                            <h4 class="section-title">Contrat et Rémunération</h4>
                            <div class="input-group">
                                <label for="salaire">Salaire</label>
                                <input type="number" id="salaire" name="salaire" class="form-control" 
                                      placeholder="Montant du salaire" required>
                            </div>
                            <div class="input-group">
                                <label for="branche">Branche</label>
                                <input type="text" id="branche" name="branche" class="form-control" 
                                      placeholder="Branche" required>
                            </div>
                            <div class="input-group">
                                <label for="adresse">Adresse</label>
                                <input type="text" id="adresse" name="adresse" class="form-control" 
                                      placeholder="Adresse complète" required>
                            </div>
                            <div class="input-group radio-group">
                                <label>Type de contrat</label>
                                <div class="contract-options">
                                    <label class="radio-label">
                                        <input type="radio" name="contrat" value="CDI" required> Contrat à Durée Indéterminée
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="contrat" value="CDD"> Contrat à Durée Déterminée
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="contrat" value="Insertion"> Contrat d'Insertion Professionnelle
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="contrat" value="Stage"> Contrat de Stage ou Formation
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="contrat" value="TempsPartiel"> Contrat à Temps Partiel
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h4 class="section-title">Période d'emploi</h4>
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
                            <div class="duration-display">
                                Durée du contrat: <span id="duree">0</span> jours
                            </div>
                            <div id="date-error-message" class="error-message">
                                <i class="fas fa-exclamation-triangle"></i> La date de fin doit être après la date de début.
                            </div>
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
                <div class="toast-message">La ressource a été ajoutée avec succès.</div>
            </div>
            <button class="toast-close">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Afficher le message de succès s'il existe
            <c:if test="${not empty successMessage}">
                document.getElementById('toast-success').classList.add('show');
                setTimeout(() => {
                    document.getElementById('toast-success').classList.remove('show');
                }, 5000);
            </c:if>
            
            // Sidebar toggle
            const sidebarToggle = document.createElement('button');
            sidebarToggle.classList.add('sidebar-toggle');
            sidebarToggle.innerHTML = '<i class="fas fa-bars"></i>';
            document.querySelector('.main-header').prepend(sidebarToggle);
            
            sidebarToggle.addEventListener('click', function() {
                document.body.classList.toggle('sidebar-open');
            });

            // Sidebar collapse
            const sidebarCollapse = document.getElementById('sidebar-collapse');
            sidebarCollapse.addEventListener('click', function() {
                document.body.classList.toggle('sidebar-collapsed');
                setTimeout(() => {
                    window.dispatchEvent(new Event('resize'));
                }, 300);
            });

            // User dropdown
            const avatarTrigger = document.getElementById('avatar-trigger');
            const userDropdown = document.getElementById('user-dropdown');
            
            avatarTrigger.addEventListener('click', function(e) {
                e.stopPropagation();
                userDropdown.classList.toggle('show');
            });
            
            document.addEventListener('click', function() {
                userDropdown.classList.remove('show');
            });
            
            // Toggle submenu
            const submenus = document.querySelectorAll('.has-submenu');
            submenus.forEach(menu => {
                menu.addEventListener('click', function(e) {
                    // Fermer tous les autres sous-menus
                    submenus.forEach(otherMenu => {
                        if (otherMenu !== menu) {
                            const subId = otherMenu.id.replace('-menu', '-submenu');
                            const subMenu = document.getElementById(subId);
                            subMenu.classList.remove('show');
                            otherMenu.classList.remove('expanded');
                        }
                    });
                    
                    const subId = this.id.replace('-menu', '-submenu');
                    const subMenu = document.getElementById(subId);
                    subMenu.classList.toggle('show');
                    this.classList.toggle('expanded');
                    e.preventDefault();
                });
            });

            // Animations sur survol
            const navItems = document.querySelectorAll('.nav-item');
            navItems.forEach(item => {
                item.addEventListener('mouseenter', function() {
                    if (!this.classList.contains('has-submenu')) {
                        this.querySelector('i:first-child').classList.add('fa-beat');
                    }
                });
                
                item.addEventListener('mouseleave', function() {
                    this.querySelector('i:first-child').classList.remove('fa-beat');
                });
            });

            // Toggle du thème clair/sombre
            const themeToggle = document.getElementById('theme-toggle');
            themeToggle.addEventListener('click', function() {
                document.body.classList.toggle('dark-theme');
                if (document.body.classList.contains('dark-theme')) {
                    themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
                    // Stocker la préférence
                    localStorage.setItem('theme', 'dark');
                } else {
                    themeToggle.innerHTML = '<i class="fas fa-moon"></i>';
                    localStorage.setItem('theme', 'light');
                }
            });
            
            // Appliquer le thème sauvegardé
            if (localStorage.getItem('theme') === 'dark') {
                document.body.classList.add('dark-theme');
                themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
            }

            // Calculer la durée du contrat
            document.getElementById('dateDebut').addEventListener('change', calculerDuree);
            document.getElementById('dateFin').addEventListener('change', calculerDuree);
            
            // Toast notification
            const toast = document.getElementById('toast-success');
            const toastClose = document.querySelector('.toast-close');
            
            toastClose.addEventListener('click', function() {
                toast.classList.remove('show');
            });
        });

        function calculerDuree() {
            let debut = new Date(document.getElementById("dateDebut").value);
            let fin = new Date(document.getElementById("dateFin").value);
            if (!isNaN(debut.getTime()) && !isNaN(fin.getTime()) && fin > debut) {
                let difference = Math.ceil((fin - debut) / (1000 * 60 * 60 * 24));
                document.getElementById("duree").innerText = difference;
                document.getElementById("date-error-message").style.display = "none";
            } else if (fin <= debut && !isNaN(debut.getTime()) && !isNaN(fin.getTime())) {
                document.getElementById("duree").innerText = "0";
                document.getElementById("date-error-message").style.display = "block";
            }
        }

        function validateEmail() {
            const email = document.getElementById('email').value;
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const emailError = document.getElementById('emailError');
            
            if (!emailPattern.test(email)) {
                emailError.style.display = "block";
                return false;
            } else {
                emailError.style.display = "none";
                return true;
            }
        }

        function validateForm(event) {
            event.preventDefault();
            const startDate = document.getElementById("dateDebut").value;
            const endDate = document.getElementById("dateFin").value;
            const dateErrorMessage = document.getElementById("date-error-message");
            const inputs = document.querySelectorAll("input[required], select[required], textarea[required]");
            let allFilled = true;
            let datesValid = true;
            let emailValid = validateEmail();

            inputs.forEach((input) => {
                if (input.value.trim() === "") {
                    allFilled = false;
                    input.classList.add('error');
                    // Ajouter animation de secouement
                    input.classList.add('shake');
                    setTimeout(() => input.classList.remove('shake'), 500);
                } else {
                    input.classList.remove('error');
                }
            });

            if (!allFilled) {
                return false;
            }

            if (endDate && startDate) {
                const start = new Date(startDate);
                const end = new Date(endDate);
                if (start > end) {
                    dateErrorMessage.style.display = "block";
                    dateErrorMessage.classList.add('shake');
                    setTimeout(() => dateErrorMessage.classList.remove('shake'), 500);
                    datesValid = false;
                } else {
                    dateErrorMessage.style.display = "none";
                }
            }

            if (allFilled && datesValid && emailValid) {
                // Soumettre le formulaire
                document.querySelector('form').submit();
                return true;
            }
            
            return false;
        }
    </script>
</body>
</html>