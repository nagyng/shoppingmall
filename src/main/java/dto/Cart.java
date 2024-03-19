package dto;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Cart {

	public void update( HttpServletRequest request,  
						HttpSession httpSession, 
						int pd_no,  
						int cart_qty) {

		HttpSession session = request.getSession(true);
		ArrayList<Product> product = (ArrayList<Product>)session.getAttribute("cartlist");


		for(int i=0; i<product.size(); i++) {
			if(product.get(i).getPd_no() == pd_no) {
				product.get(i).setCart_qty(cart_qty);
				break;  
			}
		}
	}

	
	
}
