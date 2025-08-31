package com.aurionpro.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class Database {
	private static Database instance;
	private Connection connection;

	private Database() {
		try {
			Properties props = new Properties();
			InputStream in = getClass().getClassLoader().getResourceAsStream("application.properties");
			props.load(in);
			String url = props.getProperty("db.url");
			String user = props.getProperty("db.user");
			String password = props.getProperty("db.password");
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Database getInstance() {
		if (instance == null) {
			instance = new Database();
		}
		return instance;
	}

	public Connection getConnection() {
		return connection;
	}
}
