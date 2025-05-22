/**
 * Script JavaScript pour la page d'ajout de projet
 * Contient toutes les fonctionnalités interactives de la page
 */

document.addEventListener('DOMContentLoaded', function() {
    // Afficher le message de succès s'il existe
    const toastSuccess = document.getElementById('toast-success');
    if (toastSuccess.classList.contains('show')) {
        setTimeout(() => {
            toastSuccess.classList.remove('show');
        }, 5000);
    }
    
    // Sidebar toggle - Création du bouton de toggle pour mobile
    const sidebarToggle = document.createElement('button');
    sidebarToggle.classList.add('sidebar-toggle');
    sidebarToggle.innerHTML = '<i class="fas fa-bars"></i>';
    document.querySelector('.main-header').prepend(sidebarToggle);
    
    sidebarToggle.addEventListener('click', function() {
        document.body.classList.toggle('sidebar-open');
    });

    // Sidebar collapse - Réduction de la sidebar
    const sidebarCollapse = document.getElementById('sidebar-collapse');
    sidebarCollapse.addEventListener('click', function() {
        document.body.classList.toggle('sidebar-collapsed');
        setTimeout(() => {
            window.dispatchEvent(new Event('resize'));
        }, 300);
    });

    // User dropdown - Menu utilisateur
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
    
    // Toggle submenu - Gestion des sous-menus de la sidebar
    const submenus = document.querySelectorAll('.has-submenu');
    submenus.forEach(menu => {
        menu.addEventListener('click', function(e) {
            // Fermer tous les autres sous-menus
            submenus.forEach(otherMenu => {
                if (otherMenu !== menu) {
                    const subId = otherMenu.id.replace('-menu', '-submenu');
                    const subMenu = document.getElementById(subId);
                    if (subMenu) {
                        subMenu.classList.remove('show');
                        otherMenu.classList.remove('expanded');
                    }
                }
            });
            
            const subId = this.id.replace('-menu', '-submenu');
            const subMenu = document.getElementById(subId);
            if (subMenu) {
                subMenu.classList.toggle('show');
                this.classList.toggle('expanded');
            }
            e.preventDefault();
        });
    });

    // Animations sur survol des éléments de menu
    const navItems = document.querySelectorAll('.nav-item');
    navItems.forEach(item => {
        item.addEventListener('mouseenter', function() {
            if (!this.classList.contains('has-submenu')) {
                const icon = this.querySelector('i:first-child');
                if (icon) {
                    icon.classList.add('fa-beat');
                }
            }
        });
        
        item.addEventListener('mouseleave', function() {
            const icon = this.querySelector('i:first-child');
            if (icon) {
                icon.classList.remove('fa-beat');
            }
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

    // Set min date to today for date fields
    const today = new Date().toISOString().split('T')[0];
    const dateDebutInput = document.getElementById('dateDebut');
    if (dateDebutInput) {
        dateDebutInput.min = today;
    }
    
    // Toast notification - Gestion de la fermeture
    const toast = document.getElementById('toast-success');
    const toastClose = document.querySelector('.toast-close');
    
    if (toastClose) {
        toastClose.addEventListener('click', function() {
            toast.classList.remove('show');
        });
    }
});

/**
 * Valide le formulaire avant soumission
 * @param {Event} event - L'événement de soumission
 * @returns {boolean} - True si le formulaire est valide, sinon False
 */
function validateForm(event) {
    const dateDebut = new Date(document.getElementById('dateDebut').value);
    const dateFin = new Date(document.getElementById('dateFin').value);
    const errorMessage = document.getElementById('error-message');
    const progression = parseInt(document.getElementById('progression').value);

    let valid = true;

    // Vérification des dates
    if (dateFin < dateDebut) {
        errorMessage.style.display = 'block';
        valid = false;
    } else {
        errorMessage.style.display = 'none';
    }

    // Vérification de la progression
    if (isNaN(progression) || progression < 0 || progression > 100) {
        alert("La progression doit être un nombre entre 0 et 100.");
        valid = false;
    }

    if (!valid) {
        event.preventDefault();
    }

    return valid;
}

/**
 * Ajoute un nouveau membre à l'équipe du projet
 */
function addMembre() {
    const wrapper = document.getElementById("membres-wrapper");
    const template = document.querySelector("#membre-template .membre-row");

    // Cloner le contenu du modèle
    const newMembre = template.cloneNode(true);
    wrapper.appendChild(newMembre);
}

/**
 * Supprime un membre de l'équipe du projet
 * @param {HTMLElement} button - Le bouton de suppression cliqué
 */
function removeMembre(button) {
    const row = button.closest('.membre-row');
    row.remove();
}

// Initialiser les membres du projet
    initMembresProjets();
   
/**
 * Initialise les membres du projet
 */
function initMembresProjets() {
    // Ajouter la première ligne de membre
    addMembre();
}
