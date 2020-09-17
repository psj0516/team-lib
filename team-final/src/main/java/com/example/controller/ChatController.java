package com.example.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.domain.MemberVo;
import com.example.service.MemberService;

import lombok.extern.java.Log;

@Log
@RequestMapping("/chat/*")
@Controller
public class ChatController {
	@Autowired
	private MemberService memberService;

	@GetMapping("/chat")
	public void chat(HttpSession session, Model model) {
		log.info("채팅창 켜짐");
		String id = (String) session.getAttribute("id");
		MemberVo info = memberService.getInfoById(id);
		model.addAttribute("memberVo", info);
	}

}