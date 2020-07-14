package net.codejava.game.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import net.codejava.game.model.Player;

class PlayerDAOTest {
	private DriverManagerDataSource dataSource;
	private PlayerDAO dao;

	@BeforeEach
	void setupBeforEach() {
		dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName("com.mysql.jdbc.Driver");
		dataSource.setUrl("jdbc:mysql://localhost:3306/gamedb");
		dataSource.setUsername("root");
		dataSource.setPassword("1234");

		dao = new PlayerDAOImpl(dataSource);
	}

	@Test
	void testSave() {
		Player player = new Player("Lim Hiep Tien", "nam", 0, "123");
		int result = dao.save(player);

		assertTrue(result > 0);
	}

	@Test
	void testUpdate() {
		Player player = new Player(2, "dao huu hoang quan", "nam", 3,"123");
		int result = dao.update(player);
		assertTrue(result > 0);

	}

	@Test
	void testGet() {
		Integer id = 3;
		Player player = dao.get(id);

		if (player != null)
			System.out.println(player);

		assertNotNull(player);
	}
	
	@Test
	void testGetByName() {
		String name = "Lim Hiep Tien";
		Player player = dao.getByName(name);

		if (player != null)
			System.out.println(player);

		assertNotNull(player);
	}
	
	@Test
	void testLogin() {
		String name_ = "Lim Hiep Tien";
		String pass_ = "1234";


		if (dao.login(name_,pass_))
			System.out.println("true");
		else System.out.println("false");

		//assertTrue(result > 0);
	}

	@Test
	void testDelete() {
		Integer id = 6;
		int result = dao.delete(id);
		assertTrue(result > 0);

	}

	@Test
	void testList() {
		List<Player> listPlayer = dao.list();

		for (Player aPlayer : listPlayer) {
			System.out.println(aPlayer);
		}

		assertTrue(!listPlayer.isEmpty());

	}

}
