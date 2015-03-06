<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/views/include/headtag.jsp"></jsp:include>
	<script>
		$(document).ready(function() {
			var ctxpath = "${ pageContext.request.contextPath }";
		});
	</script>	
</head>
<body>
	<div id="wrapper" class="container-fluid">

		<jsp:include page="/WEB-INF/views/include/topmenu.jsp"></jsp:include>

		<div class="row">
			<div class="col-md-2">
				<jsp:include page="/WEB-INF/views/include/sidemenu.jsp"></jsp:include>
			</div>
			<div id="content" class="col-md-10">
				<c:if test="${ERRORPAGE == 'ERRORPAGE_SHOW'}">
	    			<div class="alert alert-danger alert-dismissible collapse" role="alert">
	  					<button type="button" class="close" data-dismiss="alert">
	  						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
	  					</button>
	  					<h4><strong>Warning!</strong></h4>
	  					<br>
	  					${errorMessageText}
					</div>
				</c:if>
				
				<div id="jsAlerts"></div>

				<h1>
					<span class="fa fa-bank fa-fw"></span>&nbsp;Bank
				</h1>

				<c:choose>
					<c:when test="${PAGEMODE == 'PAGEMODE_PAGELOAD' || PAGEMODE == 'PAGEMODE_LIST' || PAGEMODE == 'PAGEMODE_DELETE'}">
					
					</c:when>
					<c:when test="${PAGEMODE == 'PAGEMODE_ADD'}">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h1 class="panel-title">
									<span class="fa fa-cloud-upload fa-fw fa-2x"></span>Upload
								</h1>
							</div>
							<div class="panel-body">
								<br/>
								<form:form id="bankForm" role="form" class="form-horizontal" modelAttribute="bankForm" action="${pageContext.request.contextPath}/bank/uploaded" enctype="multipart/form-data">
									<div class="form-group">
										<label for="inputBankCode" class="col-sm-2 control-label">Bank</label>
										<div class="col-sm-5">
											<form:select class="form-control" path="bankCode">
												<option>Please Select</option>
												<form:options items="${ bankProviderDDL }" itemValue="lookupKey" itemLabel="lookupValue"/>
											</form:select>
										</div>
									</div>
									<div class="form-group">
										<label for="inputFile" class="col-sm-2 control-label">Upload File</label>
										<div class="col-sm-8">
											<form:input type="file" class="form-control file" id="inputFile" name="inputFile" path="fileBinary" data-show-preview="false" data-show-upload="false"></form:input>
										</div>
									</div>
									<div class="col-md-3 offset-md-9">
										<div class="btn-toolbar">
											<button id="cancelButton" type="reset" class="btn btn-primary pull-right">Cancel</button>
											<button id="submitButton" type="submit" class="btn btn-primary pull-right">Submit</button>											
										</div>
									</div>
								</form:form>
							</div>
						</div>
					</c:when>				
					<c:when test="${PAGEMODE == 'PAGEMODE_EDIT'}">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h1 class="panel-title">
									<span class="fa fa-compress fa-fw fa-2x"></span>Consolidate
								</h1>
							</div>
							<div class="panel-body">
								Contents
							</div>
						</div>
					</c:when>
				</c:choose>				
			</div>
		</div>
	</div>	
</body>
</html>
