from django.http import JsonResponse
import json

from rest_framework import viewsets, status, permissions
from rest_framework.views import APIView
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework_simplejwt.views import TokenObtainPairView

from django.contrib.auth.models import User
from .serializers import MyTokenObtainPairSerializer, PlayerSerializer, FriendRequestsSerializer, RegisterSerializer
from .models import Player, FriendRequests

class MyObtainTokenPairView(TokenObtainPairView):
    permission_classes = (permissions.AllowAny,)
    serializer_class = MyTokenObtainPairSerializer

class PlayerViewSet(viewsets.ModelViewSet):
    queryset = queryset = Player.objects.all()
    serializer_class = PlayerSerializer
    permission_classes = [permissions.AllowAny]

    def create(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)

    @action(methods=['get'], detail=True)
    def first_player(self, request, *args, **kwargs):
        items = Player.objects.get(user = User.objects.get(pk=1))
        serializer = PlayerSerializer(items)
        return Response(serializer.data)

class FriendRequestsViewSet(viewsets.ModelViewSet):
    permission_classes = [permissions.AllowAny]

    queryset = FriendRequests.objects.all()
    serializer_class = FriendRequestsSerializer
