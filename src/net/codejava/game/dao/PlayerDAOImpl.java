package net.codejava.game.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;
import javax.swing.tree.RowMapper;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;

import com.mysql.jdbc.PreparedStatement;

import net.codejava.game.model.Player;

public class PlayerDAOImpl implements PlayerDAO {

	private JdbcTemplate jdbcTemplate;

	public PlayerDAOImpl(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public int save(Player player) {
		String sql = "INSERT INTO player (player_name, player_gender, player_score, player_pass) VALUES (?,?,?,?)";
		return jdbcTemplate.update(sql, player.getName(), player.getGender(), player.getScore(), player.getPass());
	}

	@Override
	public int update(Player player) {
		String sql = "UPDATE player set player_name=?, player_gender=?, player_score=?, player_pass=? WHERE player_id = ?";

		return jdbcTemplate.update(sql, player.getName(), player.getGender(), player.getScore(), player.getPass(),
				player.getId());
	}

	@Override
	public Player get(Integer id) {
		String sql = "SELECT * FROM player WHERE player_id =" + id;

		ResultSetExtractor<Player> extractor = new ResultSetExtractor<Player>() {

			@Override
			public Player extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					String name = rs.getString("player_name");
					String gender = rs.getString("player_gender");
					int score = rs.getInt("player_score");
					String pass = rs.getString("player_pass");
					return new Player(id, name, gender, score, pass);
				}
				return null;
			}
		};

		return jdbcTemplate.query(sql, extractor);
	}
	
	@Override
	public Player getByName(String name_) {
		String sql = "SELECT * FROM player WHERE player_name =" + "'" + name_ + "'";

		ResultSetExtractor<Player> extractor = new ResultSetExtractor<Player>() {

			@Override
			public Player extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					int id = rs.getInt("player_id");
					String gender = rs.getString("player_gender");
					int score = rs.getInt("player_score");
					String pass = rs.getString("player_pass");
					return new Player(id, name_, gender, score, pass);
				}
				return null;
			}
		};

		return jdbcTemplate.query(sql, extractor);
	}

	@Override
	public int delete(Integer id) {
		String sql = "DELETE FROM player WHERE player_id =" + id;

		return jdbcTemplate.update(sql);
	}

	@Override
	public List<Player> list() {
		String sql = "SELECT * FROM player";
		org.springframework.jdbc.core.RowMapper<Player> rowMapper = new org.springframework.jdbc.core.RowMapper<Player>() {

			@Override
			public Player mapRow(ResultSet rs, int rowNum) throws SQLException {
				int id = rs.getInt("player_id");
				String name = rs.getString("player_name");
				String gender = rs.getString("player_gender");
				int score = rs.getInt("player_score");
				String pass = rs.getString("player_pass");
				return new Player(id, name, gender, score, pass);
			}

		};

		return jdbcTemplate.query(sql, rowMapper);
	}

	@Override
	public Boolean login(String name_, String pass_) {

		String sql = "SELECT * FROM player WHERE player_name =" + "'" + name_ + "'";

		ResultSetExtractor<Player> extractor = new ResultSetExtractor<Player>() {

			@Override
			public Player extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					int id = rs.getInt("player_id");
					// String name = rs.getString("player_name");
					String gender = rs.getString("player_gender");
					int score = rs.getInt("player_score");
					String pass = rs.getString("player_pass");
					return new Player(id, name_, gender, score, pass);
				}
				return null;
			}
		};
		Player pl = jdbcTemplate.query(sql, extractor);
		if (pl.getName().equals("") || pl.getPass().equals(""))
			return false;
		if (pl != null) {
			if (pl.getPass().equals(pass_)) {
				return true;
			}
			return false;
		}
		return false;

	}

}
