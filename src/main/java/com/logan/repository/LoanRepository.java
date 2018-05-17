package com.logan.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import com.logan.domain.Loan;

public interface LoanRepository extends JpaRepository<Loan, Integer> {

}
