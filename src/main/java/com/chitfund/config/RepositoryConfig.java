package com.chitfund.config;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = {"com.chitfund.repository"})
@EntityScan(basePackages = {"com.chitfund.domain"})
public class RepositoryConfig {
	
}
