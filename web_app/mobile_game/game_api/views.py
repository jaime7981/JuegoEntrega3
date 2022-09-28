from django.shortcuts import render
from django.http import JsonResponse

# Create your views here.
def activeGames(request):
    response = {'response_type' : 'game api', 'response_data' : 'get active games'}
    return JsonResponse(response)

def joinGame(request):
    response = {'response_type' : 'game api', 'response_data' : 'join test'}
    return JsonResponse(response)
