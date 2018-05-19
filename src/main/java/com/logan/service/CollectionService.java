package com.logan.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.logan.dao.CollectionsDAO;
import com.logan.domain.Collection;
import com.logan.repository.CollectionRepository;

@Service
@Transactional
public class CollectionService {
	
	@Autowired
	private CollectionsDAO collectionsDAO;
	
	@Autowired
	private CollectionRepository collectionRepository;
	
	public List<Collection> getCollectionList(Date fromDate, Date toDate) throws ParseException{
		List<Collection> list = collectionsDAO.getCollections(fromDate, toDate);
		return list;
	}
	
	public List<Collection> getCollectionList(Long userId, Date fromDate, Date toDate) throws ParseException{
		List<Collection> list = collectionRepository.getCollectionByUser(userId, fromDate, toDate);
		return list;
	}

}
