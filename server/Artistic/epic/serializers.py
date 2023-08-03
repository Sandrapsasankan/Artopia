from rest_framework import serializers
from Artista.models import login,user,artist, category,product,event,job,cart,order,payment,learning,complaint,feedback,chat,jobapply

class LoginUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = login
        fields = '__all__'

class UserRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = user
        fields = '__all__'
    def Create(self, validated_data):
        return user.objects.Create(**validated_data)

class ArtistRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = artist
        fields = '__all__'
    def Create(self, validated_data):
        return artist.objects.Create(**validated_data)


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = category
        fields = '__all__'
    def Create(self, validated_data):
        return category.objects.Create(**validated_data)

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = product
        fields = '__all__'
    def Create(self, validated_data):
        return product.objects.Create(**validated_data)

class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = event
        fields = '__all__'
    def Create(self, validated_data):
        return event.objects.Create(**validated_data)

class CartSerializer(serializers.ModelSerializer):
    class Meta:
        model = cart
        fields = '__all__'
    def Create(self, validated_data):
        return cart.objects.Create(**validated_data)

class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = order
        fields = '__all__'
    def Create(self, validated_data):
        return order.objects.Create(**validated_data)

class JobSerializer(serializers.ModelSerializer):
    class Meta:
        model = job
        fields = '__all__'
    
class ComplaintSerializer(serializers.ModelSerializer):
    class Meta:
        model = complaint
        fields = '__all__'
    def Create(self, validated_data):
        return complaint.objects.Create(**validated_data)

class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = feedback
        fields = '__all__'
    def Create(self, validated_data):
        return feedback.objects.Create(**validated_data)

# 
class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = payment
        fields = '__all__'
    def Create(self, validated_data):
        return payment.objects.Create(**validated_data)

#


class LearningSerializer(serializers.ModelSerializer):
    class Meta:
        model = learning
        fields = '__all__'
    def Create(self, validated_data):
        return learning.objects.Create(**validated_data)


class ChatSerializer(serializers.ModelSerializer):
    class Meta:
        model = chat
        fields = '__all__'
    def Create(self, validated_data):
        return chat.objects.Create(**validated_data)

class JobapplySerializer(serializers.ModelSerializer):
    class Meta:
        model = jobapply
        fields = '__all__'
    def Create(self, validated_data):
        return jobapply.objects.Create(**validated_data)

# class DeliverySerializer(serializers.ModelSerializer):
#     class Meta:
#         model = delivery
#         fields = '__all__'
#     def Create(self, validated_data):
#         return delivery.objects.Create(**validated_data)





