package com.eadn.controller;

import com.eadn.entity.Utilisateur;
import com.eadn.entity.Compte;
import com.eadn.service.UtilisateurService;
import com.eadn.service.CompteService;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/projet/formulaire")
public class AfficherFormulaireProjetServlet extends HttpServlet {

    @Inject
    private UtilisateurService utilisateurService;

    @Inject
    private CompteService compteService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Obtenir les responsables
        List<Utilisateur> responsables = utilisateurService.findAll();
        req.setAttribute("responsables", responsables);

        // Obtenir les comptes clients
        List<Compte> comptes = compteService.findAll();
        req.setAttribute("comptes", comptes);

        // Rediriger vers la JSP
        req.getRequestDispatcher("/projet/formulaire").forward(req, resp);
    }
}
