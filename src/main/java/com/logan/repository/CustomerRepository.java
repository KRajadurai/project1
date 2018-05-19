package com.logan.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.logan.domain.Customer;

public interface CustomerRepository extends JpaRepository<Customer, Integer> {

}
