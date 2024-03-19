<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>할인 상품 목록</title>
<style type="text/css">

.card > img {
	width: 100%;
	height: 300px;
	object-fit: contain;
}
.saleIn {
	height: 500px;
	overflow-y: scroll;
}
.card {
	margin: auto 30px;
}
strong {
	color: salmon;
}
</style>

</head>
<body>
	
	<div class="sale container-fluid">
		<div class="saleIn container-fluid">
			
			<div class="row row-cols-1 row-cols-md-2">
			  <div class=" mb-4 sm-6">
			  <a href="#">
			    <div class="card">
			      <img src="/fntimg/organix-outdoor-curved-discount-sofa-boston_1600x.png" class="card-img-top" alt="...">
			      <div class="card-body">
			        <h5 class="card-title"><strong>30% 할인</strong> Card title</h5>
			        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
			      </div>
			    </div>
			   </a>
			  </div>
			  <div class=" mb-4 sm-6">
			    <div class="card">
			      <img src="/fntimg/Organix_4_1600x.png" class="card-img-top" alt="...">
			      <div class="card-body">
			        <h5 class="card-title">Card title</h5>
			        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
			      </div>
			    </div>
			  </div>
			  <div class=" mb-4 sm-6">
			    <div class="card">
			      <img src="/fntimg/organix-outdoor-curved-discount-sofa-boston_1600x.png" class="card-img-top" alt="...">
			      <div class="card-body">
			        <h5 class="card-title">Card title</h5>
			        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content.</p>
			      </div>
			    </div>
			  </div>
			  <div class=" mb-4 sm-6">
			    <div class="card">
			      <img src="/fntimg/Organix_4_1600x.png" class="card-img-top" alt="...">
			      <div class="card-body">
			        <h5 class="card-title">Card title</h5>
			        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
	</div>
</body>
</html>