package com.eadn.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/views/*"})
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        
        // Exemptez les pages de login et signup
        boolean isLoginPage = requestURI.contains("/login.jsp") || requestURI.contains("/login");
        boolean isSignupPage = requestURI.contains("/singup.jsp") || requestURI.contains("/signup");
        boolean isResourceRequest = requestURI.contains("/css/") || requestURI.contains("/js/");
        
        boolean isLoggedIn = (session != null && session.getAttribute("utilisateur") != null);
        
        if (isLoggedIn || isLoginPage || isSignupPage || isResourceRequest) {
            // Utilisateur connecté ou accédant à une page publique
            chain.doFilter(request, response);
        } else {
            // Utilisateur non connecté tentant d'accéder à une page protégée
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation si nécessaire
    }
    
    @Override
    public void destroy() {
        // Nettoyage si nécessaire
    }
}