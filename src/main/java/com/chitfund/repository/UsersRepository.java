package com.chitfund.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.chitfund.domain.Users;

public interface UsersRepository extends JpaRepository<Users, Long> {
	
	@Query("from Users where username=:username")
	Optional<Users> getUserByUsername(@Param("username") String username);

}
