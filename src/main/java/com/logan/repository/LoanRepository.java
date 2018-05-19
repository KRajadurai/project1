package com.logan.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.logan.domain.Loan;

public interface LoanRepository extends JpaRepository<Loan, Integer> {

}
