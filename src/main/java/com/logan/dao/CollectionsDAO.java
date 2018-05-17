package com.logan.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.logan.domain.Collection;

@Transactional
@Repository
public class CollectionsDAO {
	
	@PersistenceContext
	private EntityManager em;
	
	public List<Collection> getCollections(Date fromDate, Date toDate){
		
		List<Collection> list = em.createQuery("from Collection where collectDate >= :fromDate and collectDate <= :toDate", Collection.class)
				.setParameter("fromDate", fromDate)
				.setParameter("toDate", toDate).getResultList();
		
		return list;
		
	}

}
