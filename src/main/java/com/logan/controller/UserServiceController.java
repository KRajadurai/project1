package com.logan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.logan.domain.Users;
import com.logan.service.UserService;

@RestController
public class UserServiceController {

	@Autowired
	private UserService userService;
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(path = "/Services/Users", method = RequestMethod.GET, produces = { "application/json" })
	public List<Users> getUsers() {
		return userService.getUsers();
	}

	@RequestMapping(path = "/Services/Users/{userId}", method = RequestMethod.GET, produces = { "application/json" })
	public Users getUsers(@PathVariable(name = "userId") long userId) {
		return userService.getUsers(userId);
	}

}
