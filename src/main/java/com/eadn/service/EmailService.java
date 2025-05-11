package com.eadn.service;

import jakarta.ejb.Stateless;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

@Stateless
public class EmailService {
    
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_FROM = "userful29@gmail.com"; // Changez ceci
    private static final String PASSWORD = "sidr jfar bpli chex"; // Changez ceci
    
    public void sendPasswordResetEmail(String to, String resetUrl) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_FROM, PASSWORD);
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Réinitialisation de votre mot de passe EADN Timex");
            
            String htmlContent = 
                    "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>" +
                    "<h2>Réinitialisation de votre mot de passe</h2>" +
                    "<p>Bonjour,</p>" +
                    "<p>Nous avons reçu une demande de réinitialisation de mot de passe pour votre compte EADN Timex. " +
                    "Si vous n'avez pas fait cette demande, vous pouvez ignorer cet email.</p>" +
                    "<p>Pour réinitialiser votre mot de passe, cliquez sur le lien ci-dessous :</p>" +
                    "<p><a href='" + resetUrl + "' style='display: inline-block; padding: 10px 20px; " +
                    "background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px;'>" +
                    "Réinitialiser mon mot de passe</a></p>" +
                    "<p>Si le bouton ne fonctionne pas, copiez et collez l'URL suivante dans votre navigateur :</p>" +
                    "<p>" + resetUrl + "</p>" +
                    "<p>Ce lien expirera dans 24 heures.</p>" +
                    "<p>Cordialement,<br>L'équipe EADN Timex</p>" +
                    "</div>";
            
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            
            System.out.println("Email de réinitialisation envoyé à " + to);
            
        } catch (MessagingException e) {
            System.err.println("Erreur lors de l'envoi de l'email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}