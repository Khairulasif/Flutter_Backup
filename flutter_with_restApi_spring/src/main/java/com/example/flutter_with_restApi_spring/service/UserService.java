package com.example.flutter_with_restApi_spring.service;

import com.example.flutter_with_restApi_spring.entity.User;
import com.example.flutter_with_restApi_spring.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepo repo;

    public String saveUser(User user) {

        repo.save(user);
        return "User registered Successfully";
    }
}