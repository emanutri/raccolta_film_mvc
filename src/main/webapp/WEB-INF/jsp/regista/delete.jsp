<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="it">
<head>
	<jsp:include page="../header.jsp" />
	<title>Visualizza elemento da eliminare</title>
	
	<!-- style per le pagine diverse dalla index -->
    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">
    
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	
	<main role="main" class="container">
	
	<div class='card'>
		    <div class='card-header'>
		        Visualizza dettaglio
		    </div>
		<form method="post" action="execute" >
		    <div class='card-body'>
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Id:</dt>
				  <dd class="col-sm-9">${regista_delete.id}</dd>
		    	</dl>
		    	
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Nome:</dt>
				  <dd class="col-sm-9">${regista_delete.nome}</dd>
		    	</dl>
		    	
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Cognome:</dt>
				  <dd class="col-sm-9">${regista_delete.cognome}</dd>
		    	</dl>
		    	
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Nickname:</dt>
				  <dd class="col-sm-9">${regista_delete.nickName}</dd>
		    	</dl>
		    	
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Data di Nascita:</dt>
				  <dd class="col-sm-9"><fmt:formatDate type = "date" value = "${regista_delete.dataDiNascita}" /></dd>
		    	</dl>
		    	
		    	
		    	
			    <div class='card-footer'>
			    <button type="submit" name="submit" value="submit" id="submit" class="btn btn-danger">Elimina</button>
			    <input type="hidden" name="idRegista" value="${regista_delete.id}">
			        <a href="${pageContext.request.contextPath }/regista/" class='btn btn-outline-secondary' style='width:80px'>
			            <i class='fa fa-chevron-left'></i> Back
			        </a>
		    	</div>
	    	</div>
		</form>
	</div>		
	<!-- end main container -->	
	</main>
	<jsp:include page="../footer.jsp" />
	
</body>
</html>