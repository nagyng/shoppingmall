package dao; 

import java.util.ArrayList;
 
import dto.Product;

public class ProductRepository {

	private ArrayList<Product> listOfProducts = new ArrayList<Product>();
	private static ProductRepository instance = new ProductRepository();
	// static 정적 필드 - 클래스 실행 시 메서드 영역에 생성되고 클래스 종료 시 같이 소멸 
	// instance 필드 초기값으로 인스턴스 생성 

	public ProductRepository() {
		Product product30 = new Product(30, "다크 모던 테이블",1,9,1,"small",30000,1000,25000,"side_table_01.png","2024-02-15","2024-02-15",1000);
		Product product31 = new Product(31, "사각 모던 테이블",1,6,1,"small",20000,1000,20000,"side_table_02.png","2024-02-15",null,1000);
		Product product32 = new Product(32, "사각 모던 테이블",1,6,1,"small",22000,1000,22000,"side_table_03.png","2024-02-15",null,1000);
		Product product33 = new Product(33, "사각 모던 테이블",1,6,1,"small",35000,1000,35000,"side_table_04.png","2024-02-15",null,1000);
		Product product34 = new Product(34, "사각 모던 테이블",1,6,1,"small",20000,1000,30000,"side_table_05.png","2024-02-15",null,1000);
		Product product35 = new Product(35, "블랙 모던 테이블",1,9,1,"small",20000,1000,20000,"side_table_06.png","2024-02-15",null,1000);
		Product product36 = new Product(36, "미니 모던 테이블",1,6,1,"small",20000,1000,20000,"side_table_07.png","2024-02-15",null,1000);
		Product product37 = new Product(37, "둥근 모던 테이블",1,9,1,"small",20000,1000,20000,"side_table_08.png","2024-02-15",null,1000);
		Product product38 = new Product(38, "수납형 모던 테이블",1,6,1,"small",20000,1000,20000,"side_table_09.png","2024-02-15",null,1000);
		Product product39 = new Product(39, "모던 테이블",1,6,1,"small",20000,1000,20000,"side_table_10.png","2024-02-15",null,1000);

		Product product40 = new Product(40, "클래식 모던 테이블",1,6,1,"small",30000,1000,25000,"side_table_11.png","2024-02-15",null,1000);
		Product product41 = new Product(41, "원형 모던 테이블",1,6,1,"small",20000,1000,20000,"side_table_12.png","2024-02-15",null,1000);
		Product product42 = new Product(42, "투명 모던 테이블",1,9,1,"small",22000,1000,22000,"side_table_13.png","2024-02-15",null,1000);
		Product product43 = new Product(43, "사각 모던 테이블",1,9,1,"small",35000,1000,35000,"side_table_14.png","2024-02-15",null,1000);  

		Product product44 = new Product(44, "남색 모던 소파",2,5,1,"medium",40000,200,40000,"ikea_glostad_fabric_sofa.png","2024-02-15",null,200);
		Product product45 = new Product(45, "회색 모던 소파",2,10,1,"medium",40000,200,32000,"optimize.png","2024-02-15","2024-02-15",200);
		Product product46 = new Product(46, "화이트 라운드 소파 중형",2,11,1,"medium",40000,200,40000,"Organix_4_1600x.png","2024-02-15","2024-02-19",200);
		Product product47 = new Product(47, "화이트 라운드 소파 대형",2,11,1,"large",120000,200,120000,"organix-outdoor-curved-discount-sofa-boston_1600x.png","2024-02-15","2024-02-19",200);
		Product product48 = new Product(48, "노랑 체크 패턴 소파",2,5,1,"medium",40000,200,40000,"yellowsofa.png","2024-02-15",null,200);

		Product product51 = new Product(51, "레드 가벼운 의자",2,1,1,"small",15000,1000,20000,"redchair.jpg","2024-02-15","2024-02-15",1000);
		Product product52 = new Product(52, "노랑 편안한 의자",2,2,1,"small",15000,1000,22000,"yellowchair.jpg","2024-02-15","2024-02-15",1000);
		Product product53 = new Product(53, "시원한 하늘색 가벼운 의자",2,5,1,"small",15000,1000,35000,"skybluechair.jpg","2024-02-15","2024-02-15",1000);
		Product product54 = new Product(54, "모던 유아용 레이싱카 침대 - 파랑",3,5,5,"large",350000,500,350000,"single-wooden-kids-car-shape-bed.png","2024-02-19","2024-02-19",500);
		Product product55 = new Product(55, "모던 유아용 레이싱카 침대 - 분홍",3,8,5,"large",310000,500,310000,"Solid-Wood-Children.png","2024-02-19","2024-02-19",500);
		Product product56 = new Product(56, "모던 유아용 레이싱카 침대 - 화이트",3,11,5,"large",310000,500,310000,"Solid-Wood-Children-s.png","2024-02-19","2024-02-19",500);
		Product product57 = new Product(57, "모던 유아용 레이싱카 침대 - 보라",3,7,5,"large",170000,500,170000,"childpurple.jpg","2024-02-19","2024-02-19",500);
		Product product58 = new Product(58, "모던 유아용 레이싱카 디자인 침대 - 민트",3,4,5,"large",280000,500,280000,"Modern-Children-Bedroom.jpg","2024-02-19","2024-02-19",500);
		Product product59 = new Product(59, "커스텀용 베드 헤드",3,4,2,"medium",400000,2000,400000,"petal-bed-head.png","2024-02-19","2024-02-19",2000);
		Product product60 = new Product(60, "편안한 오버사이즈 오렌지 침구",3,2,2,"large",270000,2000,270000,"crayola-comforter-set.png","2024-02-15","2024-02-19",2000);
		
		Product product61 = new Product(61, "기본 화이트 소파",2,11,1,"medium",100000,1000,100000,"whitesofa.png","2024-02-19","2024-02-19",1000); 
		Product product63 = new Product(63, "매든 침대 프레임(라이트 그레이)",3,11,2,"small",284000,1000,244000,"1000000322_detail_018.jpg","2024-03-08","2024-03-08",2000);
		Product product64 = new Product(64, "로티 침대 프레임(그레이)",3,9,2,"small",250000,0,244000,"1000000321_detail_078.jpg","2024-03-08","2024-03-08",0);
		Product product65 = new Product(65, "BOLMSÖ 볼름쇠",6,9,9,"medium",149000,500,149000,"BOLMSÖ.png","2024-03-08","2024-03-08",500);
		Product product66 = new Product(66, "KLIPPKAKTUS 클립칵투스",4,11,3,"medium",3900,5000,3900,"KLIPPKAKTUS.png","2024-03-08","2024-03-08",5000);
		Product product67 = new Product(67, "VOXNAN 복스난",5,10,4,"medium",159000,5000,159000,"VOXNAN.png","2024-03-08","2024-03-08",5000);
		Product product68 = new Product(68, "STRANDÖN 스트란된",7,2,9,"medium",35000,5000,35000,"STRANDÖN.png","2024-03-08","2024-03-08",5000);
		Product product69 = new Product(69, "SLIBB 슬리브",5,5,8,"medium",7000,5000,7000,"SLIBB.png","2024-03-08","2024-03-08",5000);
		Product product70 = new Product(70, "KOPPLA 콥플라",1,11,6,"large",19000,2000,19000,"KOPPLA.png","2024-03-08","2024-03-08",2000);

		
		
		

		listOfProducts.add(product30);
		listOfProducts.add(product31);
		listOfProducts.add(product32);
		listOfProducts.add(product33);
		listOfProducts.add(product34);
		listOfProducts.add(product35);
		listOfProducts.add(product36);
		listOfProducts.add(product37);
		listOfProducts.add(product38);
		listOfProducts.add(product39);

		listOfProducts.add(product40);
		listOfProducts.add(product41);
		listOfProducts.add(product42);
		listOfProducts.add(product43);
		listOfProducts.add(product44);
		listOfProducts.add(product45);
		listOfProducts.add(product46);
		listOfProducts.add(product47);
		listOfProducts.add(product48);

		listOfProducts.add(product51);
		listOfProducts.add(product52);
		listOfProducts.add(product53);
		listOfProducts.add(product54);
		listOfProducts.add(product55);
		listOfProducts.add(product56);
		listOfProducts.add(product57);
		listOfProducts.add(product58);
		listOfProducts.add(product59);
		listOfProducts.add(product60);
		
		listOfProducts.add(product61);
		listOfProducts.add(product63);
		listOfProducts.add(product64);
		listOfProducts.add(product65);
		listOfProducts.add(product66);
		listOfProducts.add(product67);
		listOfProducts.add(product68);
		listOfProducts.add(product69);
		listOfProducts.add(product70);
		
	}
	
	public ArrayList<Product> getAllProducts(){
		return listOfProducts;
	}

	public Product getProductByNo(int pd_no) {				
		Product productByNo=null;
		
		for(int i = 0; i < listOfProducts.size(); i++) {
			Product product=listOfProducts.get(i); 
			if (product!=null && product.getPd_no()!= 0 && 
					product.getPd_no() == pd_no) { 
				productByNo=product;		  
				break; 
			}
		}
		return productByNo;
	}
	 
	public static ProductRepository getInstance() {	  
		return instance;			 
	}
	
	public void addProduct(Product product) { 
		listOfProducts.add(product);		 
	}
}
