from django.shortcuts import render
from django.http import JsonResponse

# Create your views here.
def login(request):
    response = {'response_type' : 'user control', 'response_data' : 'login_test'}
    return JsonResponse(response)

def registration(request):
    response = {'response_type' : 'user control', 'response_data' : 'registration_test'}
    return JsonResponse(response)

def logout(request):
    response = {'response_type' : 'user control', 'response_data' : 'logout_test'}
    return JsonResponse(response)