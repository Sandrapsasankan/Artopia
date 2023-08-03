from django.contrib import admin
from .models import job ,user,login,artist,category,product,event,cart,order,payment,learning,complaint,feedback,chat,jobapply

# Register your models here.
admin.site.register(job)
admin.site.register(user)
admin.site.register(login)
admin.site.register(artist)
admin.site.register(category)
admin.site.register(product)
admin.site.register(event)
admin.site.register(cart)
admin.site.register(order)
admin.site.register(payment)
admin.site.register(learning)
admin.site.register(complaint)
admin.site.register(feedback)
admin.site.register(chat)
admin.site.register(jobapply)