<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/views/include/headtag.jsp"></jsp:include>
	<script>
		$(document).ready(function() {
			var ctxpath = "${ pageContext.request.contextPath }";

			$('#cancelButton').click(function() {
				window.location = (ctxpath + "/po/revise");
			});

			$('#editTableSelection, #deleteTableSelection').click(function() {
				var id = "";
				var button = $(this).attr('id');

				$('input[type="checkbox"][id^="cbx_"]').each(function(index, item) {
					if ($(item).prop('checked')) {
						id = $(item).attr("value");
					}
				});

				if (id == "") {
					jsAlert("Please select at least 1 po");
					return false;
				} else {
					if (button == 'editTableSelection') {
						$('#editTableSelection').attr("href",ctxpath + "/po/revise/" + id);
					} else {
						$('#deleteTableSelection').attr("href",ctxpath + "/po/delete/" + id);
					}
				}
			});

			$('#addProdButton, #removeProdButton').click(function() {
				var id = "";
				var button = $(this).attr('id');

				if (button == 'addProdButton') {
					$("#productSelect").parsley().validate();
					
					if(false == $('#productSelect').parsley().isValid()) {						
						return false;					
		            } else {
						id = $('#productSelect').val();
						$('#reviseForm').attr('action', ctxpath + "/po/additems/" + id);
		            }
				} else {
					id = $(this).val();
					$('#reviseForm').attr('action', ctxpath + "/po/removeitems/" + id);
				}
			});
		
			$('#submitButton').click(function() {
				$('#reviseForm').parsley({
				    excluded: '[id^="productSelect"]'
				}).validate();

				if(false == $('#reviseForm').parsley().isValid()) {
					return false;
	            } else if ($('#itemsListTable tbody tr').size() == 0) {
	            	jsAlert('At least 1 transaction item needed');
	            	return false;
	            } else {
					$('#reviseForm').attr('action', ctxpath + "/po/saverevise");
	            }
			});

			var supplier = $("#inputSupplierId").val()
			$("#supplierTooltip").tooltip({ title : supplier });
			
			$('#reviseTableList').DataTable();
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
					<div class="alert alert-danger alert-dismissible collapse"
						role="alert">
						<button type="button" class="close" data-dismiss="alert">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h4>
							<strong>Warning!</strong>
						</h4>
						<br> ${errorMessageText}
					</div>
				</c:if>

				<div id="jsAlerts"></div>

				<h1>
					<span class="fa fa-truck fa-fw"></span>&nbsp;<spring:message code="po_revise_jsp.title" text="Revise Purchase Order"/>
				</h1>

				<c:choose>
					<c:when
						test="${ PAGEMODE == 'PAGEMODE_LIST' }">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h1 class="panel-title">
									<span class="fa fa-smile-o fa-fw fa-2x"></span>PO Revise List
								</h1>
							</div>
							<div class="panel-body">
								<table id="reviseTableList" class="table table-bordered table-hover display responsive">
									<thead>
										<tr>
											<th width="5%">&nbsp;</th>
											<th width="20%">PO Code</th>
											<th width="20%">PO Date</th>
											<th width="20%">Supplier</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${not empty reviseList}">
											<c:forEach items="${ reviseList }" var="i" varStatus="status">
												<tr>
													<td align="center"><input id="cbx_<c:out value="${ i.poId }"/>" type="checkbox" value="<c:out value="${ i.poId }"/>" /></td>
													<td><c:out value="${ i.poCode }"></c:out></td>
													<td><fmt:formatDate pattern="dd-MM-yyyy" value="${ i.poCreatedDate }" /></td>
													<td><c:out value="${ i.supplierLookup.supplierName }"></c:out></td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
								<a id="editTableSelection" class="btn btn-sm btn-primary" href=""><span class="fa fa-edit fa-fw"></span>&nbsp;Revise</a>
							</div>
						</div>
					</c:when>
					<c:when test="${PAGEMODE == 'PAGEMODE_EDIT'}">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h1 class="panel-title">
									<c:choose>
										<c:when test="${PAGEMODE == 'PAGEMODE_EDIT'}">
											<span class="fa fa-edit fa-fw fa-2x"></span>&nbsp;Revise PO
										</c:when>
									</c:choose>
								</h1>
							</div>
							<div class="panel-body">
								<form:form id="reviseForm" role="form" class="form-horizontal" modelAttribute="reviseForm" action="${pageContext.request.contextPath}/po/saverevise">
									<div class="tab-content">
										<div role="tabpanel" class="tab-pane active">
											<br />
											<form:hidden path="poId" />
											<form:hidden path="createdBy" />
											<form:hidden path="createdDate" />
											<div class="row">
												<div class="col-md-12">
													<div class="panel panel-default">
														<div class="panel-body">
															<div class="row">
																<div class="col-md-7">
																	<div class="form-group">
																		<label for="inputPOCode" class="col-sm-2 control-label">PO Code</label>
																		<div class="col-sm-5">
																			<form:input type="text" class="form-control" readonly="true" id="inputPOCode" path="poCode" placeholder="Enter PO Code"></form:input>
																		</div>
																	</div>
																	<div class="form-group">
																		<label for="inputPOType" class="col-sm-2 control-label">PO Type</label>
																		<div class="col-sm-8">
																			<form:hidden path="poType"></form:hidden>
																			<form:input type="text" class="form-control" readonly="true" id="inputPOType" path="poTypeLookup.lookupValue"></form:input>
																		</div>
																	</div>
																	<div class="form-group">
																		<label for="inputSupplierId" class="col-sm-2 control-label">Supplier</label>
																		<div class="col-sm-9">
																			<form:hidden path="supplierId" />
																			<form:input id="inputSupplierId" type="text" class="form-control" path="supplierLookup.supplierName" readonly="true" />
																		</div>
																		<div class="col-sm-1">
																			<button id="supplierTooltip" type="button" class="btn btn-default" data-toggle="tooltip" data-trigger="hover" data-html="true" data-placement="right" data-title="">
																				<span class="fa fa-external-link fa-fw"></span>
																			</button>
																		</div>
																	</div>
																</div>
																<div class="col-md-5">
																	<div class="form-group">
																		<label for="inputPoDate" class="col-sm-3 control-label">PO Date</label>
																		<div class="col-sm-9">
																			<form:input type="text" class="form-control" readonly="true" id="poCreatedDate" path="poCreatedDate" placeholder="Enter PO Date"></form:input>
																		</div>
																	</div>
																	<div class="form-group">
																		<label for="inputPOStatus" class="col-sm-3 control-label">Status</label>
																		<div class="col-sm-9">
																			<form:hidden path="poStatus"></form:hidden>
																			<label id="inputPOStatus" class="control-label"><c:out value="${ reviseForm.statusLookup.lookupValue }"></c:out></label>
																		</div>
																	</div>
																</div>
															</div>
															<hr>
															<div class="row">
																<div class="col-md-7">
																	<div class="form-group">
																		<label for="inputShippingDate" class="col-sm-2 control-label">Shipping Date</label>
																		<div class="col-sm-5">
																			<form:input type="text" class="form-control" readonly="true" id="shippingDate" path="shippingDate" placeholder="Enter Shipping Date"></form:input>
																		</div>
																	</div>
																	<div class="form-group">
																		<label for="inputWarehouseId" class="col-sm-2 control-label">Warehouse</label>
																		<div class="col-sm-8">
																			<form:hidden path="warehouseId" />
																			<form:input type="text" class="form-control" path="warehouseLookup.warehouseName" readonly="true" />
																		</div>
																	</div>
																</div>
																<div class="col-md-5">
																	<div class="form-group">
																		<div class="col-sm-9"></div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12">
													<div class="panel panel-default">
														<div class="panel-heading">
															<h1 class="panel-title">Transactions</h1>
														</div>
														<div class="panel-body">
															<div class="row">
																<div class="col-md-11">
																	<div class="form-group" style="padding-left: 2%">
																	<select id="productSelect" name="productSelect" class="form-control" data-parsley-required="true" data-parsley-trigger="change">
																		<option value="">Please Select</option>
																			<c:forEach items="${ productSelectionDDL }" var="psddl">
																			<option value="${ psddl.productId }">${ psddl.productName }</option>
																		</c:forEach>
																	</select>
																	</div>
																</div>
																<div class="col-md-1">
																	<button id="addProdButton" type="submit" class="btn btn-primary pull-right">
																		<span class="fa fa-plus"></span>
																	</button>
																</div>
															</div>
															<br />
															<div class="row">
																<div class="col-md-12">
																	<table id="itemsListTable" class="table table-bordered table-hover display responsive">
																		<thead>
																			<tr>
																				<th width="30%">Product Name</th>
																				<th width="15%">Quantity</th>
																				<th width="15%" class="text-right">Unit</th>
																				<th width="15%" class="text-right">Price/Base Unit</th>
																				<th width="5%">&nbsp;</th>
																				<th width="20%">Total Price</th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:set var="total" value="${0}" />
																			<c:forEach items="${ reviseForm.itemsList }" var="iL" varStatus="iLIdx">
																				<tr>
																					<td style="vertical-align: middle;">
																					    <form:hidden path="itemsList[${ iLIdx.index }].itemsId" /> 
																						<form:hidden path="itemsList[${ iLIdx.index }].productId" />
																						<c:out value="${iL.productLookup.productName }"></c:out></td>
																					<td class="center-align">
																						<div class="form-group no-margin">
																							<div class="col-sm-12">
																								<form:input type="text" class="form-control text-right no-margin" id="inputItemsQuantity${ iLIdx.index }" path="itemsList[${ iLIdx.index }].prodQuantity" placeholder="Enter Quantity" data-parsley-type="number" data-parsley-trigger="keyup"></form:input>
																							</div>
																						</div>
																					</td>
																					<td style="vertical-align: middle;">
																						<div class="form-group no-margin">
																							<div class="col-md-12">																							
																								<form:select class="form-control no-margin" path="itemsList[${ iLIdx.index }].unitCode" data-parsley-required="true" data-parsley-trigger="change" disabled="${ loginContext.poList[poIdx.index].poStatus =='L013_WA' }">
																									<option value=""><spring:message code="common.please_select"></spring:message></option>
																									<c:forEach items="${ reviseForm.itemsList[iLIdx.index].productLookup.productUnit }" var="prdUnit">
																										<form:option value="${ prdUnit.unitCode }"><c:out value="${ prdUnit.unitCodeLookup.lookupValue }"/></form:option>
																									</c:forEach>
																								</form:select>
																							</div>
																						</div>
																					</td>
																					<td style="vertical-align: middle;">
																						<div class="form-group no-margin">
																							<div class="col-sm-12">
																								<form:input type="text" class="form-control text-right no-margin" id="inputItemsProdPrice${ iLIdx.index }" path="itemsList[${ iLIdx.index }].prodPrice" placeholder="Enter Price" data-parsley-type="number" data-parsley-trigger="keyup"></form:input>
																							</div>
																						</div>
																					</td>																					
																					<td style="vertical-align: middle;">
																						<button id="removeProdButton" type="submit" class="btn btn-primary pull-right" value="${ iLIdx.index }">
																							<span class="fa fa-minus"></span>
																						</button>
																					</td>
																					<td style="vertical-align: middle;" class="text-right">
																						<fmt:formatNumber type="number" pattern="##,###.00" value="${ (iL.toBaseQty * iL.prodPrice) }"></fmt:formatNumber>
																					</td>
																				</tr>
																				<c:set var="total" value="${ total+ (iL.toBaseQty * iL.prodPrice) }" />
																				<c:forEach items="${ iL.receiptList }" var="iR" varStatus="iRIdx">
																					<form:hidden path="itemsList[${ iLIdx.index }].receiptList[${ iRIdx.index }].receiptId" />																				
																				</c:forEach>																				
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<table id="itemsTotalListTable"
																		class="table table-bordered table-hover display responsive">
																		<tbody>
																			<tr>
																				<td width="80%" class="text-right">Total</td>
																				<td width="20%" class="text-right">
																					<fmt:formatNumber type="number" pattern="##,###.00" value="${ total }"></fmt:formatNumber>
																				</td>
																			</tr>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-md-12">
															<div class="panel panel-default">
																<div class="panel-heading">
																	<h1 class="panel-title">Remarks</h1>																	
																</div>
																<div class="panel-body">
																	<div class="row">
																		<div class="col-md-12">
																			<div class="form-group">
																				<div class="col-sm-12">
																					<form:textarea id="poRemarks" class="form-control" path="poRemarks" rows="5" />
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="col-md-7 col-offset-md-5">
													<div class="btn-toolbar">
														<button id="cancelButton" type="button" class="btn btn-primary pull-right"><spring:message code="common.cancel_button" text="Cancel"/></button>
														<button id="submitButton" type="submit" class="btn btn-primary pull-right"><spring:message code="common.submit_button" text="Submit"/></button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</form:form>
							</div>
						</div>
					</c:when>
				</c:choose>
			</div>
		</div>
		
		<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>		
	
	</div>
</body>
</html>
