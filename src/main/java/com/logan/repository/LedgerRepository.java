package com.logan.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.logan.domain.Ledger;

public interface LedgerRepository extends JpaRepository<Ledger, Integer> {

}
