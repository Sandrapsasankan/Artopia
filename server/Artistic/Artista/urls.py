from django.urls import path
from Artista import views

urlpatterns = [
    path("",views.login_page,name="login_page" ),
    path("admin_login",views.admin_login,name="admin_login" ),
    path("dashboard",views.dashboard,name="dashboard"),
    path("managecustomer",views.managecustomer,name="managecustomer"),
    path("manageartist",views.manageartist,name="manageartist"),
    path("managedelivery",views.managedelivery,name="managedelivery"),
    path("Addjob",views.Addjob,name="Addjob"),
    path("Addcategory",views.Addcategory,name="Addcategory"),
    path("Editjob",views.Editjob,name="Editjob"),
    path("Editcategory",views.Editcategory,name="Editcategory"),
    path("viewjob",views.viewjob,name="viewjob"),
    path("Viewcategory",views.Viewcategory,name="Viewcategory"),
    path("managevideo",views.managevideo,name="managevideo"),
    path("viewproduct",views.viewproduct,name="viewproduct"),
    path("viewfeedback",views.viewfeedback,name="viewfeedback"),
    
    path("adminAddjob",views.adminAddjob,name="adminAddjob"),
    path("admin_edit_job/<int:id>",views.admin_edit_job,name="admin_edit_job"),
    path("jobformupdate/<int:id>",views.jobformupdate,name="jobformupdate"),
    path("admin_delete_job/<int:id>",views.admin_delete_job,name="admin_delete_job"),

    path("adminAddcategory",views.adminAddcategory,name="adminAddcategory"),
    path("admin_edit_category/<int:id>",views.admin_edit_category,name="admin_edit_category"),
    path("categoryformupdate/<int:id>",views.categoryformupdate,name="categoryformupdate"),
    path("admin_delete_category/<int:id>",views.admin_delete_category,name="admin_delete_category"),


    path("adminapproveuser",views.adminapproveuser,name="adminapproveuser"),
    path("admin_delete_customer/<int:id>",views.admin_delete_customer,name="admin_delete_customer"),
    path("admin_user_approve/<int:id>",views.admin_user_approve,name="admin_user_approve"),

    path("adminapproveartist",views.adminapproveartist,name="adminapproveartist"),
    path("admin_delete_artist/<int:id>",views.admin_delete_artist,name="admin_delete_artist"),
    path("admin_artist_approve/<int:id>",views.admin_artist_approve,name="admin_artist_approve"),

    

]