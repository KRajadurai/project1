package com.logan.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

import com.logan.config.AppConfig;

@SpringBootApplication(exclude={SecurityAutoConfiguration.class})
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(new Class[]{Application.class, AppConfig.class}, args);
	}
}
