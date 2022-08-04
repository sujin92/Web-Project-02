package dto;

import java.io.Serializable;

public class seller implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String s_id;
	private String s_com_name;
	private String s_com_number;
	private String s_owner_name;
	private String s_mail;
	private String s_phone;
	private String s_addr;
	
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getS_com_name() {
		return s_com_name;
	}
	public void setS_com_name(String s_com_name) {
		this.s_com_name = s_com_name;
	}
	public String getS_com_number() {
		return s_com_number;
	}
	public void setS_com_number(String s_com_number) {
		this.s_com_number = s_com_number;
	}
	public String getS_owner_name() {
		return s_owner_name;
	}
	public void setS_owner_name(String s_owner_name) {
		this.s_owner_name = s_owner_name;
	}
	public String getS_mail() {
		return s_mail;
	}
	public void setS_mail(String s_mail) {
		this.s_mail = s_mail;
	}
	public String getS_phone() {
		return s_phone;
	}
	public void setS_phone(String s_phone) {
		this.s_phone = s_phone;
	}
	public String getS_addr() {
		return s_addr;
	}
	public void setS_addr(String s_addr) {
		this.s_addr = s_addr;
	}
	
	
}
