package dto;
import java.io.Serializable;
public class recipelist implements Serializable{

	private static final long serialVersionUID = 1L;
	private int r_id;
	private String r_writer;
	private String r_category;
	private String r_name;
	private String r_desc;
	private String r_product;
	private String r_unit;
	private String r_tip;
	private String r_img;
	
	public String getR_writer() {
		return r_writer;
	}
	public void setR_writer(String r_writer) {
		this.r_writer = r_writer;
	}
	public int getR_id() {
		return r_id;
	}
	public void setR_id(int r_id) {
		this.r_id = r_id;
	}
	public String getR_category() {
		return r_category;
	}
	public void setR_category(String r_category) {
		this.r_category = r_category;
	}
	public String getR_name() {
		return r_name;
	}
	public void setR_name(String r_name) {
		this.r_name = r_name;
	}
	public String getR_desc() {
		return r_desc;
	}
	public void setR_desc(String r_desc) {
		this.r_desc = r_desc;
	}
	public String getR_product() {
		return r_product;
	}
	public void setR_product(String r_product) {
		this.r_product = r_product;
	}
	public String getR_unit() {
		return r_unit;
	}
	public void setR_unit(String r_unit) {
		this.r_unit = r_unit;
	}
	public String getR_tip() {
		return r_tip;
	}
	public void setR_tip(String r_tip) {
		this.r_tip = r_tip;
	}
	public String getR_img() {
		return r_img;
	}
	public void setR_img(String r_img) {
		this.r_img = r_img;
	}
	
	
}
