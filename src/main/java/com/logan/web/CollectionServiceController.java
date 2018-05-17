package com.logan.web;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.logan.domain.Collection;
import com.logan.domain.Users;
import com.logan.repository.CollectionRepository;
import com.logan.service.CollectionService;
import com.logan.service.UserService;

@RestController
public class CollectionServiceController {

	@Autowired
	private CollectionService collectionService;
	
	
	@RequestMapping(path = "/Services/Collection", method = RequestMethod.GET, produces = { "application/json" })
	public List<Collection> getCollectionList(@RequestParam(name = "from") @DateTimeFormat(pattern="dd/MM/yyyy") Date fromDate,
			@RequestParam(name = "to") @DateTimeFormat(pattern="dd/MM/yyyy") Date toDate) throws ParseException {
		return collectionService.getCollectionList(fromDate, toDate);
	}
	
	@RequestMapping(path = "/Services/Collection/{userId}", method = RequestMethod.GET, produces = { "application/json" })
	public List<Collection> getUserCollectionList(@PathVariable Integer userId, @RequestParam(name = "from") @DateTimeFormat(pattern="dd/MM/yyyy") Date fromDate,
			@RequestParam(name = "to") @DateTimeFormat(pattern="dd/MM/yyyy") Date toDate) throws ParseException {
		return collectionService.getCollectionList(userId, fromDate, toDate);
	}

}
