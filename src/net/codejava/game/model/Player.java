package net.codejava.game.model;

public class Player {
	private int id;
	private String name;
	private String gender;
	private int score;
	private String pass;

	public Player(int id, String name, String gender, int score, String pass) {
		this(name, gender, score, pass);
		this.id = id;

	}

	public Player(String name, String gender, int score, String pass) {
		this.name = name;
		this.gender = gender;
		this.score = score;
		this.pass = pass;
	}

	public Player() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	@Override
	public String toString() {
		return "Player [id=" + id + ", name=" + name + ", gender=" + gender + ", score=" + score + ", pass=" + pass
				+ "]";
	}

}
