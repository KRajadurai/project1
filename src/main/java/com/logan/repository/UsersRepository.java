package com.logan.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.logan.domain.Users;

public interface UsersRepository extends JpaRepository<Users, Integer> {
	
	@Query("from Users where username=:username")
	Optional<Users> getUserByUsername(@Param("username") String username);

}
