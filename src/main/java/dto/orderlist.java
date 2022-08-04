package dto;

import java.io.Serializable;

public class orderlist implements Serializable{

	private static final long serialVersionUID = 1L;
	private int id;
	private String date;
	private String f_name;
	private String f_singname;
	private String f_singunit;
	private String addr;
	private int chk;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	public String getF_singname() {
		return f_singname;
	}
	public void setF_singname(String f_singname) {
		this.f_singname = f_singname;
	}
	public String getF_singunit() {
		return f_singunit;
	}
	public void setF_singunit(String f_singunit) {
		this.f_singunit = f_singunit;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public int getChk() {
		return chk;
	}
	public void setChk(int chk) {
		this.chk = chk;
	}
	
}
