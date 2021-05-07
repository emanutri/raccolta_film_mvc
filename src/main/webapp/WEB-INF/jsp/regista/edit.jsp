<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!doctype html>
<html lang="it">
<head>
	<jsp:include page="../header.jsp" />
	<title>Inserisci nuovo</title>
	
	<!-- style per le pagine diverse dalla index -->
    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jqueryUI/jquery-ui.min.css" />
	<style>
		.ui-autocomplete-loading {
			background: white url("../assets/img/jqueryUI/anim_16x16.gif") right center no-repeat;
		}
		.error_field {
	        color: red; 
	    }
	</style>
    
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	
	<main role="main" class="container">
	
		<%-- se l'attributo in request ha errori --%>
		<spring:hasBindErrors  name="film_regista_attr">
			<%-- alert errori --%>
			<div class="alert alert-danger " role="alert">
				Attenzione!! Sono presenti errori di validazione
			</div>
		</spring:hasBindErrors>
	
		<div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none': ''}" role="alert">
		  ${errorMessage}
		  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		    <span aria-hidden="true">&times;</span>
		  </button>
		</div>
		
		<div class='card'>
		    <div class='card-header'>
		        <h5>Inserisci nuovo elemento</h5> 
		    </div>
		    <div class='card-body'>

					<form:form method="post" modelAttribute="registi_attribute" action="update" novalidate="novalidate" >
					
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="nome">Nome</label>
								<spring:bind path="nome">
									<input type="text" name="nome" id="nome" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="Inserire il nome" value="${registi_attribute.nome }">
								</spring:bind>
								<form:errors  path="nome" cssClass="error_field" />
							</div>
							
							<div class="form-group col-md-6">
								<label for="cognome">Cognome</label>
								<spring:bind path="cognome">
									<input type="text" name="cognome" id="cognome" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="Inserire il cognome" value="${registi_attribute.cognome }">
								</spring:bind>
								<form:errors  path="cognome" cssClass="error_field" />
							</div>
						</div>
						
						<div class="form-row">
							
						<div class="form-group col-md-6">
								<label for="nickName">Nickname</label>
								<spring:bind path="nickName">
									<input type="text" class="form-control ${status.error ? 'is-invalid' : ''}" name="nickName" id="nickName" placeholder="Inserire il nickName" value="${registi_attribute.nickName }">
								</spring:bind>
								<form:errors  path="nickName" cssClass="error_field" />
							</div>
						</div>
						
							<fmt:formatDate pattern='yyyy-MM-dd' var="parsedDate" type='date' value='${registi_attribute.dataDiNascita}' />
							<div class="form-group col-md-6">
								<label for="dataDiNascita">Data di Nascita</label>
                        		<spring:bind path="dataDiNascita">
	                        		<input class="form-control ${status.error ? 'is-invalid' : ''}" id="dataDiNascita" type="date" placeholder="dd/MM/yy"
	                            		title="formato : gg/mm/aaaa"  name="dataDiNascita" value="${parsedDate}" >
	                            </spring:bind>
                            	<form:errors  path="dataDiNascita" cssClass="error_field" />
							</div>
							
							<div class="form-group col-md-3">
								<label for="sesso">Sesso <span class="text-danger">*</span></label>
							    <spring:bind path="sesso">
								    <select class="form-control ${status.error ? 'is-invalid' : ''}" id="sesso" name="sesso" required>
								      	<option value="MASCHIO" ${registi_attribute.sesso == 'MASCHIO'?'selected':''} >M</option>
								      	<option value="FEMMINA" ${registi_attribute.sesso == 'FEMMINA'?'selected':''} >F</option>
								    </select>
							    </spring:bind>
							    <form:errors  path="sesso" cssClass="error_field" />
							</div>
							
						
							
						<button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary">Conferma</button>
						<input type="hidden" name="idRegista" value="${registi_attribute.id}">
					</form:form>
					
			<!-- end card-body -->			   
		    </div>
		</div>	
	
	<!-- end container -->	
	</main>
	<jsp:include page="../footer.jsp" />
	
</body>
</html>