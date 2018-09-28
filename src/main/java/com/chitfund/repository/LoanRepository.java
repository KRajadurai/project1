package com.chitfund.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.chitfund.domain.Loan;

public interface LoanRepository extends JpaRepository<Loan, Integer> {

}
