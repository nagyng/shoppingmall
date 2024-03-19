package dto;

import java.io.Serializable;
//	자바빈즈 사용을 위한 클래스 생성 
public class Product  implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	private int pd_no;
	private String pd_name;
	private int pd_category;
	private int pd_color;
	private int pd_room;
	private String pd_size;
	private int pd_price;
	private int pd_stock;
	private int pd_saleprice;
	private String pd_img;  
	private String releaseTime;
	private String updateTime;
	private int cart_qty;
	
	
	
	public Product() {
		super();
	}

	public Product(int pd_no, String pd_name, int pd_category, int pd_color, int pd_room, String pd_size, int pd_price,
			int pd_stock, int pd_saleprice, String pd_img, String releaseTime, 
			String updateTime, int cart_qty) {
		super();
		this.pd_no = pd_no;
		this.pd_name = pd_name;
		this.pd_category = pd_category;
		this.pd_color = pd_color;
		this.pd_room = pd_room;
		this.pd_size = pd_size;
		this.pd_price = pd_price;
		this.pd_stock = pd_stock;
		this.pd_saleprice = pd_saleprice;
		this.pd_img = pd_img;  
		this.releaseTime = releaseTime;
		this.updateTime = updateTime;
		this.cart_qty = cart_qty;
	}

	public int getPd_no() {
		return pd_no;
	}

	public void setPd_no(int pd_no) {
		this.pd_no = pd_no;
	}

	public String getPd_name() {
		return pd_name;
	}

	public void setPd_name(String pd_name) {
		this.pd_name = pd_name;
	}

	public int getPd_category() {
		return pd_category;
	}

	public void setPd_category(int pd_category) {
		this.pd_category = pd_category;
	}

	public int getPd_color() {
		return pd_color;
	}

	public void setPd_color(int pd_color) {
		this.pd_color = pd_color;
	}

	public int getPd_room() {
		return pd_room;
	}

	public void setPd_room(int pd_room) {
		this.pd_room = pd_room;
	}

	public String getPd_size() {
		return pd_size;
	}

	public void setPd_size(String pd_size) {
		this.pd_size = pd_size;
	}

	public int getPd_price() {
		return pd_price;
	}

	public void setPd_price(int pd_price) {
		this.pd_price = pd_price;
	}

	public int getPd_stock() {
		return pd_stock;
	}

	public void setPd_stock(int pd_stock) {
		this.pd_stock = pd_stock;
	}

	public int getPd_saleprice() {
		return pd_saleprice;
	}

	public void setPd_saleprice(int pd_saleprice) {
		this.pd_saleprice = pd_saleprice;
	}

	public String getPd_img() {
		return pd_img;
	}

	public void setPd_img(String pd_img) {
		this.pd_img = pd_img;
	}
 

	public String getReleaseTime() {
		return releaseTime;
	}

	public void setReleaseTime(String releaseTime) {
		this.releaseTime = releaseTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public int getCart_qty() {
		return cart_qty;
	}

	public void setCart_qty(int cart_qty) {
		this.cart_qty = cart_qty;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
