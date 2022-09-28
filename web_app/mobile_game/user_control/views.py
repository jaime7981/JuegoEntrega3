from django.http import JsonResponse
import json
from .serializers import MyTokenObtainPairSerializer, PlayerSerializer, FriendRequestsSerializer
from rest_framework import viewsets
from rest_framework.permissions import AllowAny
from rest_framework_simplejwt.views import TokenObtainPairView
from .models import Player, FriendRequests

class MyObtainTokenPairView(TokenObtainPairView):
    permission_classes = (AllowAny,)
    serializer_class = MyTokenObtainPairSerializer


class PlayerViewSet(viewsets.ModelViewSet):
    queryset = Player.objects.all()
    serializer_class = PlayerSerializer

class FriendRequestsViewSet(viewsets.ModelViewSet):
    queryset = FriendRequests.objects.all()
    serializer_class = FriendRequestsSerializer


# Create your views here.
def login(request):
    response = {'response_type' : 'user control', 'response_data' : 'login_test'}
    return JsonResponse(response)

def registration(request):
    received_json_data = json.loads(request.body.decode("utf-8"))

    response = {'response_type' : 'user control', 'response_data' : 'registration_test', 'recieved_data' : received_json_data}
    return JsonResponse(response)

def logout(request):
    response = {'response_type' : 'user control', 'response_data' : 'logout_test'}
    return JsonResponse(response)
