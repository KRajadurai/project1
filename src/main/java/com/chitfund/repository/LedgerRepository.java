package com.chitfund.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.chitfund.domain.Ledger;

public interface LedgerRepository extends JpaRepository<Ledger, Integer> {

}
