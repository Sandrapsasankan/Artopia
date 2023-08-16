from django.shortcuts import render,redirect
from . import models
from django.contrib.auth import authenticate,login as auth_login
from .models import job,user,artist,product,category,feedback

# Create your views here.
def login_page(request):
    return render(request,"login_page.html")

def admin_login(request):
    if request.method == 'POST':

        username=request.POST.get('username')
        password=request.POST.get('password')
        user = authenticate(username=username,password=password)
        
        if username=="adm" and password == "adm" :
            auth_login(request,user)
            return render(request,'dashboard.html')

        else:
            return redirect('login_page')

    else:
        return render(request,'login_page.html')
        

    
def dashboard(request):
    return render(request,"dashboard.html")

def adminapproveuser(request):
    data = user.objects.all()
    return render(request,"adminapproveuser.html",{'data':data})

def adminapproveartist(request):
    data = artist.objects.all()
    return render(request,"adminapproveartist.html",{'data':data})


def managecustomer(request):
    data = user.objects.all()
    return render(request,"managecustomer.html",{'data':data})

def admin_delete_customer(request,id):
    delmember = user.objects.get(id=id)
    print(delmember)
    delmember.delete()
    return redirect('managecustomer')

def admin_user_approve(request,id):
    accept = user.objects.get(id=id)
    accept.userstatus = 1
    accept.save()
    return redirect('managecustomer')

def manageartist(request):
    data = artist.objects.all()
    return render(request,"manageartist.html",{'data':data})

def admin_delete_artist(request,id):
    delmember = artist.objects.get(id=id)
    print(delmember)
    delmember.delete()
    return redirect('manageartist')

def admin_artist_approve(request,id):
    accept = artist.objects.get(id=id)
    accept.artiststatus = 1
    accept.save()
    return redirect('manageartist')

def managedelivery(request):
    return render(request,"managedelivery.html")

def Addjob(request):
    return render(request,"Addjob.html")

def adminAddjob(request):
    if request.method == 'POST':

        jobname=request.POST.get('jobname')
        description=request.POST.get('description')
        location=request.POST.get('location')
        experience=request.POST.get('experience')
        qualification=request.POST.get('qualification')
        salary=request.POST.get('salary')
        status="0"

        jobdetails = models.job(jobname=jobname, description=description, location=location, experience=experience, qualification=qualification, salary=salary, status=status)
        jobdetails.save()

        print('Job Added')
        return redirect('viewjob')

    else:
        return render(request,'Addjob.html')

def Addcategory(request):
    return render(request,"Addcategory.html")

def adminAddcategory(request):
    if request.method == 'POST' and request.FILES:

        name=request.POST.get('Category_name')
        image=request.FILES['image']
        category_status="0"

        categorydetails = models.category(name=name,  image=image, category_status=category_status)
        categorydetails.save()

        print('Category Added')
        return redirect('Viewcategory')

    else:
        return render(request,'Addcategory.html')

def managevideo(request):
    return render(request,"managevideo.html")

def Editjob(request):
    return render(request,"Editjob.html")

def admin_delete_job(request,id):
    delmember = job.objects.get(id=id)
    print(delmember)
    delmember.delete()
    return redirect('viewjob')

def admin_edit_job(request,id):
    Data = job.objects.get(id=id)
    return render(request,'Editjob.html',{'Data':Data})

def jobformupdate(request,id):
    if request.method=="POST":
        add=job.objects.get(id=id)
        add.jobname=request.POST["jobname"]
        add.description=request.POST["description"]
        add.location=request.POST["location"]
        add.experience=request.POST["experience"]
        add.qualification=request.POST["qualification"]
        add.salary=request.POST["salary"]
        add.save()
    return redirect("viewjob")


def viewjob(request):
    data = job.objects.all()
    return render(request,"viewjob.html",{'data':data})


def Editcategory(request):
    return render(request,"Editcategory.html")

def admin_delete_category(request,id):
    delmember = category.objects.get(id=id)
    print(delmember)
    delmember.delete()
    return redirect('Viewcategory')

def admin_edit_category(request,id):
    Data = category.objects.get(id=id)
    return render(request,'Editcategory.html',{'Data':Data})

def categoryformupdate(request,id):
    if request.method=="POST":
        add=category.objects.get(id=id)
        add.name=request.POST["name"]
        add.image=request.POST["image"]
        add.save()
    return redirect("Viewcategory")


def Viewcategory(request):
    data = category.objects.all()
    return render(request,"Viewcategory.html",{'data':data})

def viewproduct(request):
    data = product.objects.all()
    return render(request,"viewproduct.html",{'data':data})

def viewfeedback(request):
    data = feedback.objects.all()
    return render(request,"viewfeedback.html",{'data':data})





