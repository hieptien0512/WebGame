package net.codejava.game.dao;

import java.util.List;

import net.codejava.game.model.Player;

public interface PlayerDAO {
	public int save(Player player);

	public int update(Player player);

	public Player get(Integer id);

	public int delete(Integer id);

	public List<Player> list();
	
	public Boolean login(String name_,String pass_);

	Player getByName(String name_);

}
