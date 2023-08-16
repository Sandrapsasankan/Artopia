from django.db import models

# # Create your models here.

class login(models.Model):
    username = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=100, unique=True)
    role = models.CharField(max_length=10)
    def __str__(self):
        return self.username

class user(models.Model):
    name = models.CharField(max_length=100)
    address = models.CharField(max_length=100)
    place = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=100)
    email = models.EmailField(max_length=100)
    login_id = models.OneToOneField(login, on_delete=models.CASCADE)
    role = models.CharField(max_length=20)
    userstatus = models.CharField(max_length=20)
    def __str__(self):
        return self.name

class artist(models.Model):
    name = models.CharField(max_length=100)
    address = models.CharField(max_length=100)
    place = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=100)
    email = models.EmailField(max_length=100)
    login_id = models.OneToOneField(login, on_delete=models.CASCADE)
    role = models.CharField(max_length=100)
    artiststatus = models.CharField(max_length=100)
    def __str__(self):
        return self.name

class job(models.Model):
    jobname = models.CharField(max_length=100)
    description = models.CharField(max_length=500)
    location = models.CharField(max_length=100)
    experience = models.CharField(max_length=100)
    qualification = models.CharField(max_length=100)
    salary = models.CharField(max_length=100)
    status=models.CharField(max_length=100)
    def __str__(self):
        return self.jobname

class category(models.Model):
    name = models.CharField(max_length=100)
    image = models.ImageField(upload_to='images')
    category_status = models.CharField(max_length=20)
    def __str__(self):
        return self.name

class product(models.Model):
    name = models.CharField(max_length=100)
    description = models.CharField(max_length=500)
    amount = models.CharField(max_length=100)
    expday = models.CharField(max_length=100)
    image = models.ImageField(upload_to='images')
    category = models.ForeignKey(category, on_delete=models.CASCADE)
    artist = models.ForeignKey(artist, on_delete=models.CASCADE)
    dimension = models.CharField(max_length=100)
    colour = models.CharField(max_length=100)
    product_status = models.CharField(max_length=20)
    def __str__(self):
        return self.name

class event(models.Model):
    name = models.CharField(max_length=100)
    description = models.CharField(max_length=500)
    place = models.CharField(max_length=100)
    date = models.DateField(max_length=100)
    time = models.CharField(max_length=100)
    image = models.ImageField(upload_to='images')
    artist = models.ForeignKey(artist, on_delete=models.CASCADE)
    event_status = models.CharField(max_length=100)
    def __str__(self):
        return self.name

class cart(models.Model):
    user = models.ForeignKey(user, on_delete=models.CASCADE)
    product = models.ForeignKey(product, on_delete=models.CASCADE)
    p_name = models.CharField(max_length=500)
    quantity = models.CharField(max_length=500)
    expday = models.CharField(max_length=100)
    total_price = models.CharField(max_length=500)
    artist = models.ForeignKey(artist, on_delete=models.CASCADE)
    cart_status = models.CharField(max_length=10)
    image = models.ImageField(upload_to='images')
    category = models.CharField(max_length=10)
    
class order(models.Model):
    product_name = models.CharField(max_length=500,blank=True, null=True)
    user = models.ForeignKey(user, on_delete=models.CASCADE)
    artist = models.ForeignKey(artist, on_delete=models.CASCADE)
    product = models.ForeignKey(product, on_delete=models.CASCADE)
    expday = models.CharField(max_length=100)
    quantity = models.CharField(max_length=500,blank=True, null=True)
    total_price = models.IntegerField()
    image = models.ImageField(upload_to='images',blank=True, null=True)
    category = models.CharField(max_length=500,blank=True, null=True)
    order_status = models.CharField(max_length=500,blank=True, null=True)
    
    
    def __str__(self):
        return self.product_name

class feedback(models.Model):
    feedback = models.CharField(max_length=20)
    date = models.CharField(max_length=20)
    name = models.CharField(max_length=20)
    user = models.ForeignKey(user, on_delete=models.CASCADE)
    def __str__(self):
        return self.feedback

class learning(models.Model):
    name = models.CharField(max_length=100)
    description = models.CharField(max_length=500)
    category = models.CharField(max_length=20)
    video = models.FileField(upload_to="video/")
    artist = models.ForeignKey(artist, on_delete=models.CASCADE)
    def __str__(self):
        return self.name


class chat(models.Model):
    message = models.CharField(max_length=500)
    u_name = models.CharField(max_length=500)
    a_name = models.CharField(max_length=500)
    reply = models.CharField(max_length=500,default="no reply")
    artist = models.ForeignKey(artist, on_delete=models.CASCADE)
    user = models.ForeignKey(user, on_delete=models.CASCADE)
    chatstatus = models.CharField(max_length=20)
    def __str__(self):
        return self.message




class complaint(models.Model):
    complaint = models.CharField(max_length=500)
    u_name = models.CharField(max_length=500)
    a_name = models.CharField(max_length=500)
    date = models.CharField(max_length=70)
    reply = models.CharField(max_length=500,default="no reply")
    artist = models.ForeignKey(artist, on_delete=models.CASCADE)
    user = models.ForeignKey(user, on_delete=models.CASCADE)
    complaintstatus = models.CharField(max_length=20)
    def __str__(self):
        return self.complaint

class payment(models.Model):
    amount = models.CharField(max_length=20)
    date = models.CharField(max_length=20)
    payment_status = models.CharField(max_length=20)
    user = models.ForeignKey(user, on_delete=models.CASCADE)
    artist = models.ForeignKey(artist, on_delete=models.CASCADE)
    name = models.CharField(max_length=20)
    def __str__(self):
        return self.amount

class jobapply(models.Model):
    name = models.CharField(max_length=20)
    address = models.CharField(max_length=20)
    email = models.CharField(max_length=20)
    phn_no = models.CharField(max_length=20)
    qualification = models.CharField(max_length=20)
    experience = models.CharField(max_length=20)
    image = models.FileField(upload_to='images')
    user = models.ForeignKey(user, on_delete=models.CASCADE)
    def __str__(self):
        return self.name





