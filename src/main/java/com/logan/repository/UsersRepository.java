package com.logan.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import com.logan.domain.Users;

public interface UsersRepository extends JpaRepository<Users, Integer> {

}
