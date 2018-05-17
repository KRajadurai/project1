package com.logan.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.logan.domain.Users;
import com.logan.repository.UsersRepository;

@Service
@Transactional
public class UserService {
	
	@Autowired
	private UsersRepository usersRepository;
	
	public Users getUsers(int loginId){
		Optional<Users> user = usersRepository.findById(loginId);
		return user.get();
	}
	
	public List<Users> getUsers(){
		List<Users> user = usersRepository.findAll();
		return user;
	}

}
