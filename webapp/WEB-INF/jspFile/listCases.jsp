<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="${request.contextPath}/head"></jsp:include>
<jsp:include page="${request.contextPath}/header"></jsp:include>
<jsp:include page="${request.contextPath}/menu"></jsp:include>

<% String roleList = (String)request.getAttribute("role_list"); %>
<% String roleDelete = (String)request.getAttribute("role_delete"); %>

<script type="text/javascript">
var app = angular.module('campaign', ['angularUtils.directives.dirPagination','oitozero.ngSweetAlert']);
var self = this;
app.controller('campController',['SweetAlert','$scope','$http',function(SweetAlert, $scope, $http){
	$scope.listCase= function(){
		$http.get("${pageContext.request.contextPath}/case/list").success(function(response){
				$scope.cases = response.DATA;
			});
		} ;

	
	
	
	$scope.sort = function(keyname){
	    $scope.sortKey = keyname;   //set the sortKey to the param passed
	    $scope.reverse = !$scope.reverse; //if true make it false and vice versa
	};
	
	$scope.deleteCon = function(oppID){
		SweetAlert.swal({
            title: "Are you sure?", //Bold text
            text: "This Contact will not be able to recover!", //light text
            type: "warning", //type -- adds appropiriate icon
            showCancelButton: true, // displays cancel btton
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Yes, delete!",
            closeOnConfirm: false, //do not close popup after click on confirm, usefull when you want to display a subsequent popup
            closeOnCancel: false
        }, 
        function(isConfirm){ //Function that triggers on user action.
          
	            var str = '<%=roleDelete%>';
	            if(isConfirm){

					if(str == "YES"){
						 $http.delete("${pageContext.request.contextPath}/case/remove/"+oppID)
				            .success(function(){
				            		SweetAlert.swal({
						            		title:"Deleted",
						            		text:"Case have been deleted!",
						            		type:"success",  
						            		timer: 2000,   
						            		showConfirmButton: false
				            		});
				            		$scope.listCase();
					      });
					}else{
						SweetAlert.swal({
			                title:"Cancelled",
			                text:"You don't have permission delete!",
			                type:"error",
			                timer:2000,
			                showConfirmButton: false});
					}      	           
            } else {
                SweetAlert.swal({
	                title:"Cancelled",
	                text:"This Case is safe!",
	                type:"error",
	                timer:2000,
	                showConfirmButton: false});
            }
        });
	};
	
}]);

//alert($.session.get("parentID"));

</script>

<div class="content-wrapper" ng-app="campaign" ng-controller="campController">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Cases</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i>Cases</a></li>
		</ol>
	</section>

	<section class="content">

		<!-- Default box -->
		
		<div class="box box-danger">
			<div class="box-header with-border">
				<h3 class="box-title">&nbsp;</h3>
				<div class="box-tools pull-right">
					<button class="btn btn-box-tool" data-widget="collapse"
						data-toggle="tooltip" title="Collapse">
						<i class="fa fa-minus"></i>
					</button>
					<button class="btn btn-box-tool" data-widget="remove"
						data-toggle="tooltip" title="Remove">
						<i class="fa fa-times"></i>
					</button>
				</div>
				<div class="col-sm-12">
					<hr style="margin-bottom: 5px;margin-top: 8px;" />
				 </div> 
				<div style="background: #fff;margin-top: 15px;">
				 <div class="col-sm-12">
				 	<a href="${pageContext.request.contextPath}/create-case" class="btn btn-info btn-app" ><i class="fa fa-plus" aria-hidden="true"></i> Create</a>
				 	<a href="${pageContext.request.contextPath}/view-cases" class="btn btn-info btn-app" ><i class="fa fa-clone"	aria-hidden="true"></i> View</a>
				 </div>
				 
				  
				  <div class="col-sm-12">
					<hr style="margin-bottom: 0;margin-top: 0px;" />
				 </div> 
			</div>
			</div>
			
			<div class="box-body" style="background: url(${pageContext.request.contextPath}/resources/images/boxed-bg.jpg);padding:30px;">
				
			 
			<div class="clearfix"></div>

			<div class="panel panel-default">
  				<div class="panel-body">
  				
				 <div class="col-sm-4">
				  <form class="form-inline">
				        <div class="form-group" style="padding-top: 10px;">
				            <label >Search :</label>
				            <input type="text" ng-model="search" class="form-control" placeholder="Search">
				        </div>
				    </form>
				    <br/>
				  </div>
				  <div class="clearfix"></div>
			<div class="tablecontainer table-responsive" data-ng-init="listCase()" > 
				<%
				   if(roleList.equals("YES")){
				%>
				<table class="table table-hover" >
						<tr>
							<th style="cursor: pointer;" ng-click="sort('caseId')">Case ID
								<span class="glyphicon sort-icon" ng-show="sortKey=='caseId'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('subject')">Subject
								<span class="glyphicon sort-icon" ng-show="sortKey=='subject'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('statusName')">Status
								<span class="glyphicon sort-icon" ng-show="sortKey=='statusName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('caseTypeName')">Type 
								<span class="glyphicon sort-icon" ng-show="sortKey=='caseTypeName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('priorityName')">priority 
								<span class="glyphicon sort-icon" ng-show="sortKey=='priorityName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>
							<th style="cursor: pointer;" ng-click="sort('custName')">Customer 
								<span class="glyphicon sort-icon" ng-show="sortKey=='custName'" ng-class="{'glyphicon-chevron-up':reverse,'glyphicon-chevron-down':!reverse}">
							</th>				
							<th>Action</th>
						</tr>

						<tr dir-paginate="cc in cases |orderBy:sortKey:reverse |filter:search |itemsPerPage:5">
							<td>{{cc.caseId}}</td>
							<td>{{cc.subject}}</td>
							<td>{{cc.statusName}}</td>
							<td>{{cc.caseTypeName}}</td>
							<td>{{cc.priorityName}}</td>
							<td>{{cc.custName}} </td>	
							<td>
								<a href="${pageContext.request.contextPath}/update-case/{{cc.caseId}}" class="btn btn-success custom-width"><i class="fa fa-pencil" aria-hidden="true"></i> Edit</a>
								<button type="button" ng-click="deleteCon(cc.caseId)" class="btn btn-danger custom-width"><i class="fa fa-times" aria-hidden="true"></i> Delete</button>
							</td>
						</tr>
				
				</table>
				<dir-pagination-controls
			       max-size="5"
			       direction-links="true"
			       boundary-links="true" >
			    </dir-pagination-controls>
			    <%	   
				   }else{
					   
				%>
					<div class="alert alert-warning" role="alert"><i class="glyphicon glyphicon-cog"></i> You don't have permission list data</div>
				<%
				   }
				
				%>  
			    
			    
			</div>	
				

			  </div>
		</div>
			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				
			</div>
			<!-- /.box-footer-->
		</div>
		
		<!-- /.box -->


	</section>
	<!-- /.content -->


</div>

<!-- /.content-wrapper -->



<!-- /.content-wrapper -->





<jsp:include page="${request.contextPath}/footer"></jsp:include>

