// File: src/main/java/com/example/blogapp/controller/HelloController.java

//package com.example.blogapp.controller;
package com.nakul.blogapp;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String hello() {
        return "Hello, World from Spring Boot!- Nakul-virtuecloud";
    }
}
