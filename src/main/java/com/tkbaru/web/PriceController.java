package com.tkbaru.web;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tkbaru.common.Constants;

@Controller
@RequestMapping("/price")
public class PriceController {
	private static final Logger logger = LoggerFactory.getLogger(PriceController.class);
	
	@RequestMapping(value="/todayprice", method = RequestMethod.GET)
	public String todayPricePageLoad(Locale locale, Model model) {
		logger.info("[todayPricePageLoad] " + "");
		
		model.addAttribute(Constants.PAGEMODE, Constants.PAGEMODE_PAGELOAD);
		model.addAttribute(Constants.ERRORFLAG, Constants.ERRORFLAG_HIDE);
		
		return Constants.JSPPAGE_TODAYPRICE;
	}

}