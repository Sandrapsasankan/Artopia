from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from django.conf import settings
from django.db.models import Sum
from django.db.models import Q
from rest_framework.generics import GenericAPIView
from Artista.models import login,user,artist,category,product,event,job,cart,order,payment,learning,complaint,feedback,chat,jobapply
from epic.serializers import LoginUserSerializer, UserRegisterSerializer,ChatSerializer,JobapplySerializer, ComplaintSerializer, JobSerializer, FeedbackSerializer, PaymentSerializer, LearningSerializer, ArtistRegisterSerializer,OrderSerializer, CartSerializer, CategorySerializer,ProductSerializer,EventSerializer
# Create your views here.

class UserRegisterSerializeraAPIView(GenericAPIView):
    serializer_class = UserRegisterSerializer
    serializer_class_login = LoginUserSerializer

    def post(self, request):

        login_id=''
        name = request.data.get('name')
        address = request.data.get('address')
        place = request.data.get('place')
        phone_number = request.data.get('phone_number')
        email = request.data.get('email')
        username = request.data.get('username')
        password = request.data.get('password')
        role = 'user'
        userstatus = '0'

        if(login.objects.filter(username=username)):
            return Response({'message':'Duplicate Username Found'}, status = status.HTTP_400_BAD_REQUEST)
        else:
            serializer_login = self.serializer_class_login(data = {'username':username,'password':password,'role':role})

        if serializer_login.is_valid():
            log = serializer_login.save()
            login_id = log.id
            print(login_id)
        serializer = self.serializer_class(data= {'name':name,'address':address,'place':place,'phone_number':phone_number,'email':email,'login_id':login_id,'role':role,'userstatus':userstatus})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data,'message':'User registered successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)

class LoginUserAPIView(GenericAPIView):
    serializer_class = LoginUserSerializer
    def post(self,request):
        username = request.data.get('username')
        password = request.data.get('password')
        logreg = login.objects.filter(username=username,password=password)
        if(logreg.count()>0):
            read_serlializer = LoginUserSerializer(logreg,many=True)
            for i in read_serlializer.data:
                id = i ['id']
                print(id)
                role = i['role']
                regdata=user.objects.all().filter(login_id=id).values()
                print(regdata)
                for i in regdata:
                    u_id = i['id']
                    l_status=i['userstatus']
                    f_name=i['name']
                    print(u_id)
                regdata=artist.objects.all().filter(login_id=id).values()
                print(regdata)
                for i in regdata:
                    u_id = i['id']
                    l_status=i['artiststatus']
                    f_name=i['name']
                    print(u_id)
            return Response({'data':{'login_id':id,'username':username,'password':password,'role':role,'user_id':u_id,'l_status':l_status,'name':f_name},'success':True, 'message':'Logged in successfully'}, status=status.HTTP_200_OK)         
        else:
            return Response({'data':'username or password is invalid','success':False,},status=status.HTTP_400_BAD_REQUEST)


class ArtistRegisterSerializeraAPIView(GenericAPIView):
    serializer_class = ArtistRegisterSerializer
    serializer_class_login = LoginUserSerializer

    def post(self, request):

        login_id=''
        name = request.data.get('name')
        address = request.data.get('address')
        place = request.data.get('place')
        phone_number = request.data.get('phone_number')
        email = request.data.get('email')
        username = request.data.get('username')
        password = request.data.get('password')
        role = 'artist'
        artiststatus = '0'

        if(login.objects.filter(username=username)):
            return Response({'message':'Duplicate Username Found'}, status = status.HTTP_400_BAD_REQUEST)
        else:
            serializer_login = self.serializer_class_login(data = {'username':username,'password':password,'role':role})

        if serializer_login.is_valid():
            log = serializer_login.save()
            login_id = log.id
            print(login_id)
        serializer = self.serializer_class(data= {'name':name,'address':address,'place':place,'phone_number':phone_number,'email':email,'login_id':login_id,'role':role,'artiststatus':artiststatus})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data,'message':'User registered successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)

class LearningSerializeraAPIView(GenericAPIView):
    serializer_class = LearningSerializer

    def post(self, request):

        name = request.data.get('name')
        description = request.data.get('description')
        amount = request.data.get('amount')
        category = request.data.get('category')
        video = request.data.get('video')
        artist = request.data.get('artist')
        learning_status = '0'
        
        serializer = self.serializer_class(data= {'name':name, 'description':description, 'category':category, 'video':video, 'artist':artist, 'learning_status':learning_status})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data,'message':'Video Added successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)

class Get_LearningAPIView(GenericAPIView):
    serializer_class = LearningSerializer
    def get(self,request):
        queryset = learning.objects.all()
        if (queryset.count()>0):
            serializer = LearningSerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':' Video data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)

class SingleLearningAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = learning.objects.get(pk=id)
        serializer =LearningSerializer(queryset)
        return Response({'data' : serializer.data, 'message':'single user data','success':True},status=status.HTTP_200_OK)


class CategorySerializeraAPIView(GenericAPIView):
    serializer_class = CategorySerializer

    def post(self, request):

        
        name = request.data.get('name')
        image = request.data.get('image')
        category_status = '0'
        
        serializer = self.serializer_class(data= {'name':name,'image':image,'category_status':category_status})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data,'message':'Category Added successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)

class Get_CategoryAPIView(GenericAPIView):
    serializer_class = CategorySerializer
    def get(self,request):
        queryset = category.objects.all()
        if (queryset.count()>0):
            serializer = CategorySerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':'Category all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)

class SingleCategoryAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = category.objects.get(pk=id)
        serializer =CategorySerializer(queryset)
        return Response({'data' : serializer.data, 'message':'single user data','success':True},status=status.HTTP_200_OK)



class JobapplySerializeraAPIView(GenericAPIView):
    serializer_class = JobapplySerializer

    def post(self, request):

        name = request.data.get('name')
        address = request.data.get('address')
        email = request.data.get('email')
        phn_no = request.data.get('phn_no')
        qualification = request.data.get('qualification')
        experience = request.data.get('experience')
        image = request.data.get('image')
        user = request.data.get('user')
       
        
        serializer = self.serializer_class(data= {'name':name, 'address':address, 'email':email, 'phn_no':phn_no, 'qualification':qualification, 'experience':experience, 'image':image, 'user':user})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data,'message':'Job apply successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)



class ProductSerializeraAPIView(GenericAPIView):
    serializer_class = ProductSerializer

    def post(self, request):

        name = request.data.get('name')
        description = request.data.get('description')
        amount = request.data.get('amount')
        category = request.data.get('category')
        dimension = request.data.get('dimension')
        colour = request.data.get('colour')
        image = request.data.get('image')
        artist = request.data.get('artist')
        expday = request.data.get('expday')
        product_status = '0'
        
        serializer = self.serializer_class(data= {'name':name, 'description':description,'expday':expday, 'amount':amount, 'category':category, 'dimension':dimension, 'colour':colour, 'image':image, 'artist':artist, 'product_status':product_status})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data,'message':'Product Added successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)

class Get_ProductAPIView(GenericAPIView):
    serializer_class = ProductSerializer
    def get(self,request):
        queryset = product.objects.all()
        if (queryset.count()>0):
            serializer = ProductSerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':'Product all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)

class SingleProductAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = product.objects.get(pk=id)
        serializer =ProductSerializer(queryset)
        return Response({'data' : serializer.data, 'message':'single user data','success':True},status=status.HTTP_200_OK)

class Update_ProductAPIView(GenericAPIView):
    serializer_class = ProductSerializer
    def put(self,request,id):
        queryset=product.objects.get(pk=id)
        print(queryset)
        serializer=ProductSerializer(instance=queryset,data=request.data,partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Update data Successfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something went wrong','success':False},status=status.HTTP_400_BAD_REQUEST)

class ViewProductInSinglecategoryAPIView(GenericAPIView):
    def get(self,request,id):
        data=category.objects.all().filter(pk=id).values()
        for i in data:
            c_id=i['id']
        queryset=product.objects.all().filter(category=c_id).values()
        serializer_data=list(queryset)
        print(serializer_data)
        for obj in serializer_data:
            obj['image']=settings.MEDIA_URL + str(obj['image'])
        return Response({'data':serializer_data,'message':'all products in Single category data','success':True},status=status.HTTP_200_OK)

    

class Delete_ProductAPIView(GenericAPIView):
    def delete(self,reuest,id):
        delmember = product.objects.get(pk=id)
        delmember.delete()
        return Response({'message':'Product Deleted sucessfully','sucess':True},status=status.HTTP_200_OK)           

class EventSerializeraAPIView(GenericAPIView):
    serializer_class = EventSerializer

    def post(self, request):

        name = request.data.get('name')
        description = request.data.get('description')
        place = request.data.get('place')
        date = request.data.get('date')
        time = request.data.get('time')
        image = request.data.get('image')
        artist = request.data.get('artist')
        event_status = '0'
        
        serializer = self.serializer_class(data= {'name':name, 'description':description, 'place':place, 'date':date, 'time':time,'image':image, 'artist':artist, 'event_status':event_status})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data,'message':'Event Added successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status=status.HTTP_400_BAD_REQUEST)

class Get_EventAPIView(GenericAPIView):
    serializer_class = EventSerializer
    def get(self,request):
        queryset = event.objects.all()
        if (queryset.count()>0):
            serializer = EventSerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':' Event data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)

class SingleEventAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = event.objects.get(pk=id)
        serializer =EventSerializer(queryset)
        return Response({'data' : serializer.data, 'message':'single user data','success':True},status=status.HTTP_200_OK)

class Update_EventAPIView(GenericAPIView):
    serializer_class = EventSerializer
    def put(self,request,id):
        queryset=event.objects.get(pk=id)
        print(queryset)
        serializer=EventSerializer(instance=queryset,data=request.data,partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Update data Successfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something went wrong','success':False},status=status.HTTP_400_BAD_REQUEST)


class Delete_EventAPIView(GenericAPIView):
    def delete(self,reuest,id):
        delmember = event.objects.get(pk=id)
        delmember.delete()
        return Response({'message':'Event Deleted sucessfully','sucess':True},status=status.HTTP_200_OK)           


class Get_UserRegisterAPIView(GenericAPIView):
    serializer_class = UserRegisterSerializer
    def get(self,request):
        queryset = user.objects.all()
        if (queryset.count()>0):
            serializer = UserRegisterSerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':'User all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)

class SingleUserAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = user.objects.get(pk=id)
        serializer =UserRegisterSerializer(queryset)
        return Response({'data' : serializer.data, 'message':'single user data','success':True},status=status.HTTP_200_OK)


class SingleUserProfileAPIView(GenericAPIView):
    def get(self,request,id):
        queryset=user.objects.get(pk=id)
        serializer=UserRegisterSerializer(queryset)
        return Response({'data':serializer.data,'message':'Single user data','success':True},status=status.HTTP_200_OK)

class Get_ArtistRegisterAPIView(GenericAPIView):
    serializer_class = ArtistRegisterSerializer
    def get(self,request):
        queryset = artist.objects.all()
        if (queryset.count()>0):
            serializer = ArtistRegisterSerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':'Artist all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)

class Update_UserAPIView(GenericAPIView):
    serializer_class = UserRegisterSerializer
    def put(self,request,id):
        queryset=user.objects.get(pk=id)
        print(queryset)
        serializer=UserRegisterSerializer(instance=queryset,data=request.data,partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Update data Successfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something went wrong','success':False},status=status.HTTP_400_BAD_REQUEST)



class SingleArtistAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = artist.objects.get(pk=id)
        serializer =ArtistRegisterSerializer(queryset)
        return Response({'data' : serializer.data, 'message':'single user data','success':True},status=status.HTTP_200_OK)


class SingleArtistProfileAPIView(GenericAPIView):
    def get(self,request,id):
        queryset=artist.objects.get(pk=id)
        serializer=ArtistRegisterSerializer(queryset)
        return Response({'data':serializer.data,'message':'Single user data','success':True},status=status.HTTP_200_OK)
    
class Update_ArtistAPIView(GenericAPIView):
    serializer_class = ArtistRegisterSerializer
    def put(self,request,id):
        queryset=artist.objects.get(pk=id)
        print(queryset)
        serializer=ArtistRegisterSerializer(instance=queryset,data=request.data,partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Update data Successfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something went wrong','success':False},status=status.HTTP_400_BAD_REQUEST)

class Get_JobAPIView(GenericAPIView):
    serializer_class = JobSerializer
    def get(self,request):
        queryset = job.objects.all()
        if (queryset.count()>0):
            serializer = JobSerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':' Job data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)

class SingleJobAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = job.objects.get(pk=id)
        serializer =JobSerializer(queryset)
        return Response({'data' : serializer.data, 'message':'single user data','success':True},status=status.HTTP_200_OK)
            

class CartSerializerAPIView(GenericAPIView):
    serializer_class = CartSerializer

    def post(self, request):

        total_price=""
        image=""
        category=""
        p_status=""
        prices=""


        user = request.data.get('user')
        artist = request.data.get('artist')
        products = request.data.get('product')
        print(products)
        quantity = request.data.get('quantity')
        quantity=int(quantity)
        cart_status="0"
        
        carts = cart.objects.filter(user=user, product=products,artist=artist)
        if carts.exists():
            return Response({'message':'Item is already in cart','success':False}, status = status.HTTP_400_BAD_REQUEST)

        else:
            data=product.objects.all().filter(id=products).values()
            for i in data:
                print(i)
                prices=i['amount']
                p_status=i['product_status']
                cat=i['category_id']
                name=i['name']
                image=i['image']
                expday=i['expday']
                print(cat)
                price=int(prices)
                print(price)
                total_price=price*quantity
                print(total_price)
                tp=str(total_price)
            producto = product.objects.get(id=products)
            image = producto.image
            print(image)



            serializer = self.serializer_class(data= {'user':user,'artist':artist,'expday':expday, 'image':image,'p_name':name, 'product':products,'quantity':quantity,'total_price':tp, 'cart_status':cart_status,'category':cat})
            print(serializer)
            if serializer.is_valid():
                print("hi")
                serializer.save()
                return Response({'data':serializer.data,'message':'Cart Added successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Invalid','success':False},status=status.HTTP_400_BAD_REQUEST)

class SingleCartAPIView(GenericAPIView):
    def get(self, request, id):

        u_id=""
        qset =user.objects.all().filter(pk=id).values()
        for i in qset:
            u_id=i['id']


        data = cart.objects.filter(user=u_id).values()
        serialized_data=list(data)
        print(serialized_data)
        for obj in serialized_data:
            obj['image'] =settings.MEDIA_URL+str(obj['image'])   
        return Response({'data' : serialized_data, 'message':'single product data','success':True},status=status.HTTP_200_OK)  


class CartIncrementQuantityAPIView(GenericAPIView):
    def put(self, request, id):
        cart_item = cart.objects.get(pk=id)


        qnty=cart_item.quantity
        qty=int(qnty)

        cart_item.quantity=qty + 1

        q=cart_item.quantity
        qn=int(q)

        pr=cart_item.product.amount
        price=int(pr)


        tp=price*qn
        cart_item.total_price=tp


        cart_item.save()
        serialized_data = CartSerializer(cart_item,context={'request':request}).data
        # serialized_data['image']=str(serialized_data['image']).split('http://localhost:8000')[1]
        base_url=request.build_absolute_uri('/')[:-1]
        serialized_data['image']=str(serialized_data['image']).replace(base_url,'')
        return Response({'data' : serialized_data, 'message':'cart item quantity updated','success':True},status=status.HTTP_200_OK)  

class CartDecrementQuantityAPIView(GenericAPIView):
    def put(self, request, id):
        cart_item = cart.objects.get(pk=id)


        qny=cart_item.quantity
        qant=int(qny)
        
        if qant > 1:
            qnty=cart_item.quantity
            qty=int(qnty)
            cart_item.quantity=qty - 1

            q=cart_item.quantity
            qn=int(q)

            pr=cart_item.product.amount
            price=int(pr)


            tp=price*qn
            cart_item.total_price=tp


            cart_item.save()
            serialized_data = CartSerializer(cart_item,context={'request':request}).data
            base_url=request.build_absolute_uri('/')[:-1]
            serialized_data['image']=str(serialized_data['image']).replace(base_url,'')

            return Response({'data' : serialized_data, 'message':'cart item quantity updated','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'message':'Quantity cannot be less than 1','success':False},status=status.HTTP_400_BAD_REQUEST)  

class Delete_CartAPIView(GenericAPIView):
    def delete(self, request, id):
        delmember = cart.objects.get(pk=id)
        delmember.delete()
        return Response({'message':'Cart deleted successfully','success':True}, status = status.HTTP_200_OK)

class OrderAPIView(GenericAPIView):
    serializer_class=OrderSerializer
    def post(self,request):
        user=request.data.get('user')
        artist=request.data.get('artist')
        date=request.data.get('date')
        carts=cart.objects.filter(user=user,artist=artist,cart_status=0)
        if not carts.exists():
            return Response({'message':'No item in cart to place order','success':False},status=status.HTTP_400_BAD_REQUEST)

        # tot=carts.aggregate(total=sum('total price'))['total']
        # total=str(tot)
        # print("=============total    ",total)
        order_data=[]
        for i in carts:
            order_data.append({
            'user' : user,
            'artist' : artist,
            'product' : i.product.id,
            'product_name' :i.p_name,
            'total_price' : i.total_price,
            'quantity' :i.quantity,
            'image' : i.image,
            'category' : i.category,
            'expday' :i.expday,
            'order_status' : "0",
             
                })
            print("order data==========",order_data)
            i.cart_status="1"
            i.save()

        serializer = self.serializer_class(data= order_data, many=True)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Order placed successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Invalid','success':False},status=status.HTTP_400_BAD_REQUEST)

class Get_OrderAPIView(GenericAPIView):
    serializer_class = OrderSerializer
    def get(self,request):
        queryset = order.objects.all()
        if (queryset.count()>0):
            serializer = OrderSerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':'Order all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)

class SingleOrderAPIView(GenericAPIView):
    def get(self, request, id):

        qset =user.objects.all().filter(pk=id).values()
        for i in qset:
            u_id=i['id']

        data = order.objects.filter(user=u_id).values()
        serialized_data=list(data)
        print(serialized_data)
        for obj in serialized_data:
            obj['image'] =settings.MEDIA_URL+str(obj['image'])   
        return Response({'data' : serialized_data, 'message':'single order data','success':True},status=status.HTTP_200_OK)  

class SingleOrderARTISTAPIView(GenericAPIView):
    def get(self, request, id):

        qset =artist.objects.all().filter(pk=id).values()
        for i in qset:
            a_id=i['id']

        data = order.objects.filter(artist=a_id).values()
        serialized_data=list(data)
        print(serialized_data)
        for obj in serialized_data:
            obj['image'] =settings.MEDIA_URL+str(obj['image'])   
        return Response({'data' : serialized_data, 'message':'single order data','success':True},status=status.HTTP_200_OK)  


class AllPriceAPIView(GenericAPIView):

    def get(self,request,id):
        carts=cart.objects.filter(user=id,cart_status=1)
        print(carts)
        tot=carts.aggregate(total=Sum('total_price'))['total']
        Total_prices=str(tot)
        print(tot)
        price_status="0"
        return Response({'data':{'total_price':Total_prices},'message':'get order price successfully','success':True},status=status.HTTP_201_CREATED)


class PaymentSerializerAPIView(GenericAPIView):
    serializer_class=PaymentSerializer
    def post(self,request):
        users=request.data.get('user')
        date=request.data.get('date')
        artists=request.data.get('artist')
        amount=request.data.get('amount')
        payment_status="0"
        data=user.objects.all().filter(id=users).values()
        for i in data:
            name=i['name']
        serializer=self.serializer_class(data={'user':users,'artist':artists,'date':date,'amount':amount,'payment_status':payment_status,'name':name})
        print(serializer)
        if serializer.is_valid():
            print('hai')
            serializer.save()
            return Response({'data':serializer.data,'message':'Your payment done  Successfully','success':True},status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status = status.HTTP_400_BAD_REQUEST)


class Get_PaymentAPIView(GenericAPIView):
    serializer_class = PaymentSerializer
    def get(self,request):
        queryset = payment.objects.all()
        if(queryset.count()>0):
            serializer =PaymentSerializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'Payments of all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)  

class SinglePaymentARTISTAPIView(GenericAPIView):
    def get(self, request, id):

        qset =artist.objects.all().filter(pk=id).values()
        for i in qset:
            a_id=i['id']

        data = payment.objects.filter(artist=a_id).values()
        serialized_data=list(data)
        print(serialized_data)
        return Response({'data' : serialized_data, 'message':'single payment data','success':True},status=status.HTTP_200_OK)  


class ComplaintSerializerAPIview(GenericAPIView):
    serializer_class = ComplaintSerializer

    def post(self,request):


        users=request.data.get('user')
        artists=request.data.get('artist')
        date=request.data.get('date')
        complaint=request.data.get('complaint')
        complaintstatus= "0"

        data=user.objects.all().filter(id=users).values()
        for i in data:
            uname=i["name"]
        
        data=artist.objects.all().filter(id=artists).values()
        for i in data:
            aname=i["name"]

        serializer = self.serializer_class(data={'user':users,'artist':artists,'a_name':aname,'u_name':uname,'date':date,'complaint':complaint,'complaintstatus':complaintstatus})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data,'message':'You Message is sended successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False}, status=status.HTTP_400_BAD_REQUEST)


class Get_ComplaintSerializerAPIview(GenericAPIView):
    serializer_class = ComplaintSerializer
    def get(self,request):
        queryset = complaint.objects.all()
        if(queryset.count()>0):
            serializer = ComplaintSerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':'complaint all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)


class SingleComplaintAPIView(GenericAPIView):
    def get(self,request,id):
        queryset = complaint.objects.all().filter(artist=id).values()
        return Response({'data':queryset,'message': 'single complaint data','success':True}, status=status.HTTP_200_OK)


class SingleReplyComplaintAPIView(GenericAPIView):
    def get(self,request,users,artists):
        alldata=complaint.objects.filter (Q(user=users) & Q(artist=artists)).values()
        print(alldata)
       
        return Response({'data':alldata,'message': 'single reply data','success':True}, status=status.HTTP_200_OK)


class UpdateComplaintAPIView(GenericAPIView):
    serializer_class = ComplaintSerializer
    def put(self,request,id):
        queryset = complaint.objects.get(pk=id)
        print(queryset)
        serializer = ComplaintSerializer(instance=queryset, data=request.data, partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Your Reply is sended succesfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'something Went Wrong','success':False},status=status.HTTP_400_BAD_REQUEST)


class FeedbackSerializerAPIView(GenericAPIView):
    serializer_class = FeedbackSerializer
  

    def post(self,request):

        
        feedback=request.data.get('feedback')
        date=request.data.get('date')
        users=request.data.get('user')
        feedback_status='0'
        data=user.objects.all().filter(id=users).values()
        for i in data:
            name=i["name"]
        serializer = self.serializer_class(data={'feedback':feedback, 'user':users,'name':name, 'date':date,'feedback_status':feedback_status})
        print(serializer)
        if serializer.is_valid():
            print('hai')
            serializer.save()
            return Response({'data':serializer.data,'message':'successfully','success':True},status=status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':"Failed",'success':False},status=status.HTTP_400_BAD_REQUEST) 

class Get_FeedbackAPIView(GenericAPIView):
    serializer_class = FeedbackSerializer
    def get(self,request):
        queryset = feedback.objects.all()
        if(queryset.count()>0):
            serializer =FeedbackSerializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'Feedbacks of all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)  

class SingleFeedbackAPIView(GenericAPIView):
    def get(self,request,id):
        queryset = feedback.objects.get(pk=id)
        serializer = FeedbackSerializer(queryset)
        return Response({'data':serializer.data,'message':'Feedback recieved','success':True},status=status.HTTP_200_OK)


class ChatSerializerAPIview(GenericAPIView):
    serializer_class = ChatSerializer

    def post(self,request):


        users=request.data.get('user')
        artists=request.data.get('artist')
        message = request.data.get('message')
        chatstatus= "0"

        data=user.objects.all().filter(id=users).values()
        for i in data:
            uname=i["name"]
        
        data=artist.objects.all().filter(id=artists).values()
        for i in data:
            aname=i["name"]

        serializer = self.serializer_class(data={'user':users,'artist':artists,'a_name':aname,'u_name':uname,'message':message,'chatstatus':chatstatus})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data,'message':'You Message is sended successfully','success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False}, status=status.HTTP_400_BAD_REQUEST)




class Get_ChatSerializerAPIview(GenericAPIView):
    serializer_class = ChatSerializer
    def get(self,request):
        queryset = chat.objects.all()
        if(queryset.count()>0):
            serializer = ChatSerializer(queryset,many=True)
            return Response({'data': serializer.data,'message':'chat all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)



class SingleChatAPIView(GenericAPIView):
    def get(self,request,id):
        queryset = chat.objects.all().filter(artist=id).values()
        return Response({'data':queryset,'message': 'single chat data','success':True}, status=status.HTTP_200_OK)





class SingleReplyChatAPIView(GenericAPIView):
    def get(self,request,users,artists):
        alldata=chat.objects.filter (Q(user=users) & Q(artist=artists)).values()
        print(alldata)
       
        return Response({'data':alldata,'message': 'single reply data','success':True}, status=status.HTTP_200_OK)


class UpdateChatAPIView(GenericAPIView):
    serializer_class = ChatSerializer
    def put(self,request,id):
        queryset = chat.objects.get(pk=id)
        print(queryset)
        serializer = ChatSerializer(instance=queryset, data=request.data, partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Your Reply is sended succesfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'something Went Wrong','success':False},status=status.HTTP_400_BAD_REQUEST)



class Order_statusAPIView(GenericAPIView):
    def post(self,request,id):
        serializer_class=OrderSerializer 
        user=order.objects.get(pk=id)
        user.order_status=1
        user.save()
        serializer=serializer_class(user)
        return Response({'data':serializer.data,'message':'approve order status','success':True},status=status.HTTP_200_OK)

