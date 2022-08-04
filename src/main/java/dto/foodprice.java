package dto;
import java.io.Serializable;
public class foodprice implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String f_name;
	private int f_price;
	
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
}

