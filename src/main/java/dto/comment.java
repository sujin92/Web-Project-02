package dto;

import java.io.Serializable;

public class comment implements Serializable{
	private static final long serialVersionUID = 1L;
	private int bc_id; 
	private String bc_writer;
	private String bc_content;
	private String bc_date;
	
	public int getBc_id() {
		return bc_id;
	}
	public void setBc_id(int bc_id) {
		this.bc_id = bc_id;
	}
	public String getBc_writer() {
		return bc_writer;
	}
	public void setBc_writer(String bc_writer) {
		this.bc_writer = bc_writer;
	}
	public String getBc_content() {
		return bc_content;
	}
	public void setBc_content(String bc_content) {
		this.bc_content = bc_content;
	}
	public String getBc_date() {
		return bc_date;
	}
	public void setBc_date(String bc_date) {
		this.bc_date = bc_date;
	}
	
}
