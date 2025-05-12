// package com.nakul.blogapp;

// import org.springframework.boot.SpringApplication;
// import org.springframework.boot.autoconfigure.SpringBootApplication;

// @SpringBootApplication
// public class BlogappApplication {

// 	public static void main(String[] args) {
// 		SpringApplication.run(BlogappApplication.class, args);
// 	}

// }

package com.nakul.blogapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class BlogappApplication {

    public static void main(String[] args) {
        SpringApplication.run(BlogappApplication.class, args);
    }
}
