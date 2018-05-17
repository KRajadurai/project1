package com.logan.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.logan.domain.Collection;

public interface CollectionRepository extends JpaRepository<Collection, Integer> {
	
	 @Query("from Collection WHERE users.loginId=:userId and collectDate >= :fromDate and collectDate <= :toDate")
	 List<Collection> getCollectionByUser(@Param("userId") Integer userId, @Param("fromDate") Date fromDate, @Param("toDate") Date toDate);
	 
}
