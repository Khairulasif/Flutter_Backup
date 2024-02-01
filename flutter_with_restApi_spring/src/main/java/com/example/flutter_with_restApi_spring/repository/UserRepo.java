package com.example.flutter_with_restApi_spring.repository;

import com.example.flutter_with_restApi_spring.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Integer> {

}
