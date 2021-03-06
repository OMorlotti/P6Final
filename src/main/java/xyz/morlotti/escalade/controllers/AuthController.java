package xyz.morlotti.escalade.controllers;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import xyz.morlotti.escalade.EmailSingleton;
import xyz.morlotti.escalade.models.beans.User;
import xyz.morlotti.escalade.models.daos.UserDAO;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpSession;

@Controller
public class AuthController
{
    @Autowired
    private UserDAO userDAO;

    /*----------------------------------------------------------------------------------------------------------------*/

    @RequestMapping(path = "/login", method = RequestMethod.GET)
    public String loginStep1(Model model) throws Exception
    {
        model.addAttribute("title", "Authentification");

        return "login";
    }

    @RequestMapping(path = "/login", method = RequestMethod.POST)
    public String loginStep2(
        @RequestParam("login") String login,
        @RequestParam("password") String password,
        HttpSession httpSession, Model model) throws Exception
    {
        try
        {
            User user = userDAO.get(login, password);

            httpSession.setAttribute ("currentUser", user);

            return "index";
        }
        catch(NoResultException e)
        {
            model.addAttribute("message_type", "danger");
            model.addAttribute("message", "Login ou mot de passe incorrect");

            return "login";
        }
    }

    @RequestMapping(path = "/remind-password", method = RequestMethod.GET)
    public String remindPasswordStep1(Model model) throws Exception
    {
        model.addAttribute("title", "Authentification");

        return "remindPasswordStep1";
    }

    @RequestMapping(path = "/remind-password", method = RequestMethod.POST)
    public String remindPasswordStep2(
        @RequestParam("email") String email,
        HttpSession httpSession, Model model) throws Exception
    {
        try
        {
            User user = userDAO.get(email);

            EmailSingleton.sendMessage(
                user.getEmail(),
                user.getEmail(),
                "",
                "Mot de passe Les amis de l'escalade",
                "Bonjour,\nVotre mot de passe est " + user.getPassword() + ".\n" +
                      "Cordialement,\n" + "Les Amis de l'escalade"
            );

            httpSession.setAttribute ("email", email);

            return "remindPasswordStep2";
        }
        catch(NoResultException e)
        {
            model.addAttribute("message_type", "danger");
            model.addAttribute("message", "Email incorrect");

            return "remindPasswordStep1";
        }
    }

    @RequestMapping(path = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession httpSession, Model model) throws Exception
    {
        model.addAttribute("title", "Authentification");

        User user = (User) httpSession.getAttribute ("currentUser");

        user.initGuest();

        return "index";
    }
}
