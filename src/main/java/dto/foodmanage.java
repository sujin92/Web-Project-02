package dto;

import java.io.Serializable;

public class foodmanage implements Serializable{

	private static final long serialVersionUID = 1L;
	private String f_id;
	private String f_code;
	private String f_name;
	private int f_price;
	private int f_unit;
	
	public String getF_id() {
		return f_id;
	}
	public void setF_id(String f_id) {
		this.f_id = f_id;
	}
	public String getF_code() {
		return f_code;
	}
	public void setF_code(String f_code) {
		this.f_code = f_code;
	}
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	public int getF_price() {
		return f_price;
	}
	public void setF_price(int f_price) {
		this.f_price = f_price;
	}
	public int getF_unit() {
		return f_unit;
	}
	public void setF_unit(int f_unit) {
		this.f_unit = f_unit;
	}
	
	
}
