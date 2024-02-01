package com.example.flutter_with_restApi_spring.controller;

import com.example.flutter_with_restApi_spring.entity.User;
import com.example.flutter_with_restApi_spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "http://localhost:40386")

public class UserController {


    @Autowired
    private UserService service;

    @PostMapping("/register")
    private ResponseEntity<String> registerUser(@RequestBody User user){
        //save the user
        String msg = service.saveUser(user);

        return new ResponseEntity<String>(msg, HttpStatus.OK);
    }





}
