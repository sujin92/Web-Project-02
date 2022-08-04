package dto;

import java.io.Serializable;

public class barcodesearch implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String fb_main;
	private String fb_middle;
	private String fb_sub;
	
	public String getFb_main() {
		return fb_main;
	}
	public void setFb_main(String fb_main) {
		this.fb_main = fb_main;
	}
	public String getFb_middle() {
		return fb_middle;
	}
	public void setFb_middle(String fb_middle) {
		this.fb_middle = fb_middle;
	}
	public String getFb_sub() {
		return fb_sub;
	}
	public void setFb_sub(String fb_sub) {
		this.fb_sub = fb_sub;
	}
	
}
