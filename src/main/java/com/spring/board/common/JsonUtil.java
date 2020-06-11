package com.spring.board.common;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonUtil {

	private final static Log logger = LogFactory.getLog(JsonUtil.class);
	public static ObjectMapper mapper = new ObjectMapper();

	public static String convertToJsonString(Object object) {

		String returnString = "";

		try {
			returnString = mapper.writeValueAsString(object);
		} catch (Exception e) {
			logger.error("error", e);
		}

		return returnString;
	}
}
