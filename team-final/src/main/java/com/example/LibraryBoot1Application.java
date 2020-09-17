package com.example;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
@MapperScan("com.example.mapper")
public class LibraryBoot1Application {

	public static void main(String[] args) {
		SpringApplication.run(LibraryBoot1Application.class, args);
	}

}
 