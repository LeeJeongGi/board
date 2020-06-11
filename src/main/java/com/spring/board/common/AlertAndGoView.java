package com.spring.board.common;

import java.util.HashMap;
import java.util.Map;

import org.springframework.util.Assert;

public class AlertAndGoView {
	private String message;
	private String destUrl;
	private String target;

	protected Map<String, Object> populateModel(Map<String, Object> model) {
		Map<String, Object> populated = new HashMap<String, Object>();

		Object destUrl = this.destUrl == null ? model.get("destUrl") : this.destUrl;
		Assert.notNull(destUrl, "destUrl must be provided");

		populated.put("destUrl", destUrl);
		populated.put("message", message == null ? model.get("message") : message);
		populated.put("target", target == null ? model.get("target") : target);

		return populated;
	}

	protected String getTemplateName() {
		return "alertAndGo.ftl";
	}

	public void setDestUrl(String destUrl) {
		this.destUrl = destUrl;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setTarget(String target) {
		this.target = target;
	}
}
