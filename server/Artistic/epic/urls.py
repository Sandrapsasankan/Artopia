from django.urls import path
from epic import views

urlpatterns = [

   

    path("user_login",views.LoginUserAPIView.as_view(),name="user_login" ),


    path("add_video",views.LearningSerializeraAPIView.as_view(),name="add_video" ),
    path("video_all_view",views.Get_LearningAPIView.as_view(),name="video_all_view" ),
    path("video_single_view/<int:id>",views.SingleLearningAPIView.as_view(),name="video_single_view" ),

    
    path("user_register",views.UserRegisterSerializeraAPIView.as_view(),name="user_register" ),   
    path("user_all_view",views.Get_UserRegisterAPIView.as_view(),name="user_all_view" ),
    path("user_single_view/<int:id>",views.SingleUserAPIView.as_view(),name="user_single_view" ),
    path("user_singleprofile_view/<int:id>",views.SingleUserProfileAPIView.as_view(),name="user_singleprofile_view" ),
    path("user_update_view/<int:id>",views.Update_UserAPIView.as_view(),name="user_update_view" ),


    path("artist_register",views.ArtistRegisterSerializeraAPIView.as_view(),name="artist_register" ),
    path("artist_all_view",views.Get_ArtistRegisterAPIView.as_view(),name="artist_all_view" ),
    path("artist_single_view/<int:id>",views.SingleArtistAPIView.as_view(),name="artist_single_view" ),
    path("artist_singleprofile_view/<int:id>",views.SingleArtistProfileAPIView.as_view(),name="artist_singleprofile_view" ),
    path("artist_update_view/<int:id>",views.Update_ArtistAPIView.as_view(),name="artist_update_view" ),


    path("add_product",views.ProductSerializeraAPIView.as_view(),name="add_product" ),
    path("product_all_view",views.Get_ProductAPIView.as_view(),name="product_all_view" ),
    path("product_single_view/<int:id>",views.SingleProductAPIView.as_view(),name="product_single_view" ),
    path("product_update_view/<int:id>",views.Update_ProductAPIView.as_view(),name="product_update_view" ),
    path("delete_product/<int:id>",views.Delete_ProductAPIView.as_view(),name="delete_product" ),

    path("allinone_product/<int:id>",views.ViewProductInSinglecategoryAPIView.as_view(),name="allinone_product" ),

    path("add_event",views.EventSerializeraAPIView.as_view(),name="add_event" ),
    path("event_all_view",views.Get_EventAPIView.as_view(),name="event_all_view" ),
    path("event_single_view/<int:id>",views.SingleEventAPIView.as_view(),name="event_single_view" ),
    path("event_update_view/<int:id>",views.Update_EventAPIView.as_view(),name="event_update_view" ),
    path("delete_event/<int:id>",views.Delete_EventAPIView.as_view(),name="delete_event" ),


    path("add_complaint",views.ComplaintSerializerAPIview.as_view(),name="add_complaint" ),    
    path("complaint_all_view",views.Get_ComplaintSerializerAPIview.as_view(),name="complaint_all_view" ),
    path("complaint_single_view/<int:id>",views.SingleComplaintAPIView.as_view(),name="complaint_single_view" ),
    path("complaint_update/<int:id>",views.UpdateComplaintAPIView.as_view(),name="complaint_update" ),
    path("complaint_reply/<int:users>/<int:artists>",views.SingleReplyComplaintAPIView.as_view(),name="complaint_reply" ),
   
    path("add_chat",views.ChatSerializerAPIview.as_view(),name="add_chat" ),    
    path("chat_all_view",views.Get_ChatSerializerAPIview.as_view(),name="chat_all_view" ),
    path("chat_single_view/<int:id>",views.SingleChatAPIView.as_view(),name="chat_single_view" ),
    path("chat_update/<int:id>",views.UpdateChatAPIView.as_view(),name="chat_update" ),
    path("reply/<int:users>/<int:artists>",views.SingleReplyChatAPIView.as_view(),name="reply" ),


    path("add_feedback",views.FeedbackSerializerAPIView.as_view(),name="add_feedback" ),    
    path("feedback_all_view",views.Get_FeedbackAPIView.as_view(),name="feedback_all_view" ),
    path("feedback_single_view/<int:id>",views.SingleFeedbackAPIView.as_view(),name="feedback_single_view" ),




    path("category_all_view",views.Get_CategoryAPIView.as_view(),name="category_all_view" ),
    path("add_category",views.CategorySerializeraAPIView.as_view(),name="add_category" ),

    path("add_data",views.JobapplySerializeraAPIView.as_view(),name="add_data" ),
    path("job_all_view",views.Get_JobAPIView.as_view(),name="job_all_view" ),
    path("job_single_view/<int:id>",views.SingleJobAPIView.as_view(),name="job_single_view" ),


    path("add_cart",views.CartSerializerAPIView.as_view(),name="add_cart" ),
    path("cart_single_view/<int:id>",views.SingleCartAPIView.as_view(),name="cart_single_view" ),
    path("cart_increment/<int:id>",views.CartIncrementQuantityAPIView.as_view(),name="cart_increment" ),
    path("cart_decrement/<int:id>",views.CartDecrementQuantityAPIView.as_view(),name="cart_decrement" ),
    path("delete_cart/<int:id>",views.Delete_CartAPIView.as_view(),name="delete_cart" ),

    path("order",views.OrderAPIView.as_view(),name="order" ),
    path("order_all_view",views.Get_OrderAPIView.as_view(),name="order_all_view" ),
    path("order_single_view/<int:id>",views.SingleOrderAPIView.as_view(),name="order_single_view" ),
    path("order_Asingle_view/<int:id>",views.SingleOrderARTISTAPIView.as_view(),name="order_Asingle_view" ),
    path("AllPrice/<int:id>",views.AllPriceAPIView.as_view(),name="AllPrice" ),


    path("payment",views.PaymentSerializerAPIView.as_view(),name="payment" ),
    path("payment_all_view",views.Get_PaymentAPIView.as_view(),name="payment_all_view" ),
    path("payment_Asingle_view/<int:id>",views.SinglePaymentARTISTAPIView.as_view(),name="payment_Asingle_view" ),


    path("order_status/<int:id>",views.Order_statusAPIView.as_view(),name="order_status" ),



    
]