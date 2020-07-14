package net.codejava.game.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import net.codejava.game.dao.PlayerDAO;
import net.codejava.game.model.Player;

@Controller
public class MainController {
	
	@Autowired
	private PlayerDAO playerDAO;
	
	@RequestMapping(value = "/")
	public ModelAndView loginPlayer(ModelAndView model) {
		model.setViewName("login_form");
		return model;
	}
	@RequestMapping(value = "/index")
	public ModelAndView listPlayer(ModelAndView model) {
		List<Player> listPlayer = playerDAO.list();
		model.addObject("listPlayer", listPlayer);
		model.setViewName("index");
		return model;
	}
	@RequestMapping(value = "/login1",method = RequestMethod.POST)
	public void updateScore(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		String username = request.getParameter("username");
		String high = request.getParameter("high");
		int score = Integer.parseInt(high);
		Player pl = playerDAO.getByName(username);
		pl.setScore(score);
		playerDAO.update(pl);

	}
	
	/*@RequestMapping(value = "/",method=RequestMethod.GET)
	public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("login_form");
		Player newPlayer = new Player();
		model.addObject("newPlayer", newPlayer);
		return model;
	}*/
	
	@RequestMapping(value = "/player_form", method = RequestMethod.GET)
	public ModelAndView newPlayer(ModelAndView model) {
		Player newPlayer = new Player();
		model.addObject("player", newPlayer);
		model.setViewName("player_form");
		return model;
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public ModelAndView savePlayer(@ModelAttribute Player player) {
		if(player.getId() == 0) {
			playerDAO.save(player);
		}
		else {
			playerDAO.update(player);
		}
		return new ModelAndView("redirect:/index");
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView editPlayer(HttpServletRequest request) {
		Integer id = Integer.parseInt(request.getParameter("id"));
		Player pl = playerDAO.get(id);
		ModelAndView model = new ModelAndView("player_form");
		
		model.addObject("player", pl);		
		return model;
	}
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public ModelAndView deletePlayer(@RequestParam Integer id) {
		playerDAO.delete(id);
		return new ModelAndView("redirect:/index");
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView loginPlayer(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String loginStatus = "1";
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if(playerDAO.login(username, password)) {
			loginStatus = null;
			session.setAttribute("loginStatus", loginStatus);
			session.setAttribute("username", username);
			session.setAttribute("password", password);
			return new ModelAndView("snake");
		}
		session.setAttribute("loginStatus", loginStatus);
		return new ModelAndView("login_form");
	}
}
